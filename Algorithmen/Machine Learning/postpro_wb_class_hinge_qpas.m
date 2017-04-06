% Postprocessing
function [ Wb ] = postpro_wb_class_hinge_qpas( X, Y, lambda )
%POSTPRO_WB_CLASS_HINGE finds the weight vector and bias for a
%classification problem for a given parameter lambda
%   Finds the weight vector and bias for a classification problem for a
%   given parameter lambda.
%   The objective function is the one used in "A Bilevel Optimization 
%   Approach to Machine Learning" by Gautam Kunapuli.   
%   The occuring quadratic program is solved by Dr. Adrian Wills' qpas
%   solver.

%input arguments
% X:        matrix --> features x number of instances
% Y:        vector --> number of instances
% lambda    number 

%output arguments
% Wb:       vector --> features+1

tic
% LTH
%X = X';
[feat,J] = size(X);
H = diag([lambda*ones(feat,1);0;zeros(J,1)]);
h = [zeros(feat+1,1); ones(J,1)];
XY = bsxfun(@times,X,Y');
A = [-XY' Y -eye(J); zeros(J,feat+1) -eye(J)];
b = [-ones(J,1) ; zeros(J,1)];
Wbxi = qpas(H,h,A,b,[],[],[],[],0);
W = Wbxi(1:feat);
b = Wbxi(feat+1);
Wb = [W;b];
% nur für LTH-Test so
%Wb = [-b;W];

toc
end

