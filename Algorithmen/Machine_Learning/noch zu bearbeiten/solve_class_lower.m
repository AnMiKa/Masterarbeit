function [ w,b ] = solve_class_lower( lambda, wbound, y, X )
%SOLVE_CLASS_LOWER solver for the lower level problem of the bilevel
%formulation of the support vector classification model
%   Form PhD thesis: "A bilevel optimization approach to machine learning"
%   by Autam Kunapuli

% X, y must only be data from training sets

%g = @(w,b,xi) lambda/2*sum(w.^2)+sum(xi);
nw = length(wbound);
Nt = length(y);
H = lambda*[[eye(nw);zeros(1+Nt,nw)], zeros(nw+1+Nt,1+Nt)];
h = [zeros(nw+1,1);ones(Nt,1)];
yx = bsxfun(@times,y,X');
A = [[yx, y, -eye(Nt)]; [zeros(Nt,nw+1), -eye(Nt)]];
r = ones(2*Nt,1);
l = -wbound;
u = wbound;
res = quadprog(H,h,A,r,[],[],l,u);

w = res(1:nw);
b = res(nw+1);
%xi = res(nw+2:end);
end

