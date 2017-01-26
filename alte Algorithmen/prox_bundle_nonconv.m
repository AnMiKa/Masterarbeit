function [ f_hat, x_hat, x, i_null  ] = ...
    prox_bundle_nonconv( x0, fun, subgr_fun, subprob_flag, lm_flag, J_flag)



%%  proximal bundle method suitable for nonconvex functions
%   and inexact input data
%   implementation of the presented alrorithm in the paper "A proximal
%   bundle emthod for nonsmooth nonconvex functions with inexact
%   information" by W. Hare, C. Sagastizábal and M. Solodov, Springer Comput Optim Appl (2016) 

%%   Detailed explanation goes here

%   needed: procedure providing for each x a value f approximating the
%   function value f(x) and a vector g approximating some element of the
%   subdifferential of f at x

%   input arguments:    x0          starting point
%                       fun         objective function
%                       subgr_fun   subgradient? of objective function 
%                       subprob_flag    decides which subproblem solver to use

%   output arguments:   last f_hat value
%                       last x_hat-value
%                       all x-values
%                       number of null-steps

%   variables that appear in algorithm:
%       f       approximation of f(x)
%       f_hat   approximation of f(x_hat)
%       x_hat   algorithmic center; best known point up to k'th iteration
%       g       approximation of element of subdifferential of f at x
%       d       search direction
%       G, nu
%       E
%       delta   predicted decease
%       eta
%       c
%       
%       J       index set J \subset {1,...,k}, stores which information is
%       in the bundle
%       M0       modelfunction in first iteration
%       sub_prob_fun1 objective function of the min-max-subproblem
%       sub_prob_fun2 objective function of the reformulated subproblem

%%

%   parameter to be chosen:
%   set globally? make sure not changable?
       m = 0.05;          % \in (0; 1) ???
       gamma = 2;      % > 0        ???
       tol = 1e-6;        % >= 0       stopping tolerance
       kmax  = 100;     % maximal number of iterations

%   to be chosen, but not globally
       t = 1;          % > 0 initial inverse prox-parameter


%%   BEGINNING of the algorithm
tic;

n = length(x0); % dimension of input value
i_null = 0; % null-step counter
I_NULL = zeros(1, kmax);

 
%f = zeros(1, kmax + 1);
f_saved = zeros(1, kmax + 1);
f = feval(fun, x0);      % size depends on bundle, controlled by J
f_saved(1) = feval(fun, x0);  
%f(1) = feval(fun, x0);  
%g = zeros(n, kmax + 1);
g_saved = zeros(n, kmax + 1);
g = feval(subgr_fun, x0); %subgradient(subgr_fun, x0); % TODO
%g(:,1) =  feval(subgr_fun, x0); %subgradient(subgr_fun, x0); % TODO
%x = [x0, zeros(n, kmax)];
x_saved = [x0, zeros(n, kmax)];
x = x0;      % size depends on bundle, controlled by J
x_hat = x0;
x_hat_saved = [x0, zeros(n, kmax)];
f_hat = f; % do not calculate again (for time; and random procedure can give different result)
f_hat_saved = zeros(1, kmax + 1);
f_hat_saved(1) = f;
sum_alpha_saved = zeros(1, kmax);

% matrices and vectors are created with default values to assign the
% memory space
%J = [1, zeros(1,kmax - 1)]; % row-vector 1 x kmax
J = 1;                       % size varies in each step
%e = zeros(1, kmax);         % row-vector 1 x kmax
%e = 0;                       % size depends on J
%eta_j = zeros(1, kmax);     % row-vector to obtain max in eta, 1 x kamx
% eta = gamma;               % scalar
%b = zeros(1, kmax);         % row-vector 1 x kmax
%b = 0;                       % size depends on J
%c = zeros(1, kmax);         % row-vector 1 x kmax
%c = 0;                       % size depends on J
%s = [g(:,1), zeros(n, kmax - 1)]; % matrix, n x kmax
%s = g;                       % size depends on J
i_E_non_equ = 0;
k_non_equ = [];

