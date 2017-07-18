% Postprocessing
function [ Wb ] = LTH_wb_class_hinge_qp( X, Y, lambda )
%POSTPRO_WB_CLASS_HINGE finds the weight vector and bias for a
%classification problem for a given parameter lambda
%   Finds the weight vector and bias for a classification problem for a
%   given parameter lambda.
%   The objective function is the one used in "A Bilevel Optimization 
%   Approach to Machine Learning" by Gautam Kunapuli.   

%input arguments
% X:        matrix --> features x number of instances
% Y:        vector --> number of instances
% lambda    number 

%output arguments
% Wb:       vector --> features+1

tic
X = X';
[feat,J] = size(X);
H = spdiags([lambda*ones(feat,1);sparse(J+1,1)],0,sparse(feat+1+J,feat+1+J));
h = sparse([sparse(feat+1,1); ones(J,1)]);
XY = bsxfun(@times,X,Y');
A = sparse([-XY' Y -speye(J); sparse(J,feat+1) -speye(J)]);
b = sparse([-ones(J,1) ; sparse(J,1)]);
options = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
   'MaxIterations', 500, 'ConstraintTolerance', 1.0000e-15, 'OptimalityTolerance', 1.0000e-15);
Wbxi = quadprog(H,h,A,b,[],[],[],[],[],options);
W = Wbxi(1:feat);
b = Wbxi(feat+1);
Wb = [-b;W];

toc
end

