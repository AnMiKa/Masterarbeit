function [ xi_d, alpha ] = solve_class_upper( x_hat, s, c, t, n )
%SOLVE-CLASS-UPPER solves the subproblem of the bundle algorithm for the
%upper level problem in the bilevel setting


% solve the following augmented quadratic subproblem for d:
% d = argmin{xi + 1/(2 * t) * norm(d)^2} s.t. s_j'*d - c_j - xi <= 0, for all j in J
% rewrite the problem to use it in quadprog to
% f = 1/2*x*H*x+r*x, s.t. A*x <= b
% incorporate set D, here as a box of around -x_hat
H = [zeros(n + 1, 1), [zeros(1, n); 1/t * eye(n)]];
r = [1; zeros(n, 1)];
D = [zeros(2*n,1), [diag(-ones(n,1)); diag(ones(n,1))]];
A = [-ones(lJ, 1), s'; D];
b = [c; x_hat+10;-x_hat+10];
options_ip = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
    'MaxIterations', 500, 'ConstraintTolerance', 1.0000e-15, 'OptimalityTolerance', 1.0000e-15);
[xi_d, ~, ~, ~, lambda] = quadprog(H, r, A, b, [], [], [], [], [], options_ip);

alpha = lambda.ineqlin(1:lJ); % lagrange multiplier for inequality constraints



end

