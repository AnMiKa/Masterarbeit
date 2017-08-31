function [ Q_new ] = BFGS_update_Variation1(d,gm,gp,Q)
% BFGS update for the variable metric bundle algorithms
% "bundle_variable_metric" and "bundle_bilevel_variable_metric".
% calculates a BFGS update from the step and the subgradient difference and
% scales it if the eigenvalues get too large.

% bound for Q
bound = 1e8;

% BFGS update
y = gp-gm;
if Q == 0
    Q_new = (y*y')/(y'*d);
elseif abs(d'*y) < 1/bound || abs(d'*Q*d) < 1/bound
    Q_new = Q;
else
    Qd = Q*d;
    Q_new = Q +(y*y')/(y'*d) -(Qd*Qd')/(d'*Qd);
end

% correction to keep Q bounded
m = max(abs(eig(Q_new)));
if m > bound
    Q_new = 1/2*Q;
end

end