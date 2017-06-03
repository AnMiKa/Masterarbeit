function [ Dw ] = subgr_ll_reg_moore( W, X, Y, gamma )
%SUBGR_LL_REG_MOORE calculates the subgradient of the implicit function
%coming from the lower level problem of a bilevel regression problem.
%   Calculates the subgradient of the implicit function coming from the
%   lower level problem of a bilevel regression problem.
%   The calculations follow from the results presented in "Model selection
%   for primal SVM" by Gregory Moore, Charles Bergeron and Kristin P.
%   Bennett.
%   The objective function of the lower level problem is the one used in
%   the given paper.

% input arguments
% name      object  --> dimensions
% W         matrix  --> features x number of folds
% X:        array   --> features x size of training set x number of folds
% Y:        matrix  --> size of training set x number of folds
% gamma:    vector  --> 2; [C; eps]

% output arguments
% Dwb:      array   --> 1 x features x number of folds

fprintf('Find a subgradient of the lower level problem. \n')
tic
[feat,J,T] = size(X);
C = gamma(1);
eps = gamma(2);
Dw = zeros(2,feat,T);
for t = 1:T
    % select the partition of the trainings set corresponding to the t'th
    % fold
    Xt = X;
    Yt = Y;
    Xt(:,:,t) = [];
    Yt(:,t) = [];
    Xt = reshape(Xt,feat,J*(T-1));
    Yt = reshape(Yt,J*(T-1),1);
    % select the corresponding weight vector
    Wt = W(:,t);
    % for regression problem in Moore
    
    % prepare the linear system derived from the optimality conditions to
    % calculate the subgradient
    deltap = max(sign(Xt'*Wt-Yt-eps),0); % choose deltap = 0 if sign()= 0
    deltam = max(sign(-Xt'*Wt+Yt-eps),0); % choose deltam = 0 if sign() = 0
    XX = zeros(feat);
    for j = 1:J*(T-1)
        XX = XX+(deltap(j)+deltam(j))*(Xt(:,j)*Xt(:,j)');
    end
    H = [eye(feat)+C*XX, zeros(feat); zeros(feat), eye(feat)+C*XX]; % 2*feat x 2*feat
    h = [-sum(bsxfun(@times,(max(Xt'*Wt-Yt-eps,0)-max(-Xt'*Wt+Yt-eps,0))',Xt),2);...
        C*(sum(bsxfun(@plus,deltap',Xt),2)+sum(bsxfun(@plus,deltam',Xt),2))]; % 2*feat
    % calculation of the subgradient of the t'th fold
    res = H\h;
    % assembly to some kind of Jacobian matrix
    Dw(:,:,t) = [res(1:feat)';res(feat+1:end)'];
end
toc
end

