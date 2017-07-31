% algorithm to compare with my bilevel-bundle algorithm
function [ lambda, time1, fval, exitflag ] = nullachtfunfzehn(lambda0)
% outer problem unconstrained
tic
%function_name = @(lambda) overall_obj(lambda);
% options = optimset('Tolfun',1e-10,'TolX',1e-10);
% if nargin == 1
%     [lambda,fval,exitflag] = fminsearch(@overall_obj,lambda0,options);
% else
%     [lambda,fval,exitflag] = fminbnd(@overall_obj,1e-15,1e4,options);
% end
n = length(lambda0);
[lambda,fval,exitflag] = fmincon(@overall_obj,lambda0,[],[],[],[],zeros(1,n),[],[],[]);
time1 = toc;
fprintf('lambda = %d;     time = %d \n', lambda, time1)
end