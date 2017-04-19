% Noll BFGS
function [ Q ] = BFGS_update(d,gm,gp,Q)

y = gp-gm;
Q = Q+(y*y')/(y'*d)-((Q*d)*(Q*d)')/(d'*Q*d);

end