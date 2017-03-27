% Postproseccing
function [ err ] = postpro_err_misclass( w, b, X, Y )
%POSTPRO_ERR_MISCLASS calculates the error rate on the hold out set of a
%classification problem by counting the misclassified points
%   Calculates the error rate on the hold out set of a classification
%   problem  by counting the misclassified points for a given parameter
%   lambda, weights w and bias b from training the classifier.
%   The loss function is taken as presented in "A Bilevel Optimozation
%   Approach to Machine Learning" by Gautam Kunapuli.

% input arguments
% name      object  --> dimensions
% w         vector  --> features
% b:        number  --> 1
% X:        matrix  --> features x size of validation set
% Y:        vector  --> size of validation set

% output arguments
% err:      number  --> 1

 X = X'; % for LTH-test
[~,J] = size(X);
i = -Y.*(X'*w-b) > 0;
err = 1/J*sum(i);
end


