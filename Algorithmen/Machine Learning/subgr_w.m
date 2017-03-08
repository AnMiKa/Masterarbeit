function [ D ] = subgr_w( W, X, Y, gamma )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

fprintf('Find a subgradient of the lower level problem. \n')
tic
[feat,J,T] = size(X);
C = gamma(1);
eps = gamma(2);
D = zeros(length(gamma),feat,T);
for t = 1:T
    Xt = X;
    Yt = Y;
    Xt(:,:,t) = [];
    Yt(:,t) = [];
    Xt = reshape(Xt,feat,J*(T-1));
    Yt = reshape(Yt,J*(T-1),1);
    Wt = W(:,t);
    deltap = max(sign(Xt'*Wt-Yt-eps),0); % choose deltap = 0 if sign()= 0
    deltam = max(sign(-Xt'*Wt+Yt-eps),0); % choose deltam = 0 if sign() = 0
    XX = zeros(feat);
    for j = 1:J*(T-1)
        XX = XX+(deltap(j)+deltam(j))*(Xt(:,j)*Xt(:,j)');
    end
    H = [eye(feat)+C*XX, zeros(feat); zeros(feat), eye(feat)+C*XX]; % 2*feat x 2*feat
    h = [-sum(bsxfun(@times,(max(Xt'*Wt-Yt-eps,0)-max(-Xt'*Wt+Yt-eps,0))',Xt),2);...
        C*(sum(bsxfun(@plus,deltap',Xt),2)+sum(bsxfun(@plus,deltam',Xt),2))]; % 2*feat
    res = H\h;
    D(:,:,t) = [res(1:feat)';res(feat+1:end)'];
end
toc
end

