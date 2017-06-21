% algorithm to compare with my bilevel-bundle algorithm
% outer problem unconstrained
tic
%function_name = @(lambda) overall_obj(lambda);
%[x,fval,exitflag] = fminsearch(@overall_obj,1);
%[x,fval,exitflag] = fminbd(@overall_obj,0.1);
time1 = toc;
fprintf('lambda = %d;     time = %d \n', x, time1)