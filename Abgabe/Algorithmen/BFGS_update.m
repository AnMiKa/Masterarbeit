function [ Q ] = BFGS_update(d,gm,gp,Q)
% BFGS update for the variable metric bundle algorithms
% "bundle_variable_metric" and "bundle_bilevel_variable_metric".
% calculates a BFGS update from the step and the subgradient difference and
% scales it if the eigenvalues get too large.

% bound for Q
bound = 1e8;

% BFGS update
y = gp-gm;
if Q == 0
    Q = (y*y')/(y'*d);
elseif norm(d'*y) < 1/bound || abs(d'*Q*d) < 1/bound
else
    Qd = Q*d;
    Q = Q + (y*y')/(y'*d)-(Qd*Qd')/(d'*Qd);
end

% correction to keep Q bounded
m = max(abs(eig(Q)));
if m > bound
    Q = bound/m*Q;
end
end