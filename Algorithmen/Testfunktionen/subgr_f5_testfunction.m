function [ sgf5 ] = subgr_f5_testfunction( x, noise )
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

sgf5 = subgr_f1_testfunction(x,0)+(1/2*xx);

v = 2*rand(length(x),1)-1;
v = v/norm(v);
switch noise
    case 0
    case 1
        sgf5 = sgf5 + 0.01*v;
    case 2
        m = min(0.01,norm(x)/100);
        sgf5 = sgf5 + m*v;
    case 3
        sgf5 = sgf5 + 0.01*v;
    case 4
        m = min(0.01,norm(x)/100);
        sgf5 = sgf5 + m*v;        
end        

end

