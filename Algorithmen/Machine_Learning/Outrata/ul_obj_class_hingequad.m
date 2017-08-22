function [ f ] = ul_obj_class_hingequad( X, Y, W )
%UL_OBJ_CLASS_HINGEQUAD calculates the function value of the upper level
%objective function of a bilevel classification problem
%   Calculates the function value of the upper level objective function of
%   a bilevel classification problem.
%   The objective function is the hinge loss as presented in "A Bilevel
%   Optimozation Approach to Machine Learning" by Gautam Kunapuli with the 
%   last part squared.

% input arguments
% name      object  --> dimensions
% W=(w,b):  matrix  --> features+1 x number of folds
% X:        array   --> features+1 x size of training set x number of folds x groups
% Y:        matrix  --> size of training set x number of folds x groups

% output arguments
% f:        number  --> 1


%fprintf('Evaluate the upper level objective for a given weight vector. \n')
[feat,J,T,G] = size(X);
f = zeros(1,T);
for t =  1:T
    % select the partition of the validation set corresponding to the t'th
    % fold
    if T > 1
        Xt = reshape(X(:,:,t,:),feat,J*G);
        Yt = reshape(Y(:,t,:),J*G,1);
    else
        Xt = reshape(X,feat,J*G);
        Yt = reshape(Y,J*G,1);
    end
    % compute value for each fold and ass them
    f(:,t) = 1/(J*G)*sum(max(1-Yt.*(Xt'*W(:,t)),0).^2);
end
% compute final function value
% scale objective function by 100
f = 100*1/T*sum(f,2);
end

