function [ Wb ] = solve_ll_class_hinge_qpas( X, Y, lambda )
%SOLVE_LL_CLASS_HINGE_QPAS Solves the lower level problem of a bilevel
%SVM classification algorithm for a given parameter lambda
%   This is a subroutine to the bilevel bundle algorithm.
%   The algorithm solves the lover level classification problem given as a
%   constraint in a bilevel SVM classification algorithm for a given
%   parameter lambda. The algorithm is in the lines of the one presented in
%   "Model selection for primal SVM" by Gregory Moore, Charles Bergeron and
%   Kristin P. Bennett but it is rewritten for an SVM classification
%   problem. 
%   The objective function of the lower level problem is the one used in "A
%   Bilevel Optimization Approach to Machine Learning" by Gautam Kunapuli.
%   The algorithm uses the qpas algorithm from the QPC project maintained
%   by Dr. Adrian Wills.
%   This algorithm only works with dense matrices.

% input arguments
% name      object  --> dimensions
% X:        array   --> features x size of training set x number of folds
% Y:        matrix  --> size of training set x number of folds
% lambda:   number  --> >0

% output arguments
% Wb:        matrix  --> features+1 x number of folds

fprintf('Solve the lower level classificaion problem for given hyperparameter. \n')
%tic

[feat,J,T] = size(X);
Wb = zeros(feat+1,T);
for t = 1:T
    % select the partition of the trainings set corresponding to the t'th
    % fold
    Xt = X;
    Yt = Y;
    if T > 1
        Xt(:,:,t) = [];
        Yt(:,t) = [];
        Xt = reshape(Xt,feat,J*(T-1));
        Yt = reshape(Yt,J*(T-1),1);
    end
    
    % prepare the matrices used in the qpas algorithm
    H = diag([lambda*ones(feat,1);0;zeros(J*max((T-1),1),1)]);
    h = [zeros(feat+1,1);ones(J*max((T-1),1),1)];
    XY = bsxfun(@times,Xt,Yt');
    A = [-XY' Yt -eye(J*max((T-1),1))];
    b = -ones(J*max((T-1),1),1);
    lb = [-Inf*ones(feat+1,1);zeros(J*max((T-1),1),1)];
    Wbxi = qpas(H,h,A,b,[],[],lb,[],0);
    Wb(:,t) = Wbxi(1:feat+1);
end
%toc
end

