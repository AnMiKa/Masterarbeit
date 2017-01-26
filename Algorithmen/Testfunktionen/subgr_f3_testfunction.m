function [ sgf3 ] = subgr_f3_testfunction( x )
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

end

