function [ f_hat, x_hat ] = bundle_conv_inex( x0, fun, subgr_fun)

% bundle algorihtm for nonconvex functions where all information is
% exact

%   Detailed explanation goes here
%   The Algorithm is implemented after the one in the paper "Convex proximal
%   bundle methods in depth: a unified analysis for inexact oracles" by
%   W. de Oliveira, C. Sagastizábal and C. Lemaréchal, Springer, Math. Program.,
%   Ser. B, 2014.
%   It is a bundle algorithm that can minimize nonsmooth convex functions with 
%   inexact function and subgradient information.
%   At least one element of the approximated subdifferential has to be known at any
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
    m = 0.5;        % eta in (0, 1)
    tol = 1e-6;     % tolerance for termainating the algorithm
    kmax = 100;     % maximum number of iterations
    
% BEGINNING of the algorithm

%% 0 step
tic;

n = length(x0);
i_null = 0;      % null-step counter
i_null_new = 0;  % counts null-steps since the last serious step

t = 0.7;         % prox-parameter

% generate sparse matrices to store J, x, f, g and the linearization error
% c as bundle information

x = sparse(n, kmax);
f = sparse(1, kmax);
g = sparse(n, kmax);
c = sparse(kmax, 1); 
J = sparse(1, kmax);    % better J this way or only nonzero entries?

x(:, 1) = x0;     % trial points, important for bundle information
x_hat = x0;       % "serious" points
c(1) = 0;         % lineariztion error, in lecture notes alpha     
J(1) = 1;         % index set
J_full = 1;
f(1) = feval(fun, x0);
f_hat = full(f(1));
g(:, 1) = feval(subgr_fun, x0);
g_hat = full(g(:, 1));

beta = 0.5;

lJ = nnz(J);

%% Global loop

for k = 1 : kmax;

%% 1st step

% "condense" sparse matrices, to get the bundle information in a full
% matrix of the right size
g_full = full(g(:, J_full));
c_full = full(c(J_full));

xi_s0 = zeros(n + 1, 1);  % starting point, zero always feasible, because a in convex case always >= 0 
H = [zeros(n + 1, 1), [zeros(1, n); eye(n)]];
r = [1; zeros(n, 1)];
A = [-ones(lJ, 1), g_full'];
b = c_full;
%options_as = optimoptions(@quadprog, 'Algorithm', 'active-set');
% IP seems to give better results for n = 1
options_ip = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex'); % starting point ignared in this option
[xi_d, ~, ~, ~, lambda] = quadprog(H, r, A, b, [], [], [], [], xi_s0, options_ip);

alpha_full = lambda.ineqlin; % lagrange multiplier for inequality constraints
alpha = sparse(J_full, 1, alpha_full); 

%% 2nd step

xi = xi_d(1);
d = xi_d(2 : n + 1);

E = alpha_full' * c_full;

x(:, k + 1) = x_hat + t * d;
x_k_1 = full(x(:, k + 1));
f(k + 1) = feval(fun, x(:, k + 1));
g(:, k + 1) = feval(subgr_fun, x(:, k + 1));

%% noise attenuation

e_hat = f_hat - f_m - t * norm(g_hat)^2; % compare to E in nonconv_inex
f_m = f_hat + max(-c_full + g' * (x_k_1 - x_hat));
phi = f_hat - f_m  + g_hat' * x_k_1;

if e_hat < -beta * t * norm(g_hat)^2;
    t = 1.5 * t;
end

%% 3rd step

if norm(d) <= tol && E <= tol;
   fprintf('algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k, i_null);
   break
end
 
%% 4th, 5th step

if f(k + 1) - f_hat <= m * xi;   % serious step
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

%% 6th step


for j = J_full';
    c(j) = f_hat - full(f(j)) - full(g(:, j))' * (x_hat - full(x(:, j)));
end

end
toc;
% END of the algorithm
end

