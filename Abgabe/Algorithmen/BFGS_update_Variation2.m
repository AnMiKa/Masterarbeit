function [ Q_new ] = BFGS_update_Variation2(d,gm,gp,Q)
% BFGS update for the variable metric bundle algorithms
% "bundle_variable_metric" and "bundle_bilevel_variable_metric".
% calculates a BFGS update from the step and the subgradient difference and
% scales single eigenvalues if they get too large.

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

% correction of too high eigenvalues
[S,D] = schur(Q_new);
e = diag(D);

i = (abs(e) > bound);
j = find(i);
if ~isempty(j)          % scale only eigenvalues that are too large
    for i = 1:length(j)
        D(j(i),j(i)) = 1/10*bound;
    end
    Q_new = (S'\D)/S;
end

end