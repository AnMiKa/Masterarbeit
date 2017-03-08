function [ d_gamma_upper ] = subgr_upper( W, X, Y, D )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

fprintf('Find a subgradient of the upper level problem. \n')
tic
[d,~,T] = size(D);
[~,J,~] = size(X);
d_gamma_upper = zeros(d,T);
for t = 1:T
    Xval = X(:,:,t);
    Yval = Y(:,t);
    % check if 1/J below correct
    d_gamma_upper(:,t) = 1/J*(sum(Xval*bsxfun(@minus,Xval'*W(:,t),Yval),2))'*D(:,:,t)';
end
d_gamma_upper = 1/T*sum(d_gamma_upper,2); % check if the 1/T here correct
toc
end

