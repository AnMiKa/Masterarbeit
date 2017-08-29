% algorithm to compare with my bilevel-bundle algorithm
function [ C, time, fval ] = nullachtfunfzehn_group(obj_fun,C0)
tic
n = length(C0);
options = optimoptions('fmincon','ConstraintTolerance',1e-10,'OptimalityTolerance',1e-10);
[C, fval] = fmincon(obj_fun,C0,[],[],[],[],1e-1*ones(n,1),1e4*ones(n,1),[],options);
time = toc;
end