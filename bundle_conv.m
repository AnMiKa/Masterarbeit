function [ f_hat, x_hat ] = bundle_conv( x0, fun, subgr_fun, kmax, m, t, tol)

% simple bundle algorihtm for convex functions where all information is
% exact

% Detailed explanation
% The Algorithm is implemented after the one in the lecture "Nichtglatte
% Optimierung" at TUM, in summer semester 2016 by Professor Ulbrich.
% It is a bundle algorithm that can minimize nonsmooth convex functions.
% At least one element of the subdifferential has to be known at any
% x-value.

% Input parameters
%       x0          starting value
%       fun         function to be minimized (can be nonsmooth, must be convex)
%       subgr_fun   function that can evaluate a subgradient of fun at every 
%                   given point x. 
% Optional intut parameters
%       kmax        maximum number of iterations
%       m           descent parameter
%       t           prox parameter of the subproblem
%       tol         stopping tolerance of the algorithm

%   Output parameters
%       f_hat       optimal function value
%       x_hat       argmin of the objective

%% set x0 as column-vector, regardless of how it is typed in
[rows, columns] = size(x0);
if rows == 1;
    x0 = x0';
end
if rows ~= 1 && columns ~=1;
       error('Wrong starting point x0. x0 must be a vector.');
end

%% set default values

% set default values for the optional input arguments kmax, m, 
% t and tol
% kmax > 0      maximum number of iterations
% m in (0, 1)   descent parameter
% t > 0         prox parameter of the subproblem
% tol           stopping tolerance of the algorithm
defaults = {1000, 0.05, 1, 1e-6};
% set optional input arguments if not set by the user
% default values correspond to those in the "nonconvex-inexact" paper
% Check number of inputs.
if nargin > 7
    error('Too many input arguments: requires at most 4 optional inputs');
end

% Fill in unset optional values.
switch nargin
    case 3
        [kmax, m, t, tol] = defaults{:};
    case 4
        [m, t, tol] = defaults{2:4};
    case 5
        [t, tol] = defaults{3:4};
    case 6
        tol = defaults{4};
end

%% BEGINNING of the algorithm
%% 0 step
tic;

n = length(x0);
i_null = 0;              % null-step counter

x = x0;                  % trial points, important for bundle information
x_hat = x0;              % proximal center / serious point
e = 0;                   % linearization error, in lecture notes alpha
J = 1;                   % index set defining bundle information
lJ = 1;                  % initial lenght of the index set J
f = feval(fun, x0);      % exact function evaluation
f_hat = f;               % function evaluation at x_hat
g = feval(subgr_fun, x0);% one subgradient at point x

%% Global loop
for k = 1 : kmax;

%% 1st step: subproblem solving

% solve the following quadratic subproblem for d:
% d = argmin{xi + 1/(2 * t) * norm(d)^2} s.t. g_j'*d - e_j - xi <= 0, for all j in J
% reformultate the problem to use it in quadprog to
% f = 1/2*x*H*x+r*x, s.t. A*x <= b
xi_d0 = zeros(n + 1, 1);  % starting point is optional and only used if the active set method is chosen
H = [zeros(n + 1, 1), [zeros(1, n); 1/t * eye(n)]];
r = [1; zeros(n, 1)];
A = [-ones(lJ, 1), g'];
b = e;
options_ip = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
    'MaxIterations', 500, 'ConstraintTolerance', 1.0000e-10, 'OptimalityTolerance', 1.0000e-10);
[xi_d, ~, ~, ~, lambda] = quadprog(H, r, A, b, [], [], [], [], xi_d0, options_ip);

alpha = lambda.ineqlin; % lagrange multiplier for inequality constraints


%% 2nd step: calculation of aggregate objects
xi = xi_d(1);
d = xi_d(2 : n + 1);
E = alpha' * e;  % aggregate error
G = g * alpha;  % aggregate subgradient

%% 3rd step: stopping test

% stopping conditions
if norm(1/t * d) <= tol && E <= tol;  % stopping condition like in lecture
% if norm(G) <= tol && E <= tol;  % stopping condition like in lecture
% if norm(E + G * x_hat) <= tol and E <= tol;  % stopping condition like in conv, inex
% if norm() <= tol;  % stopping condition like in nonconv, exact ???
% if norm(E + t * G) <= tol;  % stopping condition like in nonconv, inex
    fprintf('algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k, i_null);
    break
end
 
%% 4th step: preparing the bundle
f_k_1 =  feval(fun, x_hat + d);  % evaluate function at new iterate
f = [f, f_k_1];  % add information to bundle
g = [g, feval(subgr_fun, x_hat + d)];  % evaluate subgradient at new iterate and add information to bundle
x = [x, x_hat + d];  % add new iterate to bundle

%% 5th step: serious step test
%serious step  test
if f_k_1 - f_hat <= m * xi;   % serious step condition
    fprintf('serious step: f_hat:  %d  f(k+1): %d \n', f_hat, f_k_1);
    x_hat = x_hat + d;   % update x_hat
    f_hat =  f_k_1;  % update f_hat
else
    fprintf('null step: f_hat:  %d  f(k+1): %d \n', f_hat, f_k_1);
    i_null = i_null + 1;
end

%update bundle
delete = zeros(1,lJ);
for j = 1:lJ;  % update the index set J by marking the indexes that are removed
    if alpha(j) > 1e-9 || norm(x(j) - x_hat) == 0; % alpha only gets down to 1e-5
    else
        delete(j) = 1;
    end
end
J(delete == 1) = [];
f(delete == 1) = [];
x(:,delete == 1) = [];
g(:,delete == 1) = [];  % remove all marked objects from the bundle
J = [J, k+1];                           
    
%% 6th step: calculation of linearization errors
lJ = length(J);  % length of the index set J, e.g. for size of constraints in subproblem
e = zeros(lJ, 1);
for j = 1:lJ;
    e(j) = f_hat - f(j) - g(:, j)' * (x_hat - x(:, j));  % update linearization error e
end

end
toc;
if k == kmax
    fprintf('algorithm stopped bcause the maximum number %d of iterations was reached \n', k);
end
%% END of the algorithm
end

