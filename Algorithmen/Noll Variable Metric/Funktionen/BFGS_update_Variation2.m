% Noll BFGS
function [ Q_new ] = BFGS_update_Variation2(d,gm,gp,Q)

% bound for Q
bound = 1e8;

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
e = eig(Q);
e_new= eig(Q_new);

i = (abs(e-e_new)/norm(d) > bound);
j = find(i);
if ~isempty(j)
    [S,D] = schur(Q_new);
    for i = 1:length(j)
        D(j(i),j(i)) = 1/2*e(j(i));
    end
    Q_new = (S'\D)/S;
end

% correction to keep Q bounded
m = max(abs(eig(Q_new)));
if m > bound
    Q_new = bound/m*Q;
end

end