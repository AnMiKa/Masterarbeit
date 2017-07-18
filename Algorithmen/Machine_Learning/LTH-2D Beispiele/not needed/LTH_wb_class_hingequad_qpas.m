% Postprocessing
function [ wb ] = LTH_wb_class_hingequad_qpas( data, lambda )
%POSTPRO_WB_CLASS_HINGEQUAD finds the weight vector and bias for a
%classification problem for a given parameter lambda
%   Finds the weight vector and bias for a classification problem for a
%   given parameter lambda.
%   The objective function is the one used in "A Bilevel Optimization 
%   Approach to Machine Learning" by Gautam Kunapuli but the max-term is 
%   additionally squared.   
%   The occuring quadratic program is solved by Dr. Adrian Wills' qpas
%   solver.

%input arguments
% X:        matrix --> features x number of instances
% Y:        vector --> number of instances
% lambda    number 

%output arguments
% Wb:       vector --> features+1

tic
X = data.X;
X = X';
Y = data.y;
[feat,J] = size(X);
H = diag([lambda*ones(feat,1);0;1*ones(J,1)]);
h = zeros(feat+1+J,1);
XY = bsxfun(@times,X,Y');
A = [-XY' Y -eye(J)];
b = -ones(J,1);
wbxi = qpas(H,h,A,b,[],[],[],[],0);
w = wbxi(1:feat);
b = wbxi(feat+1);
wb = [-b;w];
 
toc
end

