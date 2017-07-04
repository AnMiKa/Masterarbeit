function [ DLgamma ] = subgr_ul_reg_moore( W, X, Y, Dw )
%SUBGR_UL_REG_MOORE calculates the subgradient of the upper level objective
%of a bilevel regression problem
%   Calculates the subgradient with respect to the parameters C and epsilon
%   of the upper level objective function of the bilevel regression problem
%   described in "Model selection for primal SVM" by Gregory Moore, Charles
%   Bergeron and Kristin P. Bennett.

% input arguments
% name      object  --> dimensions
% W         matrix  --> features x number of folds
% X:        array   --> features x size of training set x number of folds
% Y:        matrix  --> size of training set x number of folds
% Dw:       array   --> 2 x features x number of folds

% output arguments
% DLgamma:  vector  --> 2

fprintf('Find a subgradient of the upper level regression problem. \n')
tic
[d,~,T] = size(Dw);
[~,J,~] = size(X);
DLgamma = zeros(d,T);
for t = 1:T
    % select the partition of the validation set corresponding to the t'th
    % fold
    Xval = X(:,:,t);
    Yval = Y(:,t);
    % compute the parts of the subgradient foldwise
    DLgamma(:,t) = 1/J*(sum(Xval*bsxfun(@minus,Xval'*W(:,t),Yval),2))'*Dw(:,:,t)';
end
% calculate the final subgradient
DLgamma = 1/T*sum(DLgamma,2);
toc
end

