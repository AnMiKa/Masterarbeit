% Postproseccing
function [ err ] = postpro_err_hingequad( w, b, X, Y )
%POSTPRO_ERR_HINGEQUAD calculates the error rate on the hold out set of a
%classification problem for thequadratic hinge loss
%   Calculates the error rate on the hold out set of a classification
%   problem  for the squared hinge loss given the parameter lambda and the weights
%   w and bias b from training the classifier.

% input arguments
% name      object  --> dimensions
% w         vector  --> features
% b:        number  --> 1
% X:        matrix  --> features x size of validation set
% Y:        vector  --> size of validation set

% output arguments
% err:      number  --> 1

% LTH
%X = X';
[~,J] = size(X);
i = max(ones(J,1)-Y.*(X'*w-b),0).^2;
err = 1/J*sum(i);
end
