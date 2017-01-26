function [ f_hat, x_hat, delta ] = ...
    bundle_nonconv_ex_t( x0, fun, subgr_fun, kmax, m, t, tol, gamma, M)

% proximal bundle algorihtm that can also handle nonconvex functions, but all
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
% This version incorporates also the update for t and R.

% Input parameter
%       x0          starting value
%       fun         function to be minimized (can be nonsmooth, must be convex)
%       subgr_fun   function that can evaluate a subgradient of fun at every 
%                   given point x.
%       other input parameter are optional and explained below

%   Output parameter
%       f_hat       optimal function value
%       x_hat       argmin of the objective
%       delta       last delta in algorithm

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
% M > 0         inacceptable increase Parameter
% R > 0         overall convexification parameter, = eta + 1/t
defaults = {1000, 0.05, 0.1, 1e-6, 2, 10};
% set optional input arguments if not set by the user
% default values correspond to those in the "nonconvex-inexact" paper
% Check number of inputs.
if nargin > 9
    error('Too many input arguments: requires at most 6 optional inputs.');
end

% Fill in unset optional values.
switch nargin
    case 3
        [kmax, m, t, tol, gamma, M] = defaults{:};
    case 4
        [m, t, tol, gamma, M] = defaults{2:6};
    case 5
        [t, tol, gamma, M] = defaults{3:6};
    case 6
        [tol, gamma, M] = defaults{4:6};
    case 7
        [gamma, M] = defaults{5:6};
    case 8
        M = defaults{6};
end

%% BEGINNING of the algorithm
%% 0 step
tic;

n = length(x0);
i_null = 0;              % null-step counter
restart = 0;                % restarting counter

R = 1/t;  % over all convexifivation parameter, at the moment needed for stopping test

x = x0;                  % trial points, important for bundle information
x_hat = x0;              % "serious" point
eta = 0;                 % convexification parameter for modelfunction
c = 0;                   % augmented linearization error (error of convexified model-function)
J = 1;                   % index set defining bundle information
lJ = 1;                  % initial lenght of the index set J
f = feval(fun, x0);      % exact function evaluation
f_hat = f;               % function evaluation as x_hat
g = feval(subgr_fun, x0);% one  subgradient at point x
s = g;                   % augmented subgradient at point x
%% Global loop
for k = 1 : kmax;

%% 1st step: subproblem solver

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
options_ip = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
    'MaxIterations', 500, 'ConstraintTolerance', 1.0000e-12, 'OptimalityTolerance', 1.0000e-12,...
    'StepTolerance', 1.000e-10);
[xi_d, ~, ~, ~, lambda] = quadprog(H, r, A, b, [], [], [], [], xi_d0, options_ip);

alpha = lambda.ineqlin; % lagrange multiplier for inequality constraints


%% 2nd step: aggregated objects
xi = xi_d(1);
d = xi_d(2 : n + 1);
C = alpha' * c;  % augmented aggregate error
G = g * alpha;  % aggregate subgradient
S = s * alpha;  % augmented aggregate subgradient

%% 3rd step: stopping test
mk = max(-c + s'*d);
%delta = (R + 1/t) /2 * norm(d)^2 + C;
%delta = - xi + eta/2 * norm(d)^2;
delta = f_hat - mk +  eta/2 * norm(d)^2;
% stopping conditions
% different stopping conditions corresponding to different papers and to
% different formulations of the variables used
%if norm(1/t * d) <= tol && E <= tol;  % stopping condition like in lecture
%if norm(G) <= tol && E <= tol;  % stopping condition like in lecture
%if norm(E + G * x_hat) <= tol and E <= tol;  % stopping condition like in conv, inex
if delta <= tol;  % stopping condition like in nonconv, exact
%if   -xi + eta / 2 * norm(d)^2 <= tol; % stopping condition like in nonconv, exact, nor rewritten
%if norm(E + t * G) <= tol;  % stopping condition like in nonconv, inex
    fprintf('Algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k, i_null);
    break
end
 
%% 4th step: calculating the new values
% evaluate function and subgradient
f_k_1 =  feval(fun, x_hat + d);  % evaluate function at new iterate
f = [f, f_k_1];  % add information to bundle
g = [g, feval(subgr_fun, x_hat + d)];  % evaluate subgradient at new iterate and add information to bundle
x = [x, x_hat + d];  % add new iterate to bundle

%% 5th step: bundle update
%serious step  test
if f_k_1 - f_hat <= m * (-xi + eta / 2 * norm(d)^2);   % serious step condition
    x_hat = x_hat + d;   % update x_hat
    f_hat =  f_k_1;  % update f_hat
else
    i_null = i_null + 1;
end

%update bundle
% 1st variant: keep all bundle elements
% J = [J, k+1];                           

% 2nd variant: keep all active elements
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
    
%% 6th step: calculate (augmented) linearization errors
lJ = length(J);  % length of the index set J, e.g. for size of constraints in subproblem
e = zeros(lJ, 1);
eta_vec = zeros(lJ, 1);
for j = 1:lJ;
    e(j) = f_hat - f(j) - g(:, j)' * (x_hat - x(:, j));  % update linearization error e
    if norm(x(:,j) - x_hat) ~= 0
        eta_vec(j) = -2 * e(j) / norm(x(:,j) - x_hat)^2;
    else eta_vec(j) = 0;
    end
end
eta = max(eta_vec) * gamma;
R = 1/t + eta;

b = zeros(lJ, 1);
for j = 1:lJ
    b(j) = eta/2 * norm(x(:,j) - x_hat)^2;
end
c = e + b;
s = g + eta * bsxfun(@minus, x, x_hat);

%% 7th step: restart algorithm if increase of objective function intolerably high
if f_k_1 > f_hat + M
    t = t/gamma;
    R = eta + 1/t;
    c = 0;
    J = 1;               
    lJ = 1;
    f = feval(fun, x_hat);      
    f_hat = f;               
    g = feval(subgr_fun, x_hat);
    s = g;
    x = x_hat;
    restart = restart + 1;
    k = 0;
    fprintf('Algorithm was restarted.');
    pause
end
end
toc;
if k == kmax
    fprintf('Algorithm stopped bcause the maximum number %d of iterations was reached, %d null steps were executed. \n', k, i_null);
end
%% END of the algorithm
end

