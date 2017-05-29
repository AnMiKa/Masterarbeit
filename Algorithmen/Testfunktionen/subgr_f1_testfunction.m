function [ sgf1 ] = subgr_f1_testfunction( x, noise )
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

v = 2*rand(length(x),1)-1;
v = v/norm(v);
switch noise
    case 0
    case 1
        sgf1 = sgf1 + 0.01*v;
    case 2
        m = min(0.01,norm(x)/100);
        sgf1 = sgf1 + m*v;
    case 3
        sgf1 = sgf1 + 0.01*v;
    case 4
        m = min(0.01,norm(x)/100);
        sgf1 = sgf1 + m*v;        
end        


end

