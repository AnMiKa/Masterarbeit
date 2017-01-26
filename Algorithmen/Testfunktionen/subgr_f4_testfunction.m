function [ sgf4 ] = subgr_f4_testfunction( x )
%subgr_f4_testfunction creates a subgradient of the nonsmooth nonconvex 
%testfunction f4

[rows, ~] = size(x);
if rows == 1;
    x = x';
end

sgf4 = subgr_f1_testfunction(x)+x;

end

