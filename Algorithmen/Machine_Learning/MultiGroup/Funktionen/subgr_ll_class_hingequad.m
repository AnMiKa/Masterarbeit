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
%tic
[feat,J,T,G] = size(X);
Dwb = zeros(feat+1,G,T);
for t = 1:T
    % select the partition of the trainings set corresponding to the t'th
    % fold
    Xt = X;
    Yt = Y;
    if T > 1
        Xt(:,:,t,:) = [];
        Yt(:,t,:) = [];
        Xt = reshape(Xt,feat,J*(T-1)*G);
        Yt = reshape(Yt,J*(T-1)*G,1);
    else
        Xt = reshape(Xt,feat,J*G);
        Yt = reshape(Yt,J*G,1);
    end
    % select the corresponding weight vector and bias
    Wt = W(:,t);
    bt = b(t);
    
    % prepare the linear system derived from the optimality conditions to
    % calculate the subgradient
    delta = sign(max(ones(J*max((T-1),1)*G,1)-Yt.*(Xt'*Wt-bt),0));
    %delta = ones(J*max((T-1),1)*G,1);
    XXY = zeros(feat);
    for j = 1:J*max((T-1),1)*G
        XXY = XXY + delta(j)*(Yt(j)*Xt(:,j))*(Yt(j)*Xt(:,j))';
    end
    Hwb = -2*sum(bsxfun(@times,Xt,(delta.*Yt.^2)'),2);
    Hb = 2*sum(delta.*Yt.^2);
    h = [-Wt;0];

    for g = 1:G
        Hw = lambda(g)*eye(feat)+2*XXY;
        H = [[Hw,Hwb];[Hwb',Hb]];
        if min(abs(eig(H))) < 1e-10 
            pause
        end
        % calculation of the subgradient of the t'th fold
        Dwb(:,g,t) = H\h;
    end
end
%toc
end

