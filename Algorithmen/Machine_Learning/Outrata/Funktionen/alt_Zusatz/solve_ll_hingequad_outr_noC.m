function [ W ] = solve_ll_hingequad_outr_noC( X, Y, tol )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if nargin == 2
    tol = 1e-15;
end

[feat,J,T,G] = size(X);
% number of features is actually feat+1 because of implicit bias
W = zeros(feat,T);

H = spdiags([zeros(1,feat),ones(1,J*G*max(1,(T-1)))]',0,feat+J*G*max(1,(T-1)),feat+J*G*max(1,(T-1)));

for t = 1:T
    % extract training data for the t'th fold
    if T == 1
        Xt = reshape(X,feat,J*G);
        Yt = reshape(Y,1,J*G);
    else
        Xt = X;
        Xt(:,:,t,:) = [];
        Xt = reshape(Xt,feat,J*G*(T-1));
        Yt = Y;
        Yt(:,t,:) = [];
        Yt = reshape(Yt,1,J*G*(T-1));
    end
    % create matrices for use with quadprog
    A = [-sparse((Xt.*Yt)'), -spdiags(ones(J*G*max(1,(T-1)),1),0,J*G*max(1,(T-1)),J*G*max(1,(T-1)))];
    b = (-ones(J*G*max(1,(T-1)),1));
    % solve QP with quadprog
    options = optimoptions('quadprog','MaxIterations',1000,'OptimalityTolerance',...
        tol,'ConstraintTolerance',tol);
    w = quadprog(H,[],A,b,[],[],[],[],[],options);
    % solution and multipliers
    W(:,t) = w(1:feat);
end
end

