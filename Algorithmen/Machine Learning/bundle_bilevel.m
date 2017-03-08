function [ f_hat, x_hat, delta ] = bundle_bilevel( x0, X, Y, kmax, m, t, tol, gamma)


% Input parameters
%       x0          starting value
%       fun         function to be minimized (can be nonsmooth, must be convex)
%       subgr_fun   function that can evaluate a subgradient of fun at every 
%                   given point x. 
% optional input parameters
%       kmax        maximum number of iterations
%       m           descent parameter
%       t           prox parameter
%       tol         tolerance for stopping test
%       gamma       saveguarding value for calculating eta

%   Output parameters
%%%       f_hat       optimal function value
%       x_hat       argmin of the objective
%       delta       last delta

%% set x0 as column-vector, regardless of how it is typed in
[rows, columns] = size(x0);
if rows == 1;
    x0 = x0';
end
% check that x0 is a vector
if rows ~= 1 && columns ~=1;
       error('Wrong starting point x0. x0 must be a vector.');
end

%% set default values

% set default values for the optional input arguments kmax, m, 
% t, tol and gamma
% values for m, gamma and t taken prom paper
% kmax > 0      maximum number of iterations
% m in (0, 1)   Armijo-like descent parameter
% t > 0         prox / convexification parameter of the subproblem
% tol           tolerance for terminating the algorithm
% gamma > 0     saveguarding parameter for calculating eta

defaults = {1000, 0.05, 0.1, 1e-6, 2};
% set optional input arguments if not set by the user
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
%% 0 step: initialization
tic;

fun = @upper_obj;  % outer objective function

u_1 = 1.000001; % parameter for t update
u_2 = 0.8;
t_min = 0.03; % minimal t value to make sure that sequence does not have 0 as accumulation point

n = length(x0);
i_null = 0;              % null-step counter

x = x0;                  % trial point, important for bundle information
x_hat = x0;              % serious point
eta = 0;                 % convexification parameter for modelfunction
c = 0;                   % augmented linearization error (error of convexified model-function)
J = 1;                   % index set defining bundle information
lJ = 1;                  % initial lenght of the index set J

% solve lower level optimization problem
W = solve_lower_reg(X,Y,x_hat);       %solution of lower level problem
dw = subgr_w(W,X,Y,x_hat);              % find subgradient of w with respect to x
g = subgr_upper(W,X,Y,dw);  % subgradient at point bundle point

f = feval(fun,X,Y,W);   % (inexact) function values at bundle points
f_hat = f;               % function value at x_hat

s = g;                   % augmented subgradient at bundle points
%% Global loop
for k = 1 : kmax;

%% 1st step: subproblem solving

% solve the following augmented quadratic subproblem for d:
% d = argmin{xi + 1/(2 * t) * norm(d)^2} s.t. s_j'*d - c_j - xi <= 0, for all j in J
% rewrite the problem to use it in quadprog to
% f = 1/2*x*H*x+r*x, s.t. A*x <= b
% incorporate the bound constraints of Moore-Paper (<= instead of > used here)
H = [zeros(n + 1, 1), [zeros(1, n); 1/t * eye(n)]];
r = [1; zeros(n, 1)];
A = [-ones(lJ, 1), s'];
b = c;
lb = [-Inf,0,0]';
options_ip = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
    'MaxIterations', 500, 'ConstraintTolerance', 1.0000e-15, 'OptimalityTolerance', 1.0000e-15);
[xi_d, ~, ~, ~, lambda] = quadprog(H, r, A, b, [], [], lb, [], [], options_ip);

%alpha = zeros(lJ+n+1,1);
alpha = lambda.ineqlin(1:lJ); % lagrange multiplier for inequality constraints
%alpha(lJ+1:end) = lambda.lower(:);

%% 2nd step: aggregated objects
xi = xi_d(1);
d = xi_d(2 : n + 1);
%C = alpha' * c;     % augmented aggregate error
%G = g * alpha;      % aggregate subgradient
%S = s * alpha;      % augmented aggregate subgradient

%% 3rd step: stopping test
% different stopping tests are implemented after different papers
delta = - xi + eta/2 * norm(d)^2;
% stopping conditions
% if norm(1/t * d) <= tol && E <= tol;  % stopping condition like in lecture
% if norm(G) <= tol && E <= tol;  % stopping condition like in lecture
% if norm(E + G * x_hat) <= tol and E <= tol;  % stopping condition like in conv, inex
if delta <= tol;  % stopping condition like in nonconv, exact
% if   -xi + eta / 2 * norm(d)^2 <= tol; % stopping condition like in nonconv, exact, nor rewritten
% if norm(E + t * G) <= tol;  % stopping condition like in nonconv, inex
    fprintf('Algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k, i_null);
    break
end
 
%% 4th step: serious step test
% solve inner problem and derivative system
W = solve_lower_reg(X, Y, x_hat);   % solution of lower level problem
dw = subgr_w(W,X,Y,x_hat);          % find subgradient of w with respect to x
g(:,end+1) = subgr_upper(W,X,Y,dw); % evaluate subgradient at new iterate and add information to bundle

% evaluate function and subgradient
f_k_1 =  feval(fun, X,Y,W);  % evaluate function at new iterate
f = [f, f_k_1];  % add information to bundle
x = [x, x_hat + d];  % add new iterate to bundle


%serious step  test
if f_k_1 - f_hat <= m * (-xi + eta / 2 * norm(d)^2);   % serious step condition
    x_hat = x_hat + d;   % update x_hat
    f_hat =  f_k_1;  % update f_hat
    t = u_1*t; % t_(k+1) > 0
else
    i_null = i_null + 1;
    t = max(u_2*t, t_min); % 0 < t_(k+1) <= t_k 
end

%% 5th step: Bundle update
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
    
%% 6th step: update model
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
eta = max(eta_vec) + gamma;
fprintf('eta: %d \n', eta);

b = zeros(lJ, 1);
for j = 1:lJ
    b(j) = eta/2 * norm(x(:,j) - x_hat)^2;
end

c = e + b;
s = g + eta * bsxfun(@minus, x, x_hat);

end
toc;
if k == kmax
    fprintf('Algorithm stopped because the maximum number %d of iterations was reached \n', k);
    fprintf('%d nullsteps were executed. \n', i_null)
end
%% END of the algorithm
end
