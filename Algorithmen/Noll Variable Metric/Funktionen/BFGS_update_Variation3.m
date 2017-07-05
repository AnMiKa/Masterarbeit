% Noll BFGS
function [ Q_new ] = BFGS_update_Variation3(d,gm,gp,Q)

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
[S,D] = schur(Q_new);
e = diag(D);

i = (abs(e) > bound);
j = find(i);
if ~isempty(j)
    for i = 1:length(j)
        D(j(i),j(i)) = 1/10*bound; %*1/2???
    end
    Q_new = (S'\D)/S;
end

end