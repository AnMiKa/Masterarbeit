function [ f ] = ul_obj_reg_moore( X, Y, W )
%UL_OBJ_REG_MOORE calculates the function value of the upper level
%objective function of a bilevel regression problem
%   Calculates the function value of the upper level objective function of
%   the bilevel regression problem given in the paper "Model selection for
%   primal SVM" by Gregory Moore, Charles Bergeron and Kristin P. Bennett.

% input arguments
% name      object  --> dimensions
% W         matrix  --> features x number of folds
% X:        array   --> features x size of training set x number of folds
% Y:        matrix  --> size of training set x number of folds

% output arguments
% f:        number  --> 1


fprintf('Evaluate the upper level objective for a given weight vector. \n')
[~,J,T] = size(X);
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
    f = f + 1/(2*J)*sum((Xt'*W(:,t)-Yt).^2,1);
end
% compute final function value
f = 1/T*f;
end

