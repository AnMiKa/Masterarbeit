function [ DLlambda ] = subgr_ul_class_hingequad( W, b, X, Y, Dwb )
%SUBGR_UL_CLASS_HINGEQUAD calculates the subgradient of the upper level
%objective of a bilevel classification problem
%   Calculates the subgradient with respect to the parameter lambda of the
%   upper level objective function of a bilevel classification problem.
%   The objective function is the hinge loss function as described in "A
%   Bilevel Optimization Approach to Machine Learnig" by Gautam Kunapuli with squared second part.
%   The function is scaled by 100.

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
%tic
[~,J,T] = size(X);
DLlambda = zeros(1,T);
for t = 1:T
    % select the partition of the validation set corresponding to the t'th
    % fold
    if T > 1
        Xval = X(:,:,t);
        Yval = Y(:,t);
    else
        Xval = X;
        Yval = Y;
    end
    % compute the parts of the subgradient foldwise
    i =  ones(J,1)-Yval.*(Xval'*W(:,t)-b(t)) >= 0;
    tmp = [bsxfun(@times,Xval,(-i.*(ones(J,1)-Yval.*(Xval'*W(:,t)-b(t))).*Yval)'); (i.*(ones(J,1)-Yval.*(Xval'*W(:,t)-b(t))).*Yval)'];
    DLlambda(:,t) = 2/J*sum(tmp,2)'*Dwb(:,:,t)';
    % for gradient test:
    %DLlambda = 2/J*sum(tmp,2)'*Dwb(:,:,t)';
end
% compute the final subgradient
% scale by 100 like in the objective function
DLlambda = 100/T*sum(DLlambda,2); 
% for gradient test
%DLlambda = 100*(DLlambda)'; 
%toc
end