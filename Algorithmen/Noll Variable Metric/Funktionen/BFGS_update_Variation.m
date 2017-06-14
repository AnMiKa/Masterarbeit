% Noll BFGS
function [ Q_new ] = BFGS_update_Variation(d,gm,gp,Q)

% bound for Q
bound = 30;

y = gp-gm;
if norm(d'*y) < 1/bound
    Q_new = Q;
else
    Qd = Q*d;
    Q_new = Q + (y*y')/(y'*d)-(Qd*Qd')/(d'*Qd);
end

% correction to keep Q bounded
m = max(abs(eig(Q_new)));
if m > bound
    Q_new = 1/2*Q;
end

end