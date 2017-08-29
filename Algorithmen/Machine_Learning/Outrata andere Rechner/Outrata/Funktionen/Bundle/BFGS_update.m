% Noll BFGS
function [ Q ] = BFGS_update(d,gm,gp,Q)

% bound for Q
bound = 1e8;

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