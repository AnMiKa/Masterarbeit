function [ d, xi, alpha ] = solve_ul_reg_qpas( x_hat, s, c, t )
%SOLVE_UL_QPAS solver for the subproblem of the bundle algorithm using Dr.
%Adrian Wills' qpas algorithm
%   This function solves the quadratic subproblem occuring in every step of
%   the bundle algorithm to compute the new trial step d and the
%   corresponding Langrange multipliers alpha.
%   The function uses the qpas algorithm from the QPC project maintained by
%   Dr. Adrian Wills for this task.
 
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

fprintf('Solve the bundle subproblem for a trial step and Lagrange multipliers. \n')
tic

[n,lJ] = size(s);

% assemble the matrices used in qpas
H = [zeros(n + 1, 1), [zeros(1, n); 1/t * eye(n)]];
r = [1; zeros(n, 1)];
A = [-ones(lJ, 1), s'];
b = c;
lb = [-Inf,[-x_hat+1e-15,-x_hat]]';   % bounds for [xi, d=[C >0, eps >=0]]
% solve the actual subproblem
[xi_d,~,lambda] = qpas(H,r,A,b,[],[],lb,[],0);
% extract the lagrange multipliers of the inequality constraints
% corresponding to the affine linear approximation of the objective
% function
alpha = lambda.inequality(1:lJ);
% gives a warnig if sum(alpha) not close enough to 1
if abs(norm(alpha)-1) > 1e-15
    warning('abs(norm(alpha)-1) > 1e-15')
end

d = xi_d(2:end);
% gives a warning if d(1) == 0
if d(1) <= 0
    warning('lambda <= 0')
end
xi = xi_d(1);
toc
end