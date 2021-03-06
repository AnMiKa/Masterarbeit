function [ f_hat, x_hat, time, k ] = bundle_nonconv_inex( x0, fun, subgr_fun, noise, kmax, tol, m, t, gamma)

% proximal bundle algorihtm that can handle nonsmooth nonconvex functions with
% inexact information on function value and gradient

% The Algorithm is implemented after the one in the paper "Proximal bundle
% method for nonconvex functions with inexact information" by W. Hare 
% M. Solodov and C. Sagastizabal.
% The algorithm can find approximate stationary points of a nonsmooth 
% noncnovex function with inexact function and subgradient information.
% The bundle subproblem cab be solved with the qpas algorithm by A. Wills
% or the quadprog method provided by MATLAB.
% At least one element of the subdifferential has to be known at any
% x-value.


% Input parameters
%       x0          starting value
%       fun         function to be minimized (can be nonsmooth, must be convex)
%       subgr_fun   function that can evaluate a subgradient of fun at every 
%                   given point x. 
% optional input parameters
%       noise       noise form for testing
%       kmax        maximum number of iterations
%       m           descent parameter
%       t           prox parameter
%       tol         tolerance for stopping test
%       gamma       saveguarding value for calculating eta

%   Output parameters
%       f_hat       optimal function value
%       x_hat       argmin of the objective
%       delta       last delta

%% set x0 as column-vector, regardless of how it is typed in
[rows, columns] = size(x0);
if rows == 1
    x0 = x0';
end
% check that x0 is a vector
if rows ~= 1 && columns ~=1
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

defaults = {0, 5000, 1e-6, 0.05, 0.1, 2};
% set optional input arguments if not set by the user
% Check number of inputs.
if nargin > 9
    error('Too many input arguments: requires at most 6 optional inputs');
end

% Fill in unset optional values.
switch nargin
    case 3
        [noise, kmax, tol, m, t, gamma] = defaults{:};
    case 4
        [kmax, tol, m, t, gamma] = defaults{2:6};
    case 5
        [ tol, m, t, gamma] = defaults{3:6};
    case 6
        [m, t, gamma] = defaults{4:6};
    case 7
        [t, gamma] = defaults{5:6};
    case 8
        gamma = defaults{6};
end

%% BEGINNING of the algorithm
%% 0 step: initialization
tic;

u_1 = 1.2;      % parameter for t update
u_2 = 0.8;
t_min = 0.03;   % minimal t value to make sure that sequence does not have 0 as accumulation point

n = length(x0);
i_null = 0;                 % null-step counter

x = x0;                     % trial point, important for bundle information
x_hat = x0;                 % serious point
eta = 0;                    % convexification parameter for modelfunction
c = 0;                      % augmented linearization error (error of convexified model-function)
J = 1;                      % index set defining bundle information
lJ = 1;                     % initial lenght of the index set J
f = feval(fun, x0,noise);   % (inexact) function values at bundle points
f_hat = f;                  % function value at x_hat
g = feval(subgr_fun, x0,noise);% subgradient at point bundle points
s = g;                      % augmented subgradient at bundle points

%% Global loop
for k = 1 : kmax

%% 1st step: subproblem solving

% solve the following augmented quadratic subproblem for d:
% d = argmin{xi + 1/(2 * t) * norm(d)^2} s.t. s_j'*d - c_j - xi <= 0, for all j in J
% rewrite the problem to use it in quadprog to
% f = 1/2*x*H*x+r*x, s.t. A*x <= b
% incorporate set X, here as a box of around -x_hat
H = [zeros(n + 1, 1), [zeros(1, n); 1/t * eye(n)]];
r = [1; zeros(n, 1)];
X = [zeros(2*n,1), [diag(-ones(n,1)); diag(ones(n,1))]];
A = [-ones(lJ, 1), s'; X];
b = [c; x_hat+10;-x_hat+10];
%options_ip = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
%    'MaxIterations', 5000, 'ConstraintTolerance', 1.0000e-15, 'OptimalityTolerance', 1.0000e-15);
%[xi_d, ~, ~, ~, lambda] = quadprog(H, r, A, b, [], [], [], [], [], options_ip);
[xi_d,~,lambda] = qpas(H,r,A,b,[],[],[],[],0);

% lagrange multiplier for inequality constraints
alpha = lambda.inequality(1:lJ);

%% 2nd step: aggregated objects
xi = xi_d(1);
d = xi_d(2 : n + 1);
C = alpha' * c;         % augmented aggregate error

%% 3rd step: stopping test
% stopping condition

if C+1/t*sum(d.^2) < tol
    %fprintf('Algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k, i_null);
    break
end
 
%% 4th step: serious step test
% evaluate function and subgradient
f_k_1 =  feval(fun, x_hat + d, noise);  % evaluate function at new iterate
f = [f, f_k_1];                         % add information to bundle
g = [g, feval(subgr_fun, x_hat + d,noise)];  % evaluate subgradient at new iterate and add information to bundle
x = [x, x_hat + d];                     % add new iterate to bundle

%serious step  test
if f_k_1 - f_hat <= m * (-xi + eta / 2 * norm(d)^2)   % serious step condition
    x_hat = x_hat + d;          % update x_hat
    f_hat =  f_k_1;             % update f_hat
    t = u_1*t;                  % t_(k+1) > 0
else
    i_null = i_null + 1;
    t = max(u_2*t, t_min);      % 0 < t_(k+1) <= t_k
end

%% 5th step: Bundle update
%update bundle
delete = zeros(1,lJ);
for j = 1:lJ  % update the index set J by marking the indexes that are removed
    if alpha(j) > 1e-15 || norm(x(:,j) - x_hat) == 0 % alpha only gets down to 1e-5
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
for j = 1:lJ
    e(j) = f_hat - f(j) - g(:, j)' * (x_hat - x(:, j));  % update linearization error e
    if norm(x(:,j) - x_hat) ~= 0
        eta_vec(j) = -2 * e(j) / norm(x(:,j) - x_hat)^2;
    else
        eta_vec(j) = 0;
    end
end
eta = max(eta_vec) + gamma;

b = zeros(lJ, 1);
for j = 1:lJ
    b(j) = eta/2 * norm(x(:,j) - x_hat)^2;
end

c = e + b;
s = g + eta * bsxfun(@minus, x, x_hat);
end
time = toc;
%if k == kmax
%    fprintf('Algorithm stopped because the maximum number %d of iterations was reached \n', k);
%    fprintf('%d nullsteps were executed. \n', i_null)
%end
%% END of the algorithm
end