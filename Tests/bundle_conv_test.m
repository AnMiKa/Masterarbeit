function [ f_hat, x_hat, alpha_nonneg, alpha_equ_one, alpha_small, alpha_big, ...
    e_veryneg, e_changed, k, g_eq_d,  xi_exp1,  xi_exp2, xi_exp3 ] = ...
    bundle_conv_test( x0, fun, subgr_fun, e_change, kmax, m, t, tol)
% test version of the function bundle_conv_sparse
% uses additional counter etc. to check if everything is calculated as
% expected

% simple bundle algorihtm for convex functions where all information is
% exact

% Detailed explanation
% The Algorithm is implemented after the one in the lecture "Nichtglatte
% Optimierung" at TUM, in summer semester 2016 by Professor Ulbrich.
% It is a bundle algorithm that can minimize nonsmooth convex functions.
% The at least one element of the subdifferential has to be known at any
% x-value.

% Input parameter
%       x0          starting value
%       fun         function to be minimized (can be nonsmooth, must be convex)
%       subgr_fun   function that can evaluate a subgradient of fun at every 
%                   given point x. 

%   Output parameter
%       f_hat       optimal function value
%       x_hat       argmin of the objective

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
% m in (0, 1)   
% t > 0         prox / convexification parameter of the subproblem
% tol:          tolerance for terminating the algorithm
defaults = {1000, 0.5, 1, 1e-6};
% set optional input arguments if not set by the user
% Check number of inputs.
if nargin > 8
    error('Too many input arguments: requires at most 4 optional inputs');
end

% Fill in unset optional values.
switch nargin
    case 4
        [kmax, m, t, tol] = defaults{:};
    case 5
        [m, t, tol] = defaults{2:4};
    case 6
        [t, tol] = defaults{3:4};
    case 7
        tol = defaults{4};
end

%% BEGINNING of the algorithm
%% 0 step
tic;

% counters for testing
alpha_nonneg = 0;
alpha_equ_one = 0;
alpha_small = 1;
alpha_big = 0;
e_veryneg = 0;
e_changed = 0;
g_eq_d = 0;
xi_exp1 = 0;
xi_exp2 = 0;
xi_exp3 = 0;

n = length(x0);
i_null = 0;              % null-step counter

x = x0;                  % trial points, important for bundle information
x_hat = x0;              % "serious" point
e = 0;                   % linearization error, in lecture notes alpha
J = 1;                   % index set defining bundle information
lJ = 1;                  % initial lenght of the index set J
f = feval(fun, x0);      % exact function evaluation
f_hat = f;               % function evaluation as x_hat
g = feval(subgr_fun, x0);% one subgradient at point x

%% Global loop
for k = 1 : kmax;

%% 1st step

% solve the following quadratic subproblem for d:
% d = argmin{xi + 1/(2 * t) * norm(d)^2} s.t. g_j'*d - e_j - xi <= 0, for all j in J
% reformultate the problem to use it in quadprog to
% f = 1/2*x*H*x+r*x, s.t. A*x <= b
xi_d0 = zeros(n + 1, 1);  % starting point is optional and only used if the active set method is chosen
H = [zeros(n + 1, 1), [zeros(1, n); 1/t * eye(n)]];
r = [1; zeros(n, 1)];
A = [-ones(lJ, 1), g'];
b = e;
%x_range = -5:0.1:5;
%fun = @(s) max(f + g(:, k)' .* (x_hat + s - x(:, k))) + 1/t * norm(s)
%plot(fun(x_range))
%options_as = optimoptions(@quadprog, 'Algorithm', 'active-set');
options_ip = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
    'MaxIterations', 500, 'ConstraintTolerance', 1.0000e-10, 'OptimalityTolerance', 1.0000e-10);
[xi_d, ~, ~, ~, lambda] = quadprog(H, r, A, b, [], [], [], [], xi_d0, options_ip);

alpha = lambda.ineqlin; % lagrange multiplier for inequality constraints
if max(alpha < 0)
    alpha_nonneg = alpha_nonneg + 1;
end
if min(alpha) < alpha_small && min(alpha) > 0
    alpha_small = min(alpha);
end
alpha_big = max(alpha);
if abs(sum(alpha) - 1) > alpha_equ_one
    alpha_equ_one = abs(sum(alpha) - 1);
end

%% 2nd step
xi = xi_d(1);
d = xi_d(2 : n + 1);
E = alpha' * e;  % aggregate error
G = g * alpha;  % aggregate subgradient

if g_eq_d < norm(G+d)
    g_eq_d = norm(G+d);
end

%% 3rd step

% stopping conditions
if norm(1/t * d) <= tol && E <= tol;  % stopping condition like in lecture
% if norm(G) <= tol && E <= tol;  % stopping condition like in lecture
% if norm(E + G * x_hat) <= tol and E <= tol;  % stopping condition like in conv, inex
% if norm() <= tol;  % stopping condition like in nonconv, exact ???
% if norm(E + t * G) <= tol;  % stopping condition like in nonconv, inex
    fprintf('Algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k, i_null);
    break
end

mk = max(-e + g'*d);

if xi_exp1 < abs(xi + 1/t * norm(d)^2 + E)
    xi_exp1 = abs(xi + 1/t * norm(d)^2 + E);
end
if xi_exp2 < abs(xi - mk)
    xi_exp2 = abs(xi - mk);
end
if xi_exp3 < abs(mk + 1/t * norm(d)^2 + E)
    xi_exp3 = abs(mk + 1/t * norm(d)^2 + E);
end
 
%% 4th, 5th step
f_k_1 =  feval(fun, x_hat + d);  % evaluate function at new iterate
f = [f, f_k_1];  % add information to bundle
g = [g, feval(subgr_fun, x_hat + d)];  % evaluate subgradient at new iterate and add information to bundle
x = [x, x_hat + d];  % add new iterate to bundle


%serious step  test
if f_k_1 - f_hat <= m * xi;   % serious step condition
    x_hat = x_hat + d;   % update x_hat
    f_hat =  f_k_1;  % update f_hat
else
    i_null = i_null + 1;
end

%update bundle
delete = zeros(1,lJ);
for j = 1:lJ;  % update the index set J by marking the indexes that are removed
    if alpha(j) > 1e-9 || norm(x(j) - x_hat) == 0; % alpha only gets down to 1e-5
    else
        delete(j) = 1;
    end
end
J(delete == 1) = [];
f(delete == 1) = [];
x(:,delete == 1) = [];
g(:,delete == 1) = [];  % remove all marked objects from the bundle
J = [J, k+1];                           
    


%% 6th step
lJ = length(J);  % length of the index set J, e.g. for size of constraints in subproblem
e = zeros(lJ, 1);
k_flag = 1;  % change in e should nor be counted for every component 
for j = 1:lJ;
    e_test = f_hat - f(j) - g(:, j)' * (x_hat - x(:, j));  % update linearization error e
    if length(e_test)>1
        pause
    else
        e(j) = e_test;
    end
    if e(j) < 0
        fprintf ('e kleiner 0')
    end
    if e(j) < 0  && e(j) < e_veryneg %-tol * 1e-4
        e_veryneg = e(j); %e_veryneg + 1;
    end
    if e_change
        if e(j) < 0
            e(j) = 0;
            if k_flag == 1
                e_changed = e_changed +1;
                k_flag = 0;
            end
        end
    end
end



end
toc;
if k == kmax
    fprintf('algorithm stopped bcause the maximum number %d of iterations was reached \n', k);
end
%% END of the algorithm
end

