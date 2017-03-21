function [ Dwb ] = subgr_ll_class_hingequad( W, b, X, Y, lambda )
%SUBGR_LL_CLASS_HINGEQUAD calculates the subgradient of the implicit
%function coming from the lower level problem of a bilevel classification 
%problem.
%   Calculates the subgradient of the implicit function coming from the
%   lower level problem of a bilevel classification problem.
%   The calculations follow from the results presented in "Model selection
%   for primal SVM" by Gregory Moore, Charles Bergeron and Kristin P.
%   Bennett.
%   The objective function of the lower level problem is the one used in "A
%   Bilevel Optimization Approach to Machine Learning" by Gautam Kunapuli
%   but the max-term is additionally squared to make use of the theory
%   developed in the paper by Moore et al.

% input arguments
% name      object  --> dimensions
% W         matrix  --> features x number of folds
% b         vector  --> 1 x number of folds
% X:        array   --> features x size of training set x number of folds
% Y:        matrix  --> size of training set x number of folds
% lambda:   number  --> >0

% output arguments
% Dwb:      array   --> 1 x features+1 x number of folds

fprintf('Find a subgradient of the lower level classification problem. \n')
tic
[feat,J,T] = size(X);
Dwb = zeros(1,feat+1,T);
for t = 1:T
    % select the partition of the trainings set corresponding to the t'th
    % fold
    Xt = X;
    Yt = Y;
    Xt(:,:,t) = [];
    Yt(:,t) = [];
    Xt = reshape(Xt,feat,J*(T-1));
    Yt = reshape(Yt,J*(T-1),1);
    % select the corresponding weight vector and bias
    Wt = W(:,t);
    bt = b(t);
    
    % prepare the linear system derived from the optimality conditions to
    % calculate the subgradient
    delta = sign(max(ones(J*(T-1),1)-Yt.*(Xt'*Wt-bt),0)); 
    XY = zeros(feat);
    for j = 1:J*(T-1)
        XY = XY+delta(j)*(Yt(j)*Xt(:,j))*(Yt(j)*Xt(:,j))';
    end
    Hw = lambda(1)*eye(feat)+2*XY;
    Hwb = 2*sum(bsxfun(@times,Xt,(delta.*Yt.^2)'),2);
    Hb = 2*sum(delta.*Yt);
    hw = 2*sum(bsxfun(@times,Xt,(delta.*Yt)'),2);
    hb = Hb;
    H = [[Hw,Hwb];[Hwb',Hb]];
    h = [hw;hb];
    % calculation of the subgradient of the t'th fold
    Dwb(:,:,t) = H\h;
end
toc
end

