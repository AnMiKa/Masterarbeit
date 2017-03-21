function [ DLlambda ] = subgr_ul_class_hinge( W, b, X, Y, Dwb )
%SUBGR_UL_CLASS_HINGE calculates the subgradient of the upper level
%objective of a bilevel classification problem
%   Calculates the subgradient with respect to the parameter lambda of the
%   upper level objective function of a bilevel classification problem.
%   The objective function is the hinge loss function as described in "A
%   Bilevel Optimization Approach to Machine Learnig" by Gautam Kunapuli.

% input arguments
% name      object  --> dimensions
% W         matrix  --> features x number of folds
% b         vector  --> 1 x number of folds
% X:        array   --> features x size of training set x number of folds
% Y:        matrix  --> size of training set x number of folds
% Dwb:      array   --> 1 x features+1 x number of folds

% output arguments
% DLlambda: number  --> 1

fprintf('Find a subgradient of the upper level classification problem. \n')
tic
[~,J,T] = size(X);
DLlambda = zeros(1,T);
for t = 1:T
    % select the partition of the validation set corresponding to the t'th
    % fold
    Xval = X(:,:,t);
    Yval = Y(:,t);
    % compute the parts of the subgradient foldwise
    i = ones(J,1)-Yval.*(Xval'*W(:,t)-b(t)) >= 0;
    tmp = [bsxfun(@times,Xval,(-i.*Yval)'); (i.*Yval)'];
    DLlambda(:,t) = 1/J*(sum(tmp,2))'*Dwb(:,:,t)';
end
% compute the final subgradient
DLlambda = 1/T*sum(DLlambda,2); 
toc
end

