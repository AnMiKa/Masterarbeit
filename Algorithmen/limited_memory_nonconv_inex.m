function [f_hat, x_hat, delta] = limited_memory_nonconv_inex(x0, fun, subgr_fun, ...
    kmax, m, t, tol, gamma, K, rho, mmax)

% variable metric bundle algorihtm that can handle nonsmooth nonconvex functions with
% inexact information on function value and gradient

% Detailed explanation
% The Algorithm is combines the proximal bundle algorithm in the paper
% " Proximal bundle method for nonconvex functions with inexact information" 
% by Warren Hare and Claudia Sagastizabal with the limited memory approach 
% that is presented by Napsu Karmitsa (Haarala), Kaisa Miettinen and Marko M. M�kel�
% in "Globally convergent limited memory bundle method for large scale
% optimization".
% The algorithm can find approximate stationary points of a nonsmooth 
% noncnovex function with when only inexact information is provided for
% both function value and subgradient.
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

%n = length(x0);
i_null = 0;              % null-step counter
i_null_C = 0;            % consecutive null-step counter
step = 1;                % saves whether serious (= 1) or null step (= 0) has been done 
i_C = 0;                 % correction indicator
%i_CN = 0;                % correction indicator for consecutive null steps

x_hat = x0;              % initial serious point
%eta = 0;                 % initial convexification parameter for modelfunction
C = 0;                   % initial augmented linearization error (error of convexified model-function)
%J = zeros(1,3);          % index set defining bundle information
f_hat = feval(fun, x0);  % initial inexact function value
%f_hat = f;               % function value at x_hat
g = feval(subgr_fun, x0);% initial inexact subgradient
s = g;                   % initial augmented subgradient
s_hat = g;
S = g;                   % initial aggregate augmented subgradient
d = -S;                  % initial descent direction

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
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    % check in which subfunction exclusive or, find if true of not
    if step
        % subfunction to calculate descent direction via LBFGS-update
        [d,U1,U2,R,CC,UU,phi] = lbfgs(u1,u2,s,U1,U2,R,CC,UU,mmax,phi);
    else
        % subalgorithm to calculate descent direction via SR1-update
        [d,U1,U2,R,CC,UU,phi] = sr1(u1,u2,U1,U2,R,CC,UU,S_prev,S,d,...
            i_null_C,mmax,phi);
    end
end

%% 2nd step: correction
if -S'*d < rho*sum(S.^2) || and(step == 0,i_C == 1);
    d = d-rho*S;
    i_C = 1;
%     if step == 0
%         i_CN = 1;
%     end
else
    i_C = 0;
end

%% 3rd step: stopping test
delta = -S'*d+2*C;
delta_q = 1/2*sum(S.^2)+C;

if delta < tol && delta_q < tol
    fprintf('Algorithm stopped successfully by meeting the tolerance after %d iterations and %d null-steps. \n', k, i_null);
    break
end

%% 4th step: iterate update
theta = min(1, K/norm(d)); % is this really needed??? can it be done by using set D???
x = x_hat+theta*d;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% in paper f = f_hat;
% check if version here is compatible
f = feval(fun, x);
g = feval(subgr_fun,x);

%% 5th step: serious step test
if f-f_hat <= -m*delta  % serious step
    step = 1;
    f_hat = f;
    x_hat = x;
    s = g;
    s_hat = s;
    S = s;
    c = 0;
    C = 0;
    %i_CN =0;
else
    e = f_hat-f-g'*(x_hat-x);
    eta = max(-2*e/norm(d),0)+gamma;
    c = max(e,0)+gamma/2;
    i_null_C = i_null_C+1;
    s = g + eta*(x-x_hat);
    
    %% 6th step: aggregation
    % formulation of subproblem for lambdas, use i_C to know if correction
    % needed
    lambda = opt_lambdas(s,s_hat,S,d,c,C,U1,U2,R,CC,UU,phi,step,i_C,rho,k);
    S_prev = S;
    S = lambda(1)*s_hat+lambda(2)*s+lambda(3)*S;
    C = lambda(2)*c+lambda(3)*C;
    step = 0;
end
% vectors for limited memory update
u1 = theta*d;
u2 = s-s_hat;
fprintf('iteration: %d  function value: %d  step: %d \n', k, f_hat, step)
end    
%% END of the algorithm    
end