function [ f1 ] = f1_testfunction( x, noise, K )
%f1_testfunction creates a nonsmooth nonconvex testfunction
%    source: A redistributed bundle method for nonconvex optimization by
%   Warren Hare and Claudia Sagastizabal, SIAM J. Optim. Vol. 20, No. 8,
%   2010
%   Parameter K for the function hi_testfunction has to be set


switch nargin
    case 1
        noise = 0;
        K = 0;
    case 2
        K = 0;
end

N = length(x);
h_vec = zeros(1,N);
for i = 1:N
    h_vec(i) = hi_testfunction(x, i, K);
end
f1 = sum(abs(h_vec));

switch noise
    case 0
    case 1
        f1 = f1 + 0.02*rand(1)-0.01;
    case 2
        m = min(0.01,norm(x)/100);
        f1 = f1 + 2*m*rand(1)-m;
    case 3
    case 4
end
        
end

