function [ hi ] = hi_testfunction( x, i, K )
%h_i_testfunction creates the i'th h-function for the nonsmooth nonconvex
%testfunctions
%   source: A redistributed bundle method for nonconvex optimization by
%   Warren Hare and Claudia Sagastizabal, SIAM J. Optim. Vol. 20, No. 8,
%   2010
%   the following conditions need to hold:
%   i <= length(x)

% warning if i > length(x)?

hi = (i * x(i)^2 - 2 * x(i) - K) + sum(x);
end

