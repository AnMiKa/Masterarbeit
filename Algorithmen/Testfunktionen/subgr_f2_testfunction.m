function [ sgf2 ] = subgr_f2_testfunction( x, noise )
%subgr_f2_testfunction creates a subgradient of the smooth nonconvex 
%testfunction f2

K = 0;

N = length(x);
sgh_mat = zeros(N,N);
h_vec = zeros(1,N);
for i = 1:N
    sgh_mat(:,i) = subgr_hi_testfunction(x, i);
    h_vec(i) = hi_testfunction(x, i, K);
end 
sgf2 = sum(bsxfun(@times, sgh_mat, 2*h_vec),2);

v = 2*rand(length(x),1)-1;
v = v/norm(v);
switch noise
    case 0
    case 1
        sgf2 = sgf2 + 0.01*v;
    case 2
        m = min(0.01,norm(x)/100);
        sgf2 = sgf2 + m*v;
    case 3
        sgf2 = sgf2 + 0.01*v;
    case 4
        m = min(0.01,norm(x)/100);
        sgf2 = sgf2 + m*v;        
end        

end

