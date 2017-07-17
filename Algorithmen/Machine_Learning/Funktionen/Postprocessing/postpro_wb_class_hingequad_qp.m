% Postprocessing
function [ Wb ] = postpro_wb_class_hingequad_qp( X, Y, lambda )
%POSTPRO_WB_CLASS_HINGEQUAD finds the weight vector and bias for a
%classification problem for a given parameter lambda
%   Finds the weight vector and bias for a classification problem for a
%   given parameter lambda.
%   The objective function is the one used in "A Bilevel Optimization 
%   Approach to Machine Learning" by Gautam Kunapuli but the max-term is 
%   additionally squared.   
%   The occuring quadratic program is solved by MATLAB's quadprog solver

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
H = spdiags([lambda*ones(feat,1);0;2*ones(J,1)],0,feat+1+J,feat+1+J);
h = sparse(feat+1+J,1);
XY = bsxfun(@times,X,Y');
A = sparse([-XY' Y -speye(J)]);
b = -ones(J,1);
Wbxi = quadprog(H,h,A,b);
W = Wbxi(1:feat);
b = Wbxi(feat+1);
Wb = [W;b];
% nur for LTH-Test so
%Wb = [-b;W];
 
toc
end