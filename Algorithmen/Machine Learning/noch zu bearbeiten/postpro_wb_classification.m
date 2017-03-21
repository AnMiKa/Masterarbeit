% Postprocessing
function [ Wb ] = postpro_wb_classification( X, Y, lambda )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

% X:        matrix --> features x number of instances
% Y:        vector --> number of instances
% lambda    number 

% W:    matrix --> features

tic
[feat,J] = size(X);
    
%  H = spdiags([lambda*ones(feat,1);0;ones(J*(T-1),1)],0,feat+1+J*(T-1),feat+1+J*(T-1));
%  XY = sparse(bsxfun(@times,Xt,Yt'));
%  A = [XY' sparse(Yt) spdiags(ones(J*(T-1),1),0,J*(T-1),J*(T-1))];
%  b = -ones(J*(T-1),1);
%  options = optimoptions(@quadprog, 'Algorithm', 'interior-point-convex',...
%  'MaxIterations', 100, 'ConstraintTolerance', 1.0000e-10, 'OptimalityTolerance', 1.0000e-10);
%  Wbxi = quadprog(H,[],A,b,[],[],[],[],[],options);
%  Wb(:,t) = Wbxi(1:feat+1);

H = diag([lambda*ones(feat,1);0;ones(J,1)]);
h = zeros(feat+1+J,1);
XY = bsxfun(@times,X,Y');
A = [XY' Y eye(J)];
b = -ones(J,1);
Wbxi = qpas(H,h,A,b,[],[],[],[],0);
Wb = Wbxi(1:feat+1);
 
toc
end

