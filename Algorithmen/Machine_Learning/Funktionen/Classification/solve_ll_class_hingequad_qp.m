function [ Wb ] = solve_ll_class_hingequad_qp( X, Y, lambda )
%SOLVE_LL_CLASS_HINGEQUAD_QP solves the lower level problem of a bilevel
%SVM classification algorithm for a given parameter lambda
%   This is a subroutine to the bilevel bundle algorithm.
%   The algorithm solves the lover level classification problem given as a
%   constraint in a bilevel SVM classification algorithm for a given
%   parameter lambda. The algorithm is in the lines of the one presented in
%   "Model selection for primal SVM" by Gregory Moore, Charles Bergeron and
%   Kristin P. Bennett but it is rewritten for an SVM classification
%   problem. 
%   The objective function of the lower level problem is the one used in "A
%   Bilevel Optimization Approach to Machine Learning" by Gautam Kunapuli
%   but the max-term is additionally squared to make use of the theory
%   developed in the paper by Moore et al.
%   The algorithm uses MATLAB's quadprog algorithm with a sparse matrix
%   formulation.

% input arguments
% name      object  --> dimensions
% X:        array   --> features x size of training set x number of folds
% Y:        matrix  --> size of training set x number of folds
% lambda:   number  --> >0

% output arguments
% Wb:        matrix  --> features+1 x number of folds

fprintf('Solve the lower level classificaion problem for given hyperparameter. \n')
%tic

[feat,J,T,G] = size(X);

Wb = zeros(feat+1,T);

for t = 1:T
    % select the partition of the trainings set corresponding to the t'th
    % fold
    Xt = X;
    Yt = Y;
    if T > 1
        Xt(:,:,t,:) = [];
        Yt(:,t,:) = [];
    end
    Xt = reshape(Xt,feat,J*max((T-1),1),G);
    Yt = reshape(Yt,J*max((T-1),1),G,1);

    % prepare the matrices used in the quadprog algorithm
    H = sparse(feat+1+J*max((T-1),1),feat+1+J*max((T-1),1));
    XY = sparse(feat,J*max((T-1),1));
    for g = 1:G
        H = H + spdiags([lambda(g)*ones(feat,1);0;ones(J*max((T-1),1),1)],0,feat+1+J*max((T-1),1),feat+1+J*max((T-1),1));
        XY = XY + sparse(bsxfun(@times,Xt(:,:,g),Yt(:,g)'));
    end
%     if lambda < 0
%         pause
%     end

    A = [-XY' sparse(sum(Yt,2)) -spdiags(G*ones(J*max((T-1),1),1),0,J*max((T-1),1),J*max((T-1),1))];
    b = -G*ones(J*max((T-1),1),1);
    options = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
    'MaxIterations', 5000, 'ConstraintTolerance', 1.0000e-15, 'OptimalityTolerance', 1.0000e-15);
    Wbxi = quadprog(H,[],A,b,[],[],[],[],[],options);
    Wb(:,t) = Wbxi(1:feat+1);
end
%toc
end

