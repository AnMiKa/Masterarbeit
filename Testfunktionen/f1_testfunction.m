function [ f1 ] = f1_testfunction( x )
%f1_testfunction creates a nonsmooth nonconvex testfunction
%    source: A redistributed bundle method for nonconvex optimization by
%   Warren Hare and Claudia Sagastizabal, SIAM J. Optim. Vol. 20, No. 8,
%   2010
%   Parameter K for the function hi_testfunction has to be set

K = 0;

N = length(x);
h_vec = zeros(1,N);
for i = 1:N
    h_vec(i) = hi_testfunction(x, i, K);
end
f1 = sum(abs(h_vec));

end

