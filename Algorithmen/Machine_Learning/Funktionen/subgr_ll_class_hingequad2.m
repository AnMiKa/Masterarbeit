function [ Dwb ] = subgr_ll_class_hingequad2( W, b, X, Y, lambda )
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
Dwb = zeros(1,feat+1,T);
for t = 1:T
    % select the partition of the trainings set corresponding to the t'th
    % fold
    Xt = X;
    Yt = Y;
    if T > 1
        Xt(:,:,t,:) = [];
        Yt(:,t,:) = [];
        Xt = reshape(Xt,feat,J*(T-1),G);
        Yt = reshape(Yt,J*(T-1),G);
    end
    % select the corresponding weight vector and bias
    Wt = W(:,t);
    bt = b(t);
    
    % prepare the linear system derived from the optimality conditions to
    % calculate the subgradient
    delta = zeros(J*(T-1),G);
    XXY = zeros(feat,feat,G);
    Hwb = zeros(feat,J*(T-1),G);
    Hb = zeros(J*(T-1),G);
    
    for g = 1:G
        delta(:,g) = sign(max(ones(J*max((T-1),1),1)-Yt(:,g).*(Xt(:,g)'*Wt-bt),0));
        i = delta(:,g) == 0;
        delta(i,g)=1;
        
        for j = 1:J*max((T-1),1)
            XXY(:,:,g) = XXY(:,:,g)+delta(j,g)*(Yt(j,g)*Xt(:,j,g))*(Yt(j,g)*Xt(:,j,g))';
        end
        Hwb(:,:,g) = bsxfun(@times,Xt(:,:,g),(delta(:,g).*Yt(:,g).^2)');
        Hb(:,g) = delta(:,g).*Yt(:,g).^2;
    end
    
    XXY = sum(XXY,3);
    Hwb = sum(Hwb,3);
    Hb = sum(Hb,2);
    
    Hw = sum(lambda)*eye(feat)+2*XXY;
    Hwb = -2*sum(Hwb,2);
    Hb = 2*sum(Hb);
    H = [[Hw,Hwb];[Hwb',Hb]];
    h = [-Wt;0];
    % calculation of the subgradient of the t'th fold
    Dwb(:,:,t) = H\h;
end
%toc
end

