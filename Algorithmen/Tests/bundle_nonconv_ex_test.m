function [ f_hat, x_hat, deltas_noneq, xi_exp1, xi_exp2, xi_exp3, C_exp, alpha_nonneg, ...
    alpha_equ_one, alpha_small, c_neg, e_how_neg, eta_how_big, k, s_equ_d ] = ...
    bundle_nonconv_ex_test( x0, fun, subgr_fun, kmax, m, t, tol, gamma)
% test version of the function bundle_conv_sparse
% uses additional counter etc. to check if everything is calculated as
% expected

% bundle algorihtm that can also handle nonconvex functions, but all
% information is has to be exact

% Detailed explanation
% The Algorithm is implemented roughly after the one in the paper "A redistributed
% proximal bundle method for nonconvex optimization" by Warren Hare and
% Claudia Sagastizabal.
% Some things are solved differently with regard to the algorithm that also
% coveres inexact information.
% This is a bundle algorithm that can minimize nonsmooth convex functions.
% At least one element of the subdifferential has to be known at any
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
% m in (0, 1)   Armijo-like parameter
% t > 0         prox / convexification parameter of the subproblem
% tol:          tolerance for terminating the algorithm
defaults = {1000, 0.05, 0.1, 1e-6, 2};
% set optional input arguments if not set by the user
% default values correspond to those in the "nonconvex-inexact" paper
% Check number of inputs.
if nargin > 8
    error('Too many input arguments: requires at most 5 optional inputs');
end

% Fill in unset optional values.
switch nargin
    case 3
        [kmax, m, t, tol, gamma] = defaults{:};
    case 4
        [m, t, tol, gamma] = defaults{2:5};
    case 5
        [t, tol, gamma] = defaults{3:5};
    case 6
        [tol, gamma] = defaults{4:5};
    case 7
        gamma = defaults{5};
end

%% BEGINNING of the algorithm
%% 0 step
tic

% counters for testing
deltas_noneq = 0;
alpha_nonneg = 0;
alpha_equ_one = 0;
alpha_small = 1;
c_neg = 0;
e_how_neg = 0;
eta_how_big = 0;
s_equ_d = 0;
xi_exp1 = 0;
xi_exp2 = 0;
xi_exp3 = 0;
C_exp = 0;


n = length(x0);
i_null = 0;              % null-step counter

R = 1/t;                 % over all convexifivation parameter, at the moment needed for stopping test

x = x0;                  % trial points, important for bundle information
x_hat = x0;              % "serious" point
eta = 0;                 % convexification parameter for modelfunction
e = 0;
c = 0;                   % augmented linearization error (error of convexified model-function)
J = 1;                   % index set defining bundle information
lJ = 1;                  % initial lenght of the index set J
f = feval(fun, x0);      % exact function evaluation
f_hat = f;               % function evaluation as x_hat
g = feval(subgr_fun, x0);% one  subgradient at point x
s = g;                   % augmented subgradient at point x
%% Global loop
for k = 1 : kmax;

%% 1st step

% calculate augmented subgradient and linearization error (corresponds to
% subgradient and linearization error of the confexified modelfunction)

% solve the following augmented quadratic subproblem for d:
% d = argmin{xi + 1/(2 * t) * norm(d)^2} s.t. s_j'*d - c_j - xi <= 0, for all j in J
% reformultate the problem to use it in quadprog to
% f = 1/2*x*H*x+r*x, s.t. A*x <= b
xi_d0 = zeros(n + 1, 1);  % starting point is optional and only used if the active set method is chosen
H = [zeros(n + 1, 1), [zeros(1, n); 1/t * eye(n)]];
r = [1; zeros(n, 1)];
A = [-ones(lJ, 1), s'];
b = c;
%options_as = optimoptions(@quadprog, 'Algorithm', 'active-set');
options_ip = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
    'MaxIterations', 500, 'ConstraintTolerance', 1.0000e-10, 'OptimalityTolerance', 1.0000e-10);
[xi_d, ~, ~, ~, lambda] = quadprog(H, r, A, b, [], [], [], [], xi_d0, options_ip);

alpha = lambda.ineqlin; % lagrange multiplier for inequality constraints

if max(alpha < 0)
    alpha_nonneg = alpha_nonneg + 1;
end
if abs(sum(alpha) - 1) > alpha_equ_one
    alpha_equ_one = abs(sum(alpha) - 1);
end
if min(alpha) ~= 0 && min(alpha) < alpha_small
    alpha_small = min(alpha);
end

%% 2nd step
xi = xi_d(1);
d = xi_d(2 : n + 1);
E = alpha' * e;
C = alpha' * c;  % augmented aggregate error
G = g * alpha;  % aggregate subgradient
S = s * alpha;  % augmented aggregate subgradient

