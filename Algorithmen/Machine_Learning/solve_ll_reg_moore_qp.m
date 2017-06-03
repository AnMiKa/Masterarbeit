function [ W ] = solve_ll_reg_moore_qp( X, Y, gamma )
%SOLVE_LL_REGRESSION_MOORE_QP Solves the lower level problem for a
%bilevel SVM regression algorithm using MATLAB's quadprog algorithm 
%   This is a subroutine to the bilevel bundle algorithm.
%   The algorithm solves the lover level regression problem given as a
%   constraint in the bilevel SVM regression algorithm presented in "Model
%   selection for primal SVM" by Gregory Moore, Charles Bergeron and
%   Kristin P. Bennett.
%   The algorithm uses MATLAB's quadprog algorithm in a sparse formulation
%   of the matrices.

% input arguments
% name      object  --> dimensions
% X:        array   --> features x size of training set x number of folds
% Y:        matrix  --> size of training set x number of folds
% gamma:    vector  --> number of hyper parameter (2: C, eps)

% output arguments
% W:        matrix  --> features x number of folds

fprintf('Solve the lower level regression problem for given hyperparameters. \n')
tic
C = gamma(1);
eps = gamma(2);
[feat,J,T] = size(X);
W = zeros(feat,T);
for t = 1:T
    % select the partition of the trainings set corresponding to the t'th
    % fold
    Xt = X;
    Yt = Y;
    Xt(:,:,t) = [];
    Yt(:,t) = [];
    Xt = reshape(Xt,feat,J*(T-1));
    Yt = reshape(Yt,J*(T-1),1);
    
    % prepare the matrices used in the quadprog algorithm
    H = spdiags([ones(feat,1);C*ones(J*(T-1),1)],0,feat+J*(T-1),feat+J*(T-1));
    spX = sparse([-Xt';Xt']);
    A = [spX,-[spdiags(ones(J*(T-1),1),0,J*(T-1),J*(T-1));spdiags(ones(J*(T-1),1),0,J*(T-1),J*(T-1))]];
    b = [-Yt; Yt]+eps;
    % set the options for the algorithm
    % should be no problem if the tolerances are lower, because the used
    % bundle algorithm is designed to work with inexact information
    options = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
    'MaxIterations', 500, 'ConstraintTolerance', 1.0000e-10, 'OptimalityTolerance', 1.0000e-10);
    Wxi = quadprog(H,[],A,b,[],[],[],[],[],options);
    W(:,t) = Wxi(1:feat);
end
toc
end

