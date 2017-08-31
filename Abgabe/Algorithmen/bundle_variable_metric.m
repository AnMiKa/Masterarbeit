function [f_hat, x_hat, time ] = ...
    bundle_variable_metric(x0, fun, subgr_fun, Q_type, noise, kmax, tol, m, t, gamma)

% variable metric bundle algorihtm that can handle nonsmooth nonconvex functions with
% inexact information on function value and gradient

% Detailed explanation
% The Algorithm is combines the proximal bundle algorithm in the paper
% "Proximal bundle method for nonconvex functions with inexact information" 
% by W. Hare, M. Solodov and C. Sagastizabal with the approach that is
% presented by D. Noll in "Bundle Method for Non-Convex Minimization
% with Inexact Subgradients and Function Values".
% The subproblem can be solved with MATLAB's quadprog or A. Wills qpas
% algorithm.
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
%       Q_type      decides which update to use for metric matrix
%       noise       moise form for testing 

%   Output parameters
%       f_hat       optimal function value
%       x_hat       argmin of the objective
%       time        computation time

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
% Q_type        1: BFGS, 2: BFGS Variant 1, 3: BFGS Variant 2
%               4: Hybrid

defaults = {1, 0, 2000, 1e-6, 0.05, 0.1, 2};
% set optional input arguments if not set by the user
% Check number of inputs.
if nargin > 10
    error('Too many input arguments: requires at most 7 optional inputs');
end

% Fill in unset optional values.
switch nargin
    case 3
        [Q_type, noise, kmax, tol, m, t, gamma] = defaults{:};
    case 4
        [noise, kmax, tol, m, t, gamma] = defaults{2:7};
    case 5
        [kmax, tol, m, t, gamma] = defaults{3:7};
    case 6
        [tol, m, t, gamma] = defaults{4:7};
    case 7
        [m, t, gamma] = defaults{5:7};
    case 8
        [t, gamma] = defaults{6:7};
    case 9
        gamma = defaults{7};
end

%% BEGINNING of the algorithm
%% 0 step: initialization
tic;

n = length(x0);
i_null = 0;                 % null-step counter

x = x0;                     % initial bundle point
x_hat = x;                  % initial serious point
J = 1;                      % index set defining bundle information
lJ = 1;                     % size of the crrent bundle
f = feval(fun, x0, noise);  % initial inexact function value
f_hat = f;                  % initial f_hat
g = feval(subgr_fun, x0, noise);% initial inexact subgradient
s = g;                      % initial augmented subgradient
g_hat = g;
c = 0;                      % initial augmented error
Q = eye(n);                 % initial approximation to metric matrix

% parameters for t-update
u_1 = 2;
u_2 = 0.8;
t_min = 0.03; % minimal t value to make sure that sequence does not have 0 as accumulation point

%tav = 0;
%% Global loop
for k = 1 : kmax
    
%% 1st step: direction finding
H = [zeros(n + 1, 1), [zeros(1, n); Q+1/t * eye(n)]];
r = [1; zeros(n, 1)];
D = [zeros(2*n,1), [diag(-ones(n,1)); diag(ones(n,1))]];
A = [-ones(lJ, 1), s'; D];
b = [c; x_hat+10;-x_hat+10];
[xi_d,~,lambda] = qpas(H,r,A,b,[],[],[],[],0);
%[xi_d,~,~,~,lambda] = quadprog(H,r,A,b);

d = xi_d(2:end);
alpha = lambda.inequality(1:lJ);

% aggregate objects:
C = alpha' * c;     % augmented aggregate error

%% 2nd step: stopping test
delta = C+d'*(Q+1/t*eye(n))*d;
if delta < tol
    %fprintf('Algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k-1, i_null);
    break
end

%% 4th step: iterate update
x_k_1 = x_hat+d;
f_k_1 = feval(fun,x_k_1, noise);
f = [f,f_k_1];                          % add information to bundle
x = [x, x_k_1];                         % add new iterate to bundle
g(:,end+1) = feval(subgr_fun,x_k_1,noise);% add information to bundle

%% 5th step: serious step test
%serious step  test
if f_k_1 - f_hat <= -m * delta      % serious step condition
    x_hat = x_hat + d;              % update x_hat
    f_hat =  f_k_1;                 % update f_hat
    g_hat_old = g_hat;
    g_hat = g(:,end);
    if length(J) == 1
    else
        switch Q_type
            case 1
                Q = BFGS_update(d,g_hat_old,g_hat,Q);
            case 2
                Q = BFGS_update_Variation1(d,g_hat_old,g_hat,Q);
            case 3
                Q = BFGS_update_Variation2(d,g_hat_old,g_hat,Q);
            case 4
                Q = BFGS_update(d,g_hat_old,g_hat,Q);
                Q = 1/k*Q;
        end
    end
    t = u_1*t; % t_(k+1) > 0
    % update step size t
    if min(eig(Q+1/t*eye(n))) < 0
        t = -1/(min(eig(Q))-0.01);
    end
else
i_null = i_null + 1;
    t = max(u_2*t, t_min); % 0 < t_(k+1) <= t_k
    if min(eig(Q+1/t*eye(n))) < 0
        t = -1/(min(eig(Q))-0.01);
    end
end

%% 5th step: Bundle update
%update bundle
delete = zeros(1,lJ);
for j = 1:lJ    % update the index set J by marking the indexes that are removed
    if alpha(j) > 1e-15 || norm(x(:,j) - x_hat) == 0
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
%    warning('Algorithm stopped because the maximum number %d of iterations was reached \n', k);
%    fprintf('%d nullsteps were executed. \n', i_null)
%end 
%% END of the algorithm    
end