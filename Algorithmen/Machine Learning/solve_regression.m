function [ W ] = solve_regression( X, Y, gamma )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

% X:    array --> features x number of instances
% Y:    matrix --> number of instances
% W:    matrix --> features

tic
C = gamma(1);
eps = gamma(2);
[feat,J] = size(X);
    
H = spdiags([ones(feat,1);C*ones(J,1)],0,feat+J,feat+J);
H = full(H);
f = zeros(feat+J,1);
spX = sparse([-X';X']);
A = [spX,-[spdiags(ones(J,1),0,J,J);spdiags(ones(J,1),0,J,J)]];
A = full(A);
b = [-Y; Y]+eps;
%options = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
%'MaxIterations', 50000, 'ConstraintTolerance', 1.0000e-15, 'OptimalityTolerance', 1.0000e-15);
%Wxi = quadprog(H,[],A,b,[],[],[],[],[],options);
% active set version
[Wxi,err] = qpas(H,f,A,b,[],[],[],[],1);
W = Wxi(1:feat);
toc
end

