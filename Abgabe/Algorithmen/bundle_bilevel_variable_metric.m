function [f_hat, x_hat, k, i_null, time ] = ...
    bundle_bilevel_variable_metric(x0, X, Y, Q_type, kmax, tol, m, t, gamma)

% variable metric bundle algorihtm that calculates the optimal
% hyper-parameter for a bilevel problem for support vector classification

% The Algorithm is combines the proximal bundle algorithm in the paper
% "Proximal bundle method for nonconvex functions with inexact information" 
% by W. Hare, M. Solodov and C. Sagastizabal with the approach that is
% presented by D. Noll in "Bundle Method for Non-Convex Minimization
% with Inexact Subgradients and Function Values".
% The algorithm is addapted to solve the bilevel problem emerging from
% hyper-parameter optimization for support vector classification.

% Input parameters
%       x0          starting value
%       X           data points of the training set
%       Y           lables of the training set
%
% optional input parameters
%       Q_type      decides which update for Q is taken
%       kmax        maximum number of iterations
%       m           descent parameter
%       t           prox parameter
%       tol         tolerance for stopping test
%       gamma       saveguarding value for calculating eta

%   Output parameters
%       f_hat       optimal function value
%       x_hat       argmin of the objective
%       k           number of steps
%       i_null      number of null steps
%       time        computation time

tic
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
% Q_type        1: BFGS, 2: BFGS Variation 1, 3: BFGS Variation 2,
%               4: Hybrid

defaults = {1, 1000, 1e-9, 0.05, 0.1, 2};
% set optional input arguments if not set by the user
% Check number of inputs.
if nargin > 9
    error('Too many input arguments: requires at most 7 optional inputs');
end

% Fill in unset optional values.
switch nargin
    case 3
        [Q_type, kmax, tol, m, t, gamma] = defaults{:};
    case 4
        [kmax, tol, m, t, gamma] = defaults{2:6};
    case 5
        [tol, m, t, gamma] = defaults{3:6};
    case 6
        [m, t, gamma] = defaults{4:6};
    case 7
        [t, gamma] = defaults{5:6};
    case 8
        [gamma] = defaults{6};
end

%% BEGINNING of the algorithm
%% 0 step: initialization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fun = @ul_obj_class_hingequad;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = length(x0);
i_null = 0;              % null-step counter

x = x0;                  % initial bundle point
x_hat = x;               % initial serious point
x_hats = x0;
eta_max = 0;
J = 1;                   % index set defining bundle information
lJ = 1;                  % size of the crrent bundle

% solve lower level optimization problem
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set solver for lower level problem
[W,~,g] = solve_ll_and_subgr(x_hat,X,Y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f = feval(fun, X,Y,W);   % initial inexact function value
f_hat = f;               % initial f_hat

s = g;                   % initial augmented subgradient
g_hat = g;
c = 0;                   % initial augmented error
Q = eye(n);              % initial approximation to metric matrix

% parameters for t-update
u_1 = 1.2;
u_2 = 0.8;
t_min = 1e-9; % minimal t value to make sure that sequence does not have 0 as accumulation point

%tav = 0;
%% Global loop
for k = 1 : kmax
    
%% 1st step: direction finding
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set solver for upper level problem
[d,~,alpha] = solve_ul_Q_class_qp(x_hat,Q,s,c,t);    % solver using MATLAB's quadprog
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% aggregate objects:
C = alpha' * c;     % augmented aggregate error

%% 2nd step: stopping test
delta = C+d'*(Q+1/t*eye(n))*d;
if delta < tol
    %fprintf('Algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k-1, i_null);
    break
end

%% 4th step: iterate update

% solve inner problem and derivative system

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set solver for lower level problem
[W,~,g(:,end+1)] = solve_ll_and_subgr(x_hat+d,X,Y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f_k_1 = feval(fun,X,Y,W);
f = [f,f_k_1];                % add information to bundle
x = [x, x_hat+d];             % add new iterate to bundle

%% 5th step: serious step test
%serious step  test
if f_k_1 - f_hat <= -m * delta  % serious step condition
    x_hat = x_hat + d;          % update x_hat
    f_hat =  f_k_1;             % update f_hat
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
    % adapt step size t
    t = u_1*t;
    if min(eig(Q+1/t*eye(n))) < 0
        t = -1/(min(eig(Q))-0.01);
    end
else
i_null = i_null + 1;
    t = max(u_2*t, t_min);  % 0 < t_(k+1) <= t_k
    if min(eig(Q+1/t*eye(n))) < 0
        t = -1/(min(eig(Q))-0.01);
    end
end

%% 5th step: Bundle update
%update bundle
delete = zeros(1,lJ);
for j = 1:lJ  % update the index set J by marking the indexes that are removed
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