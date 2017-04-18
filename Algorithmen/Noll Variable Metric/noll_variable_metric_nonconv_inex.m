function [f_hat, x_hat, time] = noll_variable_metric_nonconv_inex(x0, fun, subgr_fun, ...
    kmax, m, t, tol, gamma)

% variable metric bundle algorihtm that can handle nonsmooth nonconvex functions with
% inexact information on function value and gradient

% Detailed explanation
% The Algorithm is combines the proximal bundle algorithm in the paper
% " Proximal bundle method for nonconvex functions with inexact information" 
% by Warren Hare and Claudia Sagastizabal with the approach that is
% presented by Dominikus Noll in "Bundle Method for Non-Convex Minimization
% with Inexact Subgradients and Function Values".
% The algorithm can find approximate stationary points of a nonsmooth 
% noncnovex function when only inexact information is provided for
% both function value and subgradient.
% At least one element of the subdifferential has to be known at any
% x-value.

% Input parameters
%       x0          starting value
%       fun         function to be minimized (can be nonsmooth)
%       subgr_fun   function that can evaluate a subgradient of fun at every 
%                   given point x. 
% optional input parameters
%       kmax        maximum number of iterations
%       m           descent parameter
%       t           prox parameter
%       tol         tolerance for stopping test
%       gamma       saveguarding value for calculating eta
%       C           length controlling parameter for descent direction
%       rho         correction parameter for matrix update

%   Output parameters
%       f_hat       optimal function value
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

defaults = {2000, 0.05, 0.1, 1e-6, 2, 10, 0.4, 20};
% set optional input arguments if not set by the user
% Check number of inputs.
if nargin > 11
    error('Too many input arguments: requires at most 8 optional inputs');
end

% Fill in unset optional values.
switch nargin
    case 3
        [kmax, m, t, tol, gamma, K, rho, mmax] = defaults{:};
    case 4
        [m, t, tol, gamma, K, rho, mmax] = defaults{2:8};
    case 5
        [t, tol, gamma, K, rho, mmax] = defaults{3:8};
    case 6
        [tol, gamma, K, rho, mmax] = defaults{4:8};
    case 7
        [gamma, K, rho, mmax] = defaults{5:8};
    case 8
        [K, rho, mmax] = defaults{6:8};
    case 9
        [rho, mmax] = defaults{7:8};
    case 10
        mmax = defaults{8};
end

%% BEGINNING of the algorithm
%% 0 step: initialization
tic;

n = length(x0);
i_null = 0;              % null-step counter

x_hat = x0;              % initial serious point
J = zeros(1,3);          % index set defining bundle information
lJ = 1;                  % size of the crrent bundle
f_hat = feval(fun, x0);  % initial inexact function value
g = feval(subgr_fun, x0);% initial inexact subgradient
s = g;                   % initial augmented subgradient
%S = g;                   % initial aggregate augmented subgradient
c = 0;                   % initial augmented error
Q = eye(n);              % initial approximation to metric matrix


%% Global loop
for k = 1 : kmax;
    
%% 1st step: direction finding
H = [Q+1/t*eye(n),zeros(n,1)];
h = [zeros(n,1);ones(1)];
% lJ constraints due to reformulation as smooth problem
% possibly additional constraints
A = [s',-ones(lJ, 1)];
b = c;
[dxi,~,lambda] = qpas(H,h,A,b,[],[],[],[],1);

d = dxi(1:end-1);
% xi = dxi(end); 
alpha = lambda;%.inequality(1:lJ);
% gives a warnig if sum(alpha) not close enough to 1
if abs(sum(alpha)-1)> 1e-15
    warning('abs(sum(alpha)-1) = %d \n',abs(sum(alpha)-1))
end%% 3rd step: stopping test

% aggregate objects:
C = alpha' * c;     % augmented aggregate error

%% 2nd step: stopping test
% stopping conditions
% if norm(1/t * d) <= tol && C <= tol;              % 1) like in Ulbrich lecture
 if norm(C + 1/t*d' * x_hat) <= tol && C <= tol;   % 3) like in conv, inex
% if C+1/t*d'*x_hat <= tol && C <= tol              % 3a) like in conv, inex with phi <= 0
% if -xi + eta / 2 * norm(d)^2 <= tol;              % 4) like in nonconv, exact
% if norm(C + d) <= tol;                            % 6) like in nonconv, inex, little reformulated
% if C+sum(d.^2) <= tol                             % 6a) like in nonconv, inex
    fprintf('Algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k-1, i_null);
    break
end

%% 4th step: iterate update
x = x_hat+d;
f_k_1 = feval(fun, x);
f = [f, f_k_1];                 % add information to bundle
x = [x, x_hat + d];             % add new iterate to bundle
g(end+1,:) = feval(subgr_fun,x);% add information to bundle

%% 5th step: serious step test
%serious step  test
if f_k_1 - f_hat <= -m * delta;   % serious step condition
    % hier war auch das eigenartige delta von oben
    x_hat = x_hat + d;   % update x_hat
    f_hat =  f_k_1;  % update f_hat
    Q = BFGS_update(d,g(end-1,:),g(end,:),Q);
    t = u_1*t; % t_(k+1) > 0
else
    i_null = i_null + 1;
    t = max(u_2*t, t_min); % 0 < t_(k+1) <= t_k 
end

%% 5th step: Bundle update
%update bundle
delete = zeros(1,lJ);
for j = 1:lJ;  % update the index set J by marking the indexes that are removed
    if alpha(j) > 1e-15 || norm(x(:,j) - x_hat) == 0; % alpha only gets down to 1e-5
                            % maybe here norm() < 1e-10 to avoid numerical
                            % issues when x is changing to little comparerd
                            % to x_hat ?
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
time = toc;
if k == kmax
    warning('Algorithm stopped because the maximum number %d of iterations was reached \n', k);
    fprintf('%d nullsteps were executed. \n', i_null)
end 
%% END of the algorithm    
end