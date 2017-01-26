function [ sgf1 ] = subgr_f1_testfunction( x )
%subgr_f1_testfunction creates a subgradient of the nonsmooth nonconvex 
%testfunction f1

K = 0;

N = length(x);
sgh_mat = zeros(N,N);
sgn_h = zeros(1,N);
for i = 1:N
    sgh_mat(:,i) = subgr_hi_testfunction(x, i);
    sgn_h(i) = sign(hi_testfunction(x, i, K));
end 
sgf1 = sum(bsxfun(@times, sgh_mat, sgn_h),2);

end

