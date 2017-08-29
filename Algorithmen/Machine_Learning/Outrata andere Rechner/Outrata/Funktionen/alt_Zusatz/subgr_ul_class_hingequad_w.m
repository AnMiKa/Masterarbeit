function [ subgr_ul_w ] = subgr_ul_class_hingequad_w( X, Y, W )

[feat,J,T,G] = size(X);

subgr_ul_w = zeros(feat,T);

for t = 1:T
    if T == 1
        Xt = reshape(X,feat,J*G);
        Yt = reshape(Y,J*G,1);
    else
        Xt = reshape(X(:,:,t,:),feat,J*G);
        Yt = reshape(Y(:,t,:),J*G,1);
    end
    delta = (1-Yt.*(Xt'*W(:,t))) > 0;
    subgr_ul_w(:,t) = 2*sum(max(1-Yt.*(Xt'*W(:,t)),0).*(-(delta.*Yt).*Xt'),1);
end
subgr_ul_w = 1/T*sum(subgr_ul_w,2);
end

