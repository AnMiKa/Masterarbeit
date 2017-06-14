% Noll BFGS
function [ Q ] = SR1_update(d,gm,gp,Q)

% bound for Q
bound = 1e7;

y = gp-gm;
u = y-Q*d;
if norm(d'*u) < 1/bound
    Q=Q;
else
    Q = Q + (u*u')/(u'*d);
end

% correction to keep Q bounded
m = max(abs(eig(Q)));
if m > bound
    Q = bound/m*Q;
end
end