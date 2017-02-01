function [f_hat, x_hat, delta] = limited_memory_bundle(x0, fun, subgr_fun, ...
    kmax, tol, epsIL, epsIR, gamma, omega, tmin, tmax, K, rho, mmax)

% variable metric bundle algorihtm that can handle nonsmooth nonconvex functions

% Detailed explanation
% The Algorithm is implemented afer the one that is presented by Napsu 
% Karmitsa (Haarala), Kaisa Miettinen and Marko M. M�kel�
% in "Globally convergent limited memory bundle method for large scale
% optimization".
% The algorithm can find approximate stationary points of a nonsmooth 
% noncnovex function.
% The method is especially designed to handle large-scale problems.
% At least one element of the subdifferential has to be known at any
% x-value.

% Input parameters
%       x0          starting value
%       fun         function to be minimized (can be nonsmooth)
%       subgr_fun   function that can evaluate a subgradient of fun at every 
%                   given point x. 
% optional input parameters
%       kmax        maximum number of iterations
%       tol         tolerance for stopping test
%       epsIL       initial line search parameter
%       epsIR       initial line search parameter
%       gamma       distance measure parameter
%       omega       locality measure parameter
%       tmin        lower bound for stepsize
%       tmax        upper bound for stepsize
%       K           length controlling parameter for descent direction
%       rho         correction parameter for matrix update
%       mmax        maximum of stored correction pairs

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

% set default values for the optional input arguments 
%%% wrong parameters/vallues here
% values for m, gamma and t taken prom paper
% kmax > 0      maximum number of iterations
% m in (0, 1)   Armijo-like descent parameter
% t > 0         prox / convexification parameter of the subproblem
% tol           tolerance for terminating the algorithm
% gamma > 0     saveguarding parameter for calculating eta

defaults = {2000, 1e-6, 0.1, 0.4, 0.5, 2, 0.1, 2, 20};
% set optional input arguments if not set by the user
% Check number of inputs.
if nargin > 14
    error('Too many input arguments: requires at most 11 optional inputs');
end

% Fill in unset optional values.
switch nargin
    case 3
        [kmax, tol, epsIL, epsIR, gamma, omega, tmin, tmax, K, rho, mmax] = defaults{:};
    case 4
        [tol, epsIL, epsIR, gamma, omega, tmin, tmax, K, rho, mmax] = defaults{2:11};
    case 5
        [epsIL, epsIR, gamma, omega, tmin, tmax, K, rho, mmax] = defaults{3:11};
    case 6
        [epsIR, gamma, omega, tmin, tmax, K, rho, mmax] = defaults{4:11};
    case 7
        [gamma, omega, tmin, tmax, K, rho, mmax] = defaults{5:11};
    case 8
        [omega, tmin, tmax, K, rho, mmax] = defaults{6:11};
    case 9
        [tmin, tmax, K, rho, mmax] = defaults{7:11};
    case 10
        [tmax, K, rho, mmax] = defaults{8:11};
    case 11
        [K, rho, mmax] = defaults{9:11};
    case 12
        [rho, mmax] = defaults{10:11};
    case 13
        mmax = defaults{11}
end

%% BEGINNING of the algorithm
%% 0 step: initialization
tic;

%n = length(x0);
i_null = 0;              % null-step counter
i_null_C = 0;            % consecutive null-step counter
step = 1;                % saves whether serious (= 1) or null step (= 0) has been done 
i_C = 0;                 % correction indicator
%i_CN = 0;                % correction indicator for consecutive null steps

x_hat = x0;              % initial serious point
x = x0;
Beta = 0;                % initial aggregate linearization error 
f_hat = feval(fun, x0);  % initial inexact function value
g = feval(subgr_fun, x0);% initial inexact subgradient
g_hat = g;
G = g;                   % initial aggregate augmented subgradient
d = -G;                  % initial descent direction

% initial matrices for lambda-optimization in first step
U1 = [];
U2 = [];
R = [];
CC = [];
UU = [];
phi = 1;
%% Global loop
for k = 1 : kmax;
    
%% 1st step: direction finding
if k > 1
    if step
        % subfunction to calculate descent direction via LBFGS-update
        [d,U1,U2,R,CC,UU,phi] = lbfgs(s,u,s,U1,U2,R,CC,UU,mmax,phi);
    else
        % subalgorithm to calculate descent direction via SR1-update
        [d,U1,U2,R,CC,UU,phi] = sr1(s,u,U1,U2,R,CC,UU,G_prev,G,d,...
            i_null_C,mmax,phi);
    end
end

%% 2nd step: correction
if -G'*d < rho*sum(G.^2) || and(step == 0,i_C == 1);
    d = d-rho*G;
    i_C = 1;
%     if step == 0
%         i_CN = 1;
%     end
else
    i_C = 0;
end

%% 3rd step: stopping test
delta = -G'*d+2*Beta;
delta_q = 1/2*sum(G.^2)+Beta;

if delta < tol && delta_q < tol
    fprintf('Algorithm stopped successfully by meeting the tolerance after %d iterations and %d null-steps. \n', k, i_null);
    break
end

%% 4th step: line search
theta = min(1, K/norm(d));
% sophisticated initial stepsize calculation -> Luksan
tI = tmin;
[tR,tL] = linesearch(fun,subgr_fun,x,d,theta,epsIL,epsIR,tI,tmin,gamma,omega,...
    delta_w,imax,i_null_C);

%% 5th step: iterate update
x_hat = x_hat+tL*theta*d;
x = x_hat+tR*theta*d;
f_prev = f;
f = feval(fun, x_hat); % this really correct?
fx = feval(fun, x);
g = feval(subgr_fun,x);

% vectors for limited memory update
s = tR*theta*d;
u = g-g_hat;

if  (tT == tL) && (tR > 0) && (fx <= f_prev-epsL*tR*delta_w) % serious step
    beta = 0;
    Beta = 0;
    i_null_C = 0;
else
    beta = max(abs(f_prev-fx+tR*theta*d'*g),gamma*norm(tR*theta*d));
    %% 6th step: aggregation
    % formulation of subproblem for lambdas, use i_C to know if correction
    % needed
    lambda = opt_lambdas(s,g_hat,G,d,beta,Beta,U1,U2,R,CC,UU,phi,step,i_C,rho,k);
    G_prev = G;
    G = lambda(1)*g_hat+lambda(2)*g+lambda(3)*G;
    Beta = lambda(2)*beta+lambda(3)*Beta;
    step = 0;
    i_null_C = i_null_C+1;
end

fprintf('iteration: %d  function value: %d  step: %d \n', k, f_hat, step)
end    
%% END of the algorithm    
end