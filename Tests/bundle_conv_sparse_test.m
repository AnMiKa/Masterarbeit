function [ f_hat, x_hat, alpha_nonneg, alpha_equ_one,  alpha_small, e_veryneg, e_changed, k ] = ...
    bundle_conv_sparse_test( x0, fun, subgr_fun, e_change, kmax, m, t, tol)
% test version od the function bundle_conv_sparse
% uses additional counter etc. to check if everything is calculated as
% expected

% simple bundle algorihtm for convex functions where all information is
% exact

% Detailed explanation
% The Algorithm is implemented after the one in the lecture "Nichtglatte
% Optimierung" at TUM, in summer semester 2016 by Professor Ulbrich.
% It is a bundle algorithm that can minimize nonsmooth convex functions.
% The at least one element of the subdifferential has to be known at any
% x-value.

% Input parameter
%       x0          starting value
%       fun         function to be minimized (can be nonsmooth, must be convex)
%       subgr_fun   function that can evaluate a subgradient of fun at every 
%                   given point x. 

%   Output parameter
%       f_hat       optimal function value
%       x_hat       argmin of the objective

%% set x0 as column-vector, regardless of how it is typed in
[rows, columns] = size(x0);
if rows == 1;
    x0 = x0';
end
if rows ~= 1 && columns ~=1;
       fprintf('Error! Wrong starting point x0. x0 must be a vector.');
       return
end    

%% set default values

% set default values for the optional input arguments kmax, m, 
% t and tol
% kmax > 0      maximum number of iterations
% m in (0, 1)   
% t > 0         prox / convexification parameter of the subproblem
% tol:          tolerance for terminating the algorithm
defaults = {1000, 0.5, 1, 1e-6};
% set optional input arguments if not set by the user
% Check number of inputs.
if nargin > 8
    error('Too many input arguments: requires at most 4 optional inputs');
end

% Fill in unset optional values.
switch nargin
    case 4
        [kmax, m, t, tol] = defaults{:};
    case 5
        [m, t, tol] = defaults{2:4};
    case 6
        [t, tol] = defaults{3:4};
    case 7
        tol = defaults{4};
end
    
%% BEGINNING of the algorithm
%% 0 step
tic;

% counters for testing
alpha_nonneg = 0;
alpha_equ_one = 0;
alpha_small = 0;
e_veryneg = 0;
e_changed = 0;

n = length(x0);
i_null = 0;      % null-step counter
i_null_new = 0;  % counts null-steps since the last serious step

% generate sparse matrices to store J, x, f, g and the linearization error
% e as bundle information

x = sparse(n, kmax);
f = sparse(1, kmax);
g = sparse(n, kmax);
e = sparse(kmax, 1); 
J = sparse(1, kmax);    % better J this way or only nonzero entries?

x(:, 1) = x0;     % trial points, important for bundle information
x_hat = x0;       % "serious" point
e(1) = 0;         % lineariztion error, in lecture notes alpha     
J(1) = 1;         % index set
J_full = 1;
f(1) = feval(fun, x0);
f_hat = full(f(1));
g(:, 1) = feval(subgr_fun, x0);

lJ = nnz(J);

%% Global loop
for k = 1 : kmax;

%% 1st step

% "condense" sparse matrices, to get the bundle information in a full
% matrix of the right size
g_full = full(g(:, J_full));
e_full = full(e(J_full));

% solve the following quadratic subproblem for d:
% d = argmin{xi + 1/(2 * t) * norm(d)^2} s.t. g_j'*d - e_j - xi <= 0, for all j in J
% reformultate the problem to use it in quadprog to
% f = 1/2*x*H*x+r*x, s.t. A*x <= b
xi_s0 = zeros(n + 1, 1);  % starting point, zero always feasible, because a in convex case always >= 0 
H = [zeros(n + 1, 1), [zeros(1, n); 1/t * eye(n)]];
r = [1; zeros(n, 1)];
A = [-ones(lJ, 1), g_full'];
b = e_full;
%options_as = optimoptions(@quadprog, 'Algorithm', 'active-set');
% IP seems to give better results for n = 1
options_ip = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
    'MaxIterations', 500, 'ConstraintTolerance', 1.0000e-08, 'OptimalityTolerance', 1.0000e-06);
[xi_d, ~, ~, ~, lambda] = quadprog(H, r, A, b, [], [], [], [], xi_s0, options_ip);

alpha_full = lambda.ineqlin; % lagrange multiplier for inequality constraints
alpha = sparse(J_full, 1, alpha_full);

if max(alpha_full < 0)
    alpha_nonneg = alpha_nonneg + 1;
end
if min(alpha_full) < 1e-9
    alpha_small = alpha_small +1;
end
if abs(sum(alpha_full) - 1) > 1e-6
    alpha_equ_one = alpha_equ_one + 1;
end

%% 2nd step
xi = xi_d(1);
d = xi_d(2 : n + 1);
E = alpha_full' * e_full;
G = g_full * alpha_full;  % aggregate subgradient

%% 3rd step

% stopping conditions
if norm(1/t * d) <= tol && E <= tol;  % stopping condition like in lecture
% if norm(G) <= tol && E <= tol;  % stopping condition like in lecture
% if norm(E + G * x_hat) <= tol and E <= tol;  % stopping condition like in conv, inex
% if norm() <= tol;  % stopping condition like in nonconv, exact ???
% if norm(E + t * G) <= tol;  % stopping condition like in nonconv, inex
    fprintf('algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k, i_null);
    break
end

%% 4th, 5th step
x(:, k + 1) = x_hat + d;
f(k + 1) = feval(fun, x(:, k + 1));
g(:, k + 1) = feval(subgr_fun, x(:, k + 1));

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
    e(j) = f_hat - full(f(j)) - full(g(:, j))' * (x_hat - full(x(:, j)));
    if e(j) < -tol * 1e-3
        e_veryneg = e_veryneg + 1;
    end
    if e_change
        if e(j) < 0
            e(j) = 0;
            e_changed = e_changed +1;
        end
    end
end


end
toc;
if k == kmax
    fprintf('algorithm stopped bcause the maximum number %d of iterations was reached \n', k);
end
%% END of the algorithm
end

