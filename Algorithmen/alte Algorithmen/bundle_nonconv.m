function [ f_hat, x_hat ] = bundle_nonconv( x0, fun, subgr_fun, R_0)

% bundle algorihtm for nonconvex functions where all information is
% exact

%   Detailed explanation goes here
%   The Algorithm is implemented after the one in the paper "A redistributed
%   proximal bundle method for nonconvex optimization" by Warren Hare and
%   Claudia Sagastizábal, SIAM J. Optim, Vol.20, No. 5, pp. 2442 - 2473, 2010. 
%   It is a bundle algorithm that can minimize nonsmooth nonconvex functions.
%   At least one element of the subdifferential has to be known at any
%   x-value

%   Input parameter
%       x0          starting value
%       fun         function to be minimized (can be nonsmooth, must be convex)
%       subgr_fun   function that contains the subgradient of the objective
%                   function

%   Output parameter
%       f_hat       optimal function value
%       x_hat       argmin of the objective



% set global constants
    kmax = 100; % maximum number of iterations; > 0
    M = 10;     % unacceptable growth parameter; > 0
    tol = 1e-6; % stopping tolerance; > 0
    m = 0.05;   % Armijo-like parameter; in (0, 1)
    Gamma = 2;  % convexification growth parameter; > 1
    % try gamma from inexact version of algorithm, should work better
    gamma = 2;  % convexification growth parameter; > 0
    
    
% BEGINNING of the algorithm

%% 0 step
tic;

n = length(x0);
i_null = 0;      % null-step counter
i_null_new = 0;  % counts null-steps since the last serious step

% generate sparse matrices to store J, x, f, s and the linearization error
% c as bundle information
x = sparse(n, kmax);
f = sparse(1, kmax);
g = sparse(n, kmax);
e = sparse(kmax, 1); 
c = sparse(kmax, 1);
J = sparse(1, kmax);

x(:, 1) = x0;     % trial points, important for bundle information
x_hat = x0;       % "serous" points
e(1) = 0;         % "augmented" lineariztion error     
c(1) = 0;
J(1) = 1;         % Index set
J_full = 1;   
f(1) = feval(fun, x0);
f_hat = full(f(1));
g(:, 1) = feval(subgr_fun, x0);
eta = 0;
mu = R_0;

lJ = nnz(J);

%% Global loop

for k = 1 : kmax;

%% 1st step

% "condense" sparse matrices, to get the bundle information in a full
% matrix of the right size
g_full = full(g(:, J_full));
c_full = full(c(J_full));

s = g_full + eta * (full(x(:, J_full)) - repmat(x_hat, 1, lJ));



xi_s0 = zeros(n + 1, 1);  % starting point
H = [zeros(n + 1, 1), [zeros(1, n); mu * eye(n)]];
r = [1; zeros(n, 1)];
A = [-ones(lJ, 1), s'];
b = c_full;
%options_as = optimoptions(@quadprog, 'Algorithm', 'active-set');
% IP seems to give better results for n = 1
options_ip = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex'); % starting point ignared in this option
[xi_d, ~, ~, ~, lambda] = quadprog(H, r, A, b, [], [], [], [], xi_s0, options_ip);

alpha_full = lambda.ineqlin; % lagrange multiplier for inequality constraints
alpha = sparse(J_full, 1, alpha_full); 

%xi = xi_d(1);
d = xi_d(2 : n + 1);

x_k_1 = x_hat + d;
x(:, k + 1) = x_k_1;

phi_k = @(y) f_hat + max(max(-c_full + s' * (y - x_hat))); % reicht ein max?

delta = f_hat + eta / 2 * norm(x_k_1 - x_hat)^2 - phi_k(x_k_1);


%% 2nd step

if delta <= tol;
   fprintf('algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k, i_null);
   break % result is x_hat from step before???
end 

%% 3rd step

f(k + 1) = feval(fun, x(:, k + 1));
g(:, k + 1) = feval(subgr_fun, x(:, k + 1));

if f(k + 1) - f_hat <= -m * delta;   % serious step
    i_null_new = 0;
    x_hat = full(x(:, k + 1));
    f_hat =  full(f(k + 1));
    for j = J_full';
       if alpha(j) > 1e-9;  % what is sensible? not too big but not too small?
       else J(j) = 0;
            f(j) = 0;
            x(:,j) = zeros(n, 1);
            g(:,j) = zeros(n, 1);
       end
    end
    J(k + 1) = k + 1;
else                            % null step
    i_null = i_null + 1;
    i_null_new = i_null_new + 1;
    for j = J_full';
       if alpha(j) > 1e-9 || j == k - i_null_new + 1   % what is sensible? not too big but not too small?
       else J(j) = 0;
            f(j) = 0;
            x(:,j) = zeros(n,1);
            g(:,j) = zeros(n,1);
       end
     end
     J(k + 1) = k + 1;        
end

J_full = nonzeros(J);
lJ = nnz(J);
    
    eta_j = 0;
for j = J_full';
    % calculate eta like in nonconv_inexact-paper
    e(j) = f_hat - full(f(j)) - full(g(:, j))' * (x_hat - full(x(:, j)));
    if j ~= k - i_null_new + 1
    eta_j = max(eta_j, -2 * e(j) / norm(full(x(:, j)) - x_hat)^2);
    end
end

eta = eta_j + gamma;

for j = J_full';
    c(j) = e(j) + eta / 2 * norm(full(x(:, j)) - x_hat)^2;
end

    
%% 4th step

if f(k+1) > f_hat + M;
    eta_0 = eta;
    mu_0 = Gamma * mu;
    R_0 = eta_0 + mu_0;
    disp('Restart of the function.')
    [ f_hat, x_hat ] = bundle_nonconv( x_hat, fun, subgr_fun, R_0)
end


toc;
% END of the algorithm
end