for k = 1:kmax;
    %% 1. trial point finding and stopping test
   
    % calculating e, eta, b, c, s for step k
    lJ = length(J);
    e = zeros(1, lJ);         % row-vector 1 x |J|
    for j = 1:lJ;
        e(j) = f_hat - f(j) - g(:,j)'* (x_hat - x(:,j));
    end                        % can be put in one loop with eta_j
    
    eta_j = zeros(1, lJ);     % row-vector to obtain max in eta, 1 x |J|
    for l = 1:lJ;
        if norm(x(:, l) - x_hat) > 1e-10; % better if known at which position is x_hat -> leave this out
            eta_j(l) = -2 * e(l) / (norm(x(:,l) - x_hat))^2;
        else
            eta_j(l) = 0;
        end
    end
    eta = max(0, max(eta_j)) + gamma;
    
    b = zeros(1, lJ);         % row-vector 1 x |J|
    c = zeros(1, lJ);         % row-vector 1 x |J|
    s = zeros(n, lJ);         % matrix, n x |J|
    for j = 1:lJ;
        b(j) = eta / 2 * norm(x(:,j) - x_hat)^2;
        c(j) = e(j) + b(j);
        if c(j) < 0;
            disp('c kleiner 0');
        end
        s(:,j) = g(:,j) + eta * (x(:,j) - x_hat);
    end
    
