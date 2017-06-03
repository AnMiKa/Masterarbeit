function [ dfdwb ] = subgr_ul_class_hinge_wb( X, Y, W, b )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[feat,J,T] = size(X);

dfdw = zeros(feat,1);
dfdb = 0;
for t = 1:T
    if T > 1
        Xt = Xt(:,:,t);
        Yt = Yt(:,t);
    else
        Xt = X;
        Yt = Y;
    end
    delta = 1-Yt.*(Xt'*W(:,t)-b(t)) > 0;
    dfdw = dfdw+1/J*sum(bsxfun(@times,(-delta.*Yt)',Xt),2);
    dfdb = dfdb+1/J*sum(delta.*Yt);
end

dfdwb = 100/T*[dfdw;dfdb];
end

