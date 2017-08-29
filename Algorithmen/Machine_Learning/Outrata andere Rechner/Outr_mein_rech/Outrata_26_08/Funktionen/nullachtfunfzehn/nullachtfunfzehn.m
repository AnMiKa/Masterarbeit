% algorithm to compare with my bilevel-bundle algorithm
function [ C, time, fval ] = nullachtfunfzehn(obj_fun,C0)
tic
options = optimset('Tolfun',1e-10,'TolX',1e-10);
if nargin == 2
    % outer problem unconstrained (not really allowed)
    [C,fval] = fminsearch(obj_fun,C0,options);
else
    % outer problem constrained 
    [C,fval] = fminbnd(obj_fun,1e-5,1e4,options);
end
time = toc;
% fprintf('lambda = %d;     time = %d \n', C, time)
end