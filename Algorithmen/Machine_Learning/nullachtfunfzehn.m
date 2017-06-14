% algorithm to compare with my bilevel-bundle algorithm
% outer problem unconstrained
tic
%function_name = @(lambda) overall_obj(lambda);
[x,fval,exitflag] = fminsearch(@overall_obj,86);
time1 = toc;
fprintf('lambda = %d;     time = %d \n', fval, time1)