function [ sgf5 ] = subgr_f5_testfunction( x )
%subgr_f5_testfunction creates a subgradient of the nonsmooth nonconvex 
%testfunction f5

[rows, ~] = size(x);
if rows == 1;
    x = x';
end

if norm(x) == 0
    xx = zeros(length(x));
else
    xx = x / norm(x);
end

sgf5 = subgr_f1_testfunction(x)+(1/2*xx);

end

