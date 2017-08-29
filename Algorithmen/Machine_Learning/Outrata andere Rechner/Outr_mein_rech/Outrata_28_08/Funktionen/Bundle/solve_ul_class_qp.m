function [ d, xi, alpha ] = solve_ul_class_qp( x_hat, s, c, t )
%SOLVE_UL_QP solver for the subproblem of the bundle algorithm using
%MATLAB's quadprog algorithm
%   This function solves the quadratic subproblem occuring in every step of
%   the bundle algorithm to compute the new trial step d and the
%   corresponding Langrange multipliers alpha.
%   The function uses MATLAB's quadprog algorithm in the interior point
%   verion for this.
 
% input arguments
% name      obgect --> dimensions
% s:        matrix --> n x size of bundle
% c:        vector --> size of bundle
% t:        number --> >0

% output arguments
% d:        vector --> n
% xi:       number --> 1
% alpha:    vector --> size of bundle
 
% Solve the following quadratic subproblem for d:
% d = argmin{xi + 1/(2 * t) * norm(d)^2} s.t. s_j'*d - c_j - xi <= 0, for all j in J
% rewrite the problem to use it in qpas to
% f = 1/2*x*H*x+r*x
% s.t. A*x <= b
%       lb <= x <= ub
% incorporate additional constraints of the upper level problem

%fprintf('Solve the bundle subproblem for a trial step and Lagrange multipliers. \n')
%tic

[n,lJ] = size(s);

% assemble the matrices used in quadprog
H = [zeros(n + 1, 1), [zeros(1, n); 1/t * eye(n)]];
r = [1; zeros(n, 1)];
A = [-ones(lJ, 1), s'];
b = c;
lb = [-Inf,-x_hat'+1e-5*ones(1,n)]';   % bounds for [xi, d=lambda]
ub = [Inf,-x_hat'+1e4*ones(1,n)]';
% problem has to be solved rather exact because the bundle algorithm
% assumes d to be the argmin of the given subproblem
options_ip = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
   'MaxIterations', 5000, 'ConstraintTolerance', 1.0000e-15, 'OptimalityTolerance', 1.0000e-15);
% solve the actual subproblem
[xi_d, ~, ~, ~, lambda] = quadprog(H, r, A, b, [], [], lb, ub, [], options_ip);
% extract the lagrange multipliers of the inequality constraints
% corresponding to the affine linear approximation of the objective
% function
alpha = lambda.ineqlin(1:lJ);
% gives a warnig if sum(alpha) not close enough to 1
if abs(sum(alpha)-1) > 1e-15
    warning('abs(norm(alpha)-1)  = %d',abs(norm(alpha)-1))
end

d = xi_d(2:end);
% gives a warning if d == 0
if d == 0
    warning('lambda = 0')
end
xi = xi_d(1);
%toc
end