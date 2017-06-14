% Noll BFGS
function [ Q_new ] = SR1_update_Variation(d,gm,gp,Q)

% bound for Q
bound = 30;

y = gp-gm;
u = y-Q*d;
if norm(d'*u) < 1/bound
    Q_new=Q;
else
    Q_new = Q + (u*u')/(u'*d);
end

% correction to keep Q bounded
m = max(abs(eig(Q_new)));
if m > bound
    Q_new = 1/2*Q;
end
end