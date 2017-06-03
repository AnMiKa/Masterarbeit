function [ zeta ] = solve_class_noncont( y, X, w, b )
%SOLVE-CLASS-NONCONT sloves the subproblem arising from the otherwise
%noncontinuous upper level objective function
%   From PhD thesis "A bilevel optimization approach to machine learning"
%   by Gautam Kunapuli.

% X,y mus only be the data from the validation sets

l = length(w);
f = @(zeta) sum(zeta.*y.*(X'*w-b*ones(l,1)));
zeta = linprog(f,[],[],[],[],0,1);

end

