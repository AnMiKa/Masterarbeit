function [ f_hat, x_hat, k, i_null, time ] = ...
    bundle_bilevel( x0, X, Y, kmax, tol, m, t, gamma)
% proximal bundle algorihtm that calculates the optimal hyper-parameter of
% a bilevel support vector classification problem

% The Algorithm is implemented after the one in the paper "Proximal bundle
% method for nonconvex functions with inexact information" by W. Hare 
% M. Solodov and C. Sagastizabal.
% It is adapted to solve a bilevel problem emerging from hyper-parameter
% optimization in support vector classification.
% All subproblems are solved using the quadprog method provided by MATLAB.


% Input arguments
%       x0          starting value
%       X           data points of the training set
%       Y           lables of the training set
%                   
% optional input arguments
%       kmax        maximum number of iterations
%       m           descent parameter
%       t           prox parameter
%       tol         tolerance for stopping test
%       gamma       saveguarding value for calculating eta

%   Output arguments
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

defaults = {1000, 1e-9, 0.05, 0.1, 2};
% set optional input arguments if not set by the user
% Check number of inputs.
if nargin > 8
    error('Too many input arguments: requires at most 5 optional inputs');
end

% Fill in unset optional values.
switch nargin
    case 3
        [kmax, tol, m, t, gamma] = defaults{:};
    case 4
        [tol, m, t, gamma] = defaults{2:5};
    case 5
        [m, t, gamma] = defaults{3:5};
    case 6
        [t, gamma] = defaults{4:5};
    case 7
        gamma = defaults{5};
end

%% BEGINNING of the algorithm
%% 0 step: initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fun = @ul_obj_class_hingequad;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

u_1 = 1.2;              % parameter for t update
u_2 = 0.8;
t_min = 0.03;           % minimal t value to make sure that sequence does not have 0 as accumulation point

i_null = 0;             % null-step counter

x = x0;                 % trial point, important for bundle information
x_hat = x0;             % serious point
c = 0;                  % augmented linearization error (error of convexified model-function)
J = 1;                  % index set defining bundle information
lJ = 1;                 % initial lenght of the index set J

% solve lower level optimization problem
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set solver for lower level problem
[W,~,g] = solve_ll_and_subgr(x_hat,X,Y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f = feval(fun,X,Y,W);    % (inexact) function values at bundle points
f_hat = f;               % function value at x_hat

s = g;                   % augmented subgradient at bundle points
%% Global loop
for k = 1 : kmax

%% 1st step: subproblem solving

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set solver for upper level problem
[d,~,alpha] = solve_ul_class_qp(x_hat,s,c,t);    % solver using MATLAB's quadprog
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 2nd step: aggregated objects
C = alpha' * c;         % augmented aggregate error

%% 3rd step: stopping test
if C+1/t*sum(d.^2) <= tol
    %fprintf('Algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k-1, i_null);
    break
end
 
%% 4th step: serious step test
% solve inner problem and derivative system

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set solver for lower level problem
[W,~,g(:,end+1)] = solve_ll_and_subgr(x_hat+d,X,Y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% evaluate function and subgradient
f_k_1 =  feval(fun,X,Y,W);    % evaluate function at new iterate
f = [f, f_k_1];               % add information to bundle
x = [x, x_hat + d];           % add new iterate to bundle


%serious step  test
if f_k_1 - f_hat <= -m * delta  % serious step condition
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
for j = 1:lJ                % update the index set J by marking the indexes that are removed
    if alpha(j) > 1e-15 || norm(x(:,j) - x_hat) == 0
    else
        delete(j) = 1;
    end
end
J(delete == 1) = [];
f(delete == 1) = [];
x(:,delete == 1) = [];
g(:,delete == 1) = [];       % remove all marked objects from the bundle
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
    %warning('Algorithm stopped because the maximum number %d of iterations was reached \n', k);
    %fprintf('%d nullsteps were executed. \n', i_null)
%end
%% END of the algorithm
end

