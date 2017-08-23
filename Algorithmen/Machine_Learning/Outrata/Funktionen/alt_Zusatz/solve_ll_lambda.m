function [ W ] = solve_ll_lambda( l, X, Y, tol )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% General
if nargin == 3
    tol = 1e-15;
end

[feat,J,T] = size(X);
% number of features is actually feat+1 because of implicit bias
W = zeros(feat,T);

% create matrix H(C)
H = spdiags([l*ones(feat,1);ones(J*max(1,(T-1)),1)],0,feat+J*max(1,(T-1)),feat+J*max(1,(T-1)));

for t = 1:T
    % extract training data for the t'th fold
    if T == 1
        Xt = reshape(X,feat,J);
        Yt = reshape(Y,J,1);
    else
        Xt = X;
        Xt(:,:,t,:) = [];
        Xt = reshape(Xt,feat,J*(T-1));
        Yt = Y;
        Yt(:,t,:) = [];
        Yt = reshape(Yt,J*(T-1),1);
    end
    
%% Calculate solution of lower level problem    
    % create matrices for use with quadprog
    A = [sparse(-(Yt.*Xt')),-spdiags(ones(J*max(1,(T-1)),1),0,J*max(1,(T-1)),J*max(1,(T-1)))];
    b = (-ones(J*max(1,(T-1)),1));
    % solve QP with quadprog
    options = optimoptions('quadprog','MaxIterations',1000,'OptimalityTolerance',...
        tol,'ConstraintTolerance',tol);
    w = quadprog(H,[],A,b,[],[],[],[],[],options);
    % solution and multipliers
    W(:,t) = w(1:feat);
end