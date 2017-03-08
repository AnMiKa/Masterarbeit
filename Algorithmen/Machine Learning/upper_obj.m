function [ f ] = upper_obj( X, Y, W )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

fprintf('Evaluate the upper level objective for a given weight vector. \n')
[~,J,T] = size(X);
f = 0;
for t =  1:T
    Xval = X(:,:,t);
    Yval = Y(:,t);
    f = f + 1/(2*J)*sum((Xval'*W(:,t)-Yval).^2,1);
end
f = 1/T*f;
end