if norm(S + 1/t * d) > s_equ_d
    s_equ_d = norm(S + 1/t * d);
end    

%% 3rd step

delta1 = (R + 1/t) /2 * norm(d)^2 + C;
delta2 = - xi + eta/2 * norm(d)^2;
% stopping conditions
%if norm(1/t * d) <= tol && E <= tol;  % stopping condition like in lecture
% if norm(G) <= tol && E <= tol;  % stopping condition like in lecture
% if norm(E + G * x_hat) <= tol and E <= tol;  % stopping condition like in conv, inex
% if delta1 <= tol;  % stopping condition like in nonconv, exact
if delta2 <= tol;  % stopping condition like in nonconv, exact, other formulation for delta
% if   -xi + eta / 2 * norm(d)^2 <= tol; % stopping condition like in nonconv, exact, nor rewritten
% if norm(E + t * G) <= tol;  % stopping condition like in nonconv, inex
    fprintf('algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k, i_null);
    break
end
xM = bsxfun(@minus, x, x_hat);
 xx = zeros(lJ,1);
for j = 1:lJ
   xx(j) = xM(:,j)'*xM(:,j);
end
   
if C_exp < abs(C - E - eta / 2 * alpha' *  xx)
    C_exp = abs(C - E - eta / 2 * alpha' *  xx);
end

mk = max(-c + s'*d);

% if xi_exp1 < abs(xi + 1/t * norm(d)^2 + C)
%     xi_exp1 = abs(xi + 1/t * norm(d)^2 + C);
% end
if xi_exp1 < abs(xi - S'*d + C)
    xi_exp1 = abs(xi - S'*d + C);
end
if xi_exp2 < abs(xi - mk)
    xi_exp2 = abs(xi - mk);
end
% if xi_exp3 < abs(mk + 1/t * norm(d)^2 + C)
%     xi_exp3 = abs(mk + 1/t * norm(d)^2 + C);
% end
if xi_exp3 < abs(mk - S'*d + C)
    xi_exp3 = abs(mk - S'*d + C);
end

if deltas_noneq < abs(delta1 - delta2)
    deltas_noneq = abs(delta1 - delta2);
end

%% 4th, 5th step
% evaluate function and subgradient
f_k_1 =  feval(fun, x_hat + d);  % evaluate function at new iterate
f = [f, f_k_1];  % add information to bundle
g = [g, feval(subgr_fun, x_hat + d)];  % evaluate subgradient at new iterate and add information to bundle
x = [x, x_hat + d];  % add new iterate to bundle

%serious step  test
if f_k_1 - f_hat <= m * (-xi + eta / 2 * norm(d)^2);   % serious step condition
    x_hat = x_hat + d;   % update x_hat
    f_hat =  f_k_1;  % update f_hat
else
    i_null = i_null + 1;
end

%update bundle
delete = zeros(1,lJ);
for j = 1:lJ;  % update the index set J by marking the indexes that are removed
    if alpha(j) > 1e-9 || norm(x(:,j) - x_hat) == 0; % alpha only gets down to 1e-5
    else
        delete(j) = 1;
    end
end
J(delete == 1) = [];
f(delete == 1) = [];
x(:,delete == 1) = [];
g(:,delete == 1) = [];  % remove all marked objects from the bundle
J = [J, k+1];                           
    
%% 6th step
lJ = length(J);  % length of the index set J, e.g. for size of constraints in subproblem
e = zeros(lJ, 1);
eta_vec = zeros(lJ, 1);
for j = 1:lJ;
    e(j) = f_hat - f(j) - g(:, j)' * (x_hat - x(:, j));  % update linearization error e
    if e(j) < 0 && e(j) < e_how_neg
        e_how_neg = e(j);
    end
    if norm(x(:,j) - x_hat) ~= 0
        eta_vec(j) = -2 * e(j) / norm(x(:,j) - x_hat)^2;
    else eta_vec(j) = 0;
    end
end
eta = max(eta_vec) + gamma; % like in nonconvex, inexact because more stable
if eta > eta_how_big
    eta_how_big = eta;
end
R = 1/t + eta;

b = zeros(lJ, 1);
for j = 1:lJ
    b(j) = eta/2 * norm(x(:,j) - x_hat)^2;
end

c = e + b;

if c < 0
    c_neg = c_neg + 1;
end
s = g + eta * bsxfun(@minus, x, x_hat); 

% update t??? the way to update mu = 1/t in the paper not used here
% maybe add trust region kind of update for t?


end

if k == kmax
    fprintf('algorithm stopped bcause the maximum number %d of iterations was reached \n', k);
end

%% END of the algorithm
end

