% Noll BFGS
function [ Q ] = BFGS_update(d,gm,gp,Q)

% bound for Q
bound = 1e5;

y = gp-gm;
% corrections to keep Q bounded
if norm((y*y')/(y'*d),'fro') > 1/3*bound
    fro = norm(y*y','fro');
    Q1 = (y*y')/(fro/(1/3*bound));
else
    Q1 = (y*y')/(y'*d);
end

if norm(((Q*d)*(Q*d)')/(d'*Q*d),'fro') > 1/3*bound
    fro = norm(((Q*d)*(Q*d)'),'fro');
    Q2 = ((Q*d)*(Q*d)')/(fro/(1/3*bound));
else
    Q2 = ((Q*d)*(Q*d)')/(d'*Q*d);
end
    
Q = Q + Q1 - Q2;

end