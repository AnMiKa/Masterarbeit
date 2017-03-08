function [ W ] = solve_lower_reg( X, Y, gamma )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

% X:    array --> features x size of partition of training set x number of folds
% Y:    matrix --> size of partition of training set x number of folds
% W:    matrix --> features x number of folds

fprintf('Solve the lower level problem for given hyperparameters. \n')
tic
C = gamma(1);
eps = gamma(2);
[feat,J,T] = size(X);
W = zeros(feat,T);
for t = 1:T
    Xt = X;
    Yt = Y;
    Xt(:,:,t) = [];
    Yt(:,t) = [];
    Xt = reshape(Xt,feat,J*(T-1));
    Yt = reshape(Yt,J*(T-1),1);

% or if X matrix, Y vector where partitions are stacked below each other
% then J and T have to be known
% doesn't work now
%     Xt = X(:,J*(T-1)*t-J*(T-1)-1:J*(T-1));
%     Yt = (J*(T-1)*t-J*(T-1)-1:J*(T-1));
%     
    H = [eye(feat), zeros(feat,J*(T-1)); zeros(J*(T-1),feat),C*eye(J*(T-1))];
    A = [[-Xt';Xt'],-[eye(J*(T-1));eye(J*(T-1))]];
    b = [-Yt; Yt]+eps;
    % should actually be no problem, to solve this problem not so accurate,
    % because inexact bundle algorithm made for this!
    options = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
    'MaxIterations', 500, 'ConstraintTolerance', 1.0000e-10, 'OptimalityTolerance', 1.0000e-10);
    Wxi = quadprog(H,[],A,b,[],[],[],[],[],options);
    W(:,t) = Wxi(1:feat);
end
toc
end
