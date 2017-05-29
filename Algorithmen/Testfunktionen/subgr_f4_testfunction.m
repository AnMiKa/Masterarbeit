function [ sgf4 ] = subgr_f4_testfunction( x, noise )
%subgr_f4_testfunction creates a subgradient of the nonsmooth nonconvex 
%testfunction f4

[rows, ~] = size(x);
if rows == 1;
    x = x';
end

sgf4 = subgr_f1_testfunction(x,0)+x;

v = 2*rand(length(x),1)-1;
v = v/norm(v);
switch noise
    case 0
    case 1
        sgf4 = sgf4 + 0.01*v;
    case 2
        m = min(0.01,norm(x)/100);
        sgf4 = sgf4 + m*v;
    case 3
        sgf4 = sgf4 + 0.01*v;
    case 4
        m = min(0.01,norm(x)/100);
        sgf4 = sgf4 + m*v;        
end        

end

