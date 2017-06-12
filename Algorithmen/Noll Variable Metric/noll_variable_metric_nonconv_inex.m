function [f_hat, x_hat, time, tav] = noll_variable_metric_nonconv_inex(x0, fun, subgr_fun, ...
    Q_type, noise, kmax, tol, m, t, gamma)

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
% Q_type        1: BFGS, 2: SR1, 3: LBFGS

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
i_null = 0;              % null-step counter

x = x0;                  % initial bundle point
x_hat = x;               % initial serious point
J = 1;                   % index set defining bundle information
lJ = 1;                  % size of the crrent bundle
f = feval(fun, x0, noise);      % initial inexact function value
f_hat = f;               % initial f_hat
g = feval(subgr_fun, x0, noise);% initial inexact subgradient
s = g;                   % initial augmented subgradient
c = 0;                   % initial augmented error
Q = eye(n);              % initial approximation to metric matrix

% parameters for t-update
u_1 = 1.2;
u_2 = 0.8;
t_min = 0.03; % minimal t value to make sure that sequence does not have 0 as accumulation point

tav = 0;
%% Global loop
for k = 1 : kmax
    
%% 1st step: direction finding
H = [zeros(n + 1, 1), [zeros(1, n); Q+1/t * eye(n)]];
r = [1; zeros(n, 1)];
D = [zeros(2*n,1), [diag(-ones(n,1)); diag(ones(n,1))]];
A = [-ones(lJ, 1), s'; D];
b = [c; x_hat+10;-x_hat+10];
% lJ constraints due to reformulation as smooth problem
% possibly additional constraints
[xi_d,~,lambda] = qpas(H,r,A,b,[],[],[],[],0);

d = xi_d(2:end);
% xi = dxi(end); 
alpha = lambda.inequality(1:lJ);
% gives a warnig if sum(alpha) not close enough to 1
if abs(sum(alpha)-1)> 1e-10
    warning('abs(sum(alpha)-1) = %d \n',abs(sum(alpha)-1))
end

% aggregate objects:
C = alpha' * c;     % augmented aggregate error

%% 2nd step: stopping test
% delta = C + 1/t*sum(d.^2);
% delta has to be changed according to stopping condition
delta = C+d'*(Q+1/t*eye(n))*d;
% stopping conditions
% if norm(1/t * d) <= tol && C <= tol;              % 1) like in Ulbrich lecture
% if norm(C + 1/t*d' * x_hat) <= tol && C <= tol;   % 3) like in conv, inex
% if C+1/t*d'*x_hat <= tol && C <= tol              % 3a) like in conv, inex with phi <= 0
% if -xi + eta / 2 * norm(d)^2 <= tol;              % 4) like in nonconv, exact
% if norm(C + d) <= tol;                            % 6) like in nonconv, inex, little reformulated
% if C+sum(d.^2) <= tol                             % 6a) like in nonconv, inex
% if norm((Q+1/t*eye(n))*d) <= tol && C <= tol      % 7) like in Ulbrich for Q/Noll variation
% if delta < tol                                    % 8) as thought of most sensible -> Herleitung siehe Blatt
if delta < tol*(1+f_hat)                            % 8) as thought of most sensible -> Herleitung siehe Blatt   
% if abs(f) < tol
% if C+d'*(1/k*Q+1/t*eye(n))*d < tol
    fprintf('Algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k-1, i_null);
    break
end

%% 4th step: iterate update
x_k_1 = x_hat+d;
f_k_1 = feval(fun,x_k_1, noise);
f = [f,f_k_1];              % add information to bundle
x = [x, x_k_1];             % add new iterate to bundle
g(:,end+1) = feval(subgr_fun,x_k_1,noise);% add information to bundle

%% 5th step: serious step test
%serious step  test
if f_k_1 - f_hat <= -m * delta   % serious step condition
    % hier war auch das eigenartige delta von oben
    x_hat = x_hat + d;   % update x_hat
    f_hat =  f_k_1;  % update f_hat
    if length(J) == 1
    else
        switch Q_type
            case 1
                Q = BFGS_update(d,g(:,end-1),g(:,end),Q);
            case 2
                Q = SR1_update(d,g(:,end-1),g(:,end),Q);
            case 3
                Q = LBFGS_update(d,g(:,end-1),g(:,end),Q);
        end
    end
    Q = 1/k*Q;
    t = u_1*t; % t_(k+1) > 0
    if min(eig(Q+1/t*eye(n))) < 0
        %q = -min(eig(Q+1/t*eye(n)))+0.01;
        %Q = Q+q*eye(n);
        t = -1/(min(eig(Q))-0.01);
        if t < 1e-6
            warning('t is smaller than %d. \n', 1e-6)
        end
    end
else
    i_null = i_null + 1;
    t = max(u_2*t, t_min); % 0 < t_(k+1) <= t_k
    if min(eig(Q+1/t*eye(n))) < 0
        %q = -min(eig(Q+1/t*eye(n)))+0.01;
        %Q = Q+q*eye(n);
        t = -1/(min(eig(Q))-0.01);
        if t < 1e-6
            warning('t is smaller than %d. \n', 1e-6)
        end
    end
end

if min(eig(Q+1/t*eye(n))) < 0
    warning('Matrix Q+1/t*I has negative eigenvalue.')
end

%% 5th step: Bundle update
%update bundle
delete = zeros(1,lJ);
for j = 1:lJ  % update the index set J by marking the indexes that are removed
    if alpha(j) > 1e-15 || norm(x(:,j) - x_hat) == 0 % alpha only gets down to 1e-5
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
for j = 1:lJ
    e(j) = f_hat - f(j) - g(:, j)' * (x_hat - x(:, j));  % update linearization error e
    if norm(x(:,j) - x_hat) ~= 0
        eta_vec(j) = -2 * e(j) / norm(x(:,j) - x_hat)^2;
    else
        eta_vec(j) = 0;
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

tav = tav+t;
end
time = toc;
if k == kmax
    warning('Algorithm stopped because the maximum number %d of iterations was reached \n', k);
    fprintf('%d nullsteps were executed. \n', i_null)
end 
tav = tav/(k-1);
%% END of the algorithm    
end