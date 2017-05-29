function [ sgf3 ] = subgr_f3_testfunction( x, noise )
%subgr_f3_testfunction creates a subgradient of the nonsmooth nonconvex 
%testfunction f3

K = 0;

N = length(x);
h_vec = zeros(1,N);
for i = 1:N
    h_vec(i) = hi_testfunction(x, i, K);
end 
[~, I] = max(abs(h_vec));

sgf3 = sign(hi_testfunction(x, I, K))*subgr_hi_testfunction(x, I);

v = 2*rand(length(x),1)-1;
v = v/norm(v);
switch noise
    case 0
    case 1
        sgf3 = sgf3 + 0.01*v;
    case 2
        m = min(0.01,norm(x)/100);
        sgf3 = sgf3 + m*v;
    case 3
        sgf3 = sgf3 + 0.01*v;
    case 4
        m = min(0.01,norm(x)/100);
        sgf3 = sgf3 + m*v;        
end        

end

