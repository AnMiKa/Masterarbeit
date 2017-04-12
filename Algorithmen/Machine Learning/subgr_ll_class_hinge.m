function [ Dwb ] = subgr_ll_class_hinge( W, lambda )
%SUBGR_LL_CLASS_HINGE calculates the subgradient of the implicit
%function coming from the lower level problem of a bilevel classification 
%problem.
%   Calculates the subgradient of the implicit function coming from the
%   lower level problem of a bilevel classification problem.
%   The calculations follow from the results presented in "Model selection
%   for primal SVM" by Gregory Moore, Charles Bergeron and Kristin P.
%   Bennett.
%   The objective function of the lower level problem is the one used in "A
%   Bilevel Optimization Approach to Machine Learning" by Gautam Kunapuli
%   but the max-term is additionally squared to make use of the theory
%   developed in the paper by Moore et al.

% input arguments
% name      object  --> dimensions
% W         matrix  --> features x number of folds
% b         vector  --> 1 x number of folds
% X:        array   --> features x size of training set x number of folds
% Y:        matrix  --> size of training set x number of folds
% lambda:   number  --> >0

% output arguments
% Dwb:      array   --> 1 x features+1 x number of folds

fprintf('Find a subgradient of the lower level classification problem. \n')
%tic
[feat,T] = size(W);
Dwb = zeros(1,feat+1,T);
for t = 1:T
    % select the corresponding weight vector
    Wt = W(:,t);
    % calculation of the subgradient of the t'th fold
    Dwb(:,:,t) = [-Wt./lambda;0];
end
%toc
end