%%    
    % subprocedure solving subproblem (11) -> output d
    % choose sensible set D defined by D * x <= B
    %  !!!! wie hängt Menge mit x zusammen? x ist am Ende immer genau der
    %  Kugelradius!?! Wenn man D weglässt (also D = R^n) dann funktioniert
    %  es beim Parabelbeispiel
    
    if subprob_flag == 1
        D1 = [-ones(lJ, 1), s'];
        %B1 = -f_hat * ones(lJ, 1) - c';
        B1 = -f_hat * ones(lJ, 1) + c';
        D2 = [zeros(2 * n, 1), [eye(n); -eye(n)]];
        B2 = [10 * ones(n,1) - x_hat; -10 * ones(n,1) + x_hat];
        A = [D1; D2];
        B = [B1; B2];
        % choose sensible starting point d0
        xi_d0 = zeros(n + 1, 1);
        Sub_prob_fun2 = @(xi_d) xi_d(1) + 1/(2 * t) * norm(xi_d(2:end))^2;
        options_as = optimoptions(@fmincon,'Algorithm','active-set','TolCon',1e-10,'TolFun',1e-8);
        options_ip = optimoptions(@fmincon,'Algorithm','interior-point','TolCon',1e-10,'TolFun',1e-8);
        [xi_d, ~, ~, ~, lambda, ~, hessian] = ...
                   fmincon(Sub_prob_fun2, xi_d0, A, B, [], [], [], [], [], options_ip);
        d = xi_d(2:end);
    elseif subprob_flag == 2
        xi_d0 = zeros(n + 1, 1);
        H = 1 / t * [zeros(1, n + 1); zeros(n, 1) eye(n, n)];
        h = [1 zeros(1, n)];
        D1 = [-ones(lJ, 1), s'];
        B1 = -f_hat * ones(lJ, 1) - c';
        %D2 = [zeros(2 * n, 1), [eye(n); -eye(n)]];
        %B2 = [10 * ones(n,1) - x_hat; -10 * ones(n,1) + x_hat];
        A = [D1]; % D2];
        B = [B1]; % B2];
        options_as = optimoptions(@quadprog,'Algorithm','active-set','TolCon',1e-10,'TolFun',1e-8);
        options_ip = optimoptions(@quadprog,'Algorithm','interior-point-convex','TolCon',1e-10,'TolFun',1e-8);
        [xi_d, ~, ~, ~, lambda] = ...
                    quadprog(H, h, A, B, [], [], [], [], xi_d0, options_ip);
        d = xi_d(2:end);
    else % not good, much more iterations, not so good result
        D = [eye(n); -eye(n)];
        B = [2 * ones(n,1) - x_hat; 2 * ones(n,1) + x_hat];
        % choose sensible starting point d0
        d0 = zeros(n, 1); % column-vector
        Sub_prob_fun1 = @(d) repmat(f_hat, lJ, 1) - c' + s' * d + repmat(1/(2 * t) * norm(d)^2, lJ, 1);
        d = fminimax(Sub_prob_fun1, d0, D, B);
    end

     
    x(:, lJ + 1) = x_hat + d;
    x_saved(:, k + 1) = x_hat + d;
    
    if J_flag
        alpha = lambda.ineqlin(1:lJ);
        sum_alpha_saved(k) = sum(alpha);
    end
    
    if lm_flag
        alpha = lambda.ineqlin(1:lJ);
        sum_alpha_saved(k) = sum(alpha);
        G_lm = s * alpha;
        nu = -1 / t * d - G_lm;
        E2  = c * alpha;
        M = @(d) f_hat + max(-c' + s' * d); % scalar
        E1 = M(x_hat) - M(x(:,lJ + 1)) + G_lm' * d;
        
        if abs(E1 - E2) > 1e-10
            i_E_non_equ = i_E_non_equ + 1;
            k_non_equ = [k_non_equ, k];
        end 
        
        if E1 < 0 
            disp('E1 kleiner 0')
        end
        if E2 < 0 
            disp('E2 kleiner 0')
        end
        
    else
        % nu element of subdifferential of indicator-function of set D at x_k+1
        % is it important which element from the subdifferential is chosen? If
        % not: choose always nu = 0
        nu = 0; % ???
        G_nu = -1/t * d - nu;
        M = @(d) f_hat + max(-c' + s' * d); % scalar
        % !!! E3 not always >= 0!!!
        E3 = M(x_hat) - M(x(:,lJ + 1)) + G_nu' * d;
        if E3 < 0 
            disp('E3 kleiner 0')
        end
    end
    
    if lm_flag == 1;
    delta = E1 + t * norm(G_lm + nu)^2;
    elseif lm_flag == 2;
    delta = E2 + t * norm(G_lm + nu)^2;  % predicted decrease
    else
    delta = E3 + t * norm(G_nu + nu)^2;
    %delta = delta3;
    end
    if delta < tol;
        fprintf('algorithm stopped successfully by meeting tolerance after  %d  iterations and %d null-steps. \n', k, i_null);
        break
    end
    
    %% 2. descent test
    %f = [f, 0];
    f(lJ + 1) = feval(fun, x(:,lJ + 1));
    f_saved(k + 1) = feval(fun, x_saved(:, k + 1));
    g(:,lJ + 1) = feval(subgr_fun, x(:, lJ + 1)); %subgradient(subgr_fun, x);
    g_saved(:, k + 1) = feval(subgr_fun, x_saved(:, k + 1));
   if f(lJ +  1) > f_hat - m * delta;   % 3. null step 
        i_null = i_null + 1;
        I_NULL(k) = 1;
        x_hat_saved(: , k + 1) = x_hat;
        f_hat_saved(k + 1) = f_hat;
        % choose 0 < t (new t) < t (old t)
        t = 0.7 * t; % use parameter to control how new t is chosen?
        if J_flag
            for j = 1:lJ;
                if alpha(j) > 1e-6 || norm(x(j) - x_hat) < 1e-6;
                else J(j) = 0;
                end
            end
         J(J == 0) = [];
        end
        J = [J, k+1];
    else                        % serous step
        x_hat = x(:, lJ + 1);
        x_hat_saved(: , k + 1) = x_hat;
        f_hat = f(lJ + 1);
        f_hat_saved(k + 1) = f_hat;
        % choose t > 0; ???????
        % t = t; % ????
        if J_flag
            for j = 1:lJ;
                if alpha(j) > 1e-6;
                else J(j) = 0;
                end
            end
            J(J == 0) = [];
        end
        J = [J, k+1];
   end
  
end
x_saved;
x_hat_saved;
f_saved;
f_hat_saved;
I_NULL;
k;
i_E_non_equ;
k_non_equ;
sum_alpha_saved;
toc;
%    END of the algorithm
end

