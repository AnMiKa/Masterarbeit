function [ subgr_ul ] = adjoint_prob( H, gupp, A, Ip, M, W, Xi, tol )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if nargin == 5
    tol = 1e-15;
end

[n,m,T] = size(A);
subgr_ul = zeros(m,T);

for t = 1:T
    % extract training data for the t'th fold
    % create matrices for use with quadprog
    I = [Ip(Ip(:,t)>0,t),M(M(:,t)>0,t)];
    Aac = A(I,:,t);
    [l,~] = size(Aac);
    b = zeros(l,1);
    % solve QP with quadprog
    options = optimoptions('quadprog','MaxIterations',1000,'OptimalityTolerance',...
        tol,'ConstraintTolerance',tol);
    % solution of the adjoint problem
    p = quadprog(H,[-gupp;zeros(n,0)],[],[],Aac,b,[],[],[],options);
    % calculation of the subgradient for the t'th fold
    JCH = zeros(G,feat+J*max(1,(T-1)));
    for g = 1:G
        JCH(g,feat+(g-1)*J*max(1,(T-1))+1:feat+g*J*max(1,(T-1))) = ...
            Xi((g-1)*J*max(1,(T-1))+1:feat+g*J*max(1,(T-1)),t);
    end

    subgr_ul(:,t) = -(JCH*[W(:,t);Xi(:,t)])'*p;
end

end

