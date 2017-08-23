function [ W, Xi, Mult ] = solve_ll_hinge_outr( C, X, Y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[feat,J,T,G] = size(X);
% number of features is actually feat+1 because of implicit bias
W = zeros(feat,T);
Xi = zeros(J*max(1,(T-1))*G,T);
Mult = zeros(2*J*max(1,(T-1))*G,T);
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
    H = spdiags([ones(1,feat),zeros(1,J*G*max(1,(T-1)))]',0,feat+J*G*max(1,(T-1)),feat+J*G*max(1,(T-1)));
    Cvec = zeros(J*G*max(1,(T-1)),1);
    for g = 1:G
        Cvec((g-1)*J*max(1,(T-1))+1:g*J*max(1,(T-1))) = C(g)*ones(J*max(1,(T-1)),1);
    end
    h = [zeros(feat,1);Cvec];
    A = sparse([[-(Xt.*Yt)', -diag(ones(J*G*max(1,(T-1)),1))];...
        [zeros(J*G*max(1,(T-1)),feat), -diag(ones(J*G*max(1,(T-1)),1))]]);
    b = sparse([-ones(J*G*max(1,(T-1)),1); zeros(J*G*max(1,(T-1)),1)]);
    % solve QP with quadprog
    options = optimoptions('quadprog','MaxIterations',1000,'OptimalityTolerance',...
        1e-15,'ConstraintTolerance',1e-15);
    [w,~,~,~,mult] = quadprog(H,h,A,b,[],[],[],[],[],options);
    % solution and multipliers
    W(:,t) = w(1:feat);
    Xi(:,t) = w(feat+1:end);
    Mult(:,t) = mult.ineqlin;
end
end

