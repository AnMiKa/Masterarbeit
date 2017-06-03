% Postproseccing
function [ err ] = postpro_err_test( w, b, X, Y )
%POSTPRO_ERR_TEST calculates the error rate on the hold out set of a
%classification problem
%   Calculates the error rate on the hold out set of a classification
%   problem given the parameter lambda and the weights w and bias b from 
%   training the classifier.
%   The loss function is the one taken for the test error in "A Bilevel
%   Optimization Approach to Machine Learning" by Gautam Kunapuli.

% input arguments
% name      object  --> dimensions
% w         vector  --> features
% b:        number  --> 1
% X:        matrix  --> features x size of validation set
% Y:        vector  --> size of validation set

% output arguments
% err:      number  --> 1


[~,J] = size(X);
err = 1/(2*J)*sum(abs(sign(X'*w-b)-Y));
end


