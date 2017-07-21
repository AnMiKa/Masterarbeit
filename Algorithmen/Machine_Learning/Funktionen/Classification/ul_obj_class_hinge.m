function [ f ] = ul_obj_class_hinge( X, Y, W, b )
%UL_OBJ_CLASS_HINGE calculates the function value of the upper level
%objective function of a bilevel classification problem
%   Calculates the function value of the upper level objective function of
%   a bilevel classification problem.
%   The objective function is the hinge loss as presented in "A Bilevel
%   Optimozation Approach to Machine Learning" by Gautam Kunapuli.

% input arguments
% name      object  --> dimensions
% W         matrix  --> features x number of folds
% b:        vector  --> 1 x number of folds
% X:        array   --> features x size of training set x number of folds
% Y:        matrix  --> size of training set x number of folds

% output arguments
% f:        number  --> 1


fprintf('Evaluate the upper level objective for a given weight vector. \n')
[feat,J,T,G] = size(X);

X = reshape(X,feat,J*G,T);
Y = reshape(Y,J*G,T);
J = J*G;
f = 0;
for t =  1:T
    % select the partition of the validation set corresponding to the t'th
    % fold
    if T > 1
        Xt = X(:,:,t);
        Yt = Y(:,t);
    else
        Xt = X;
        Yt = Y;
    end
    % compute value for each fold
    f = f + 1/J*sum(max(ones(J,1)-Yt.*(Xt'*W(:,t)-b(t)),0));
end
% compute final function value
% scale objective function by 100
f = 100*1/T*f;
end

