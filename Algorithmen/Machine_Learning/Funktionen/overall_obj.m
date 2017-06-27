function [ f ] = overall_obj( lambda )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

%[X,Y] = precond_data('heart_standard_pm1.mat',1,1,1);

load('Data/ready_to_use/Training Data/Adult.mat')

X = Xtadult1;
Y = Ytadult1;

[feat,J,T] = size(X);
Wb = zeros(feat+1,T);
W = zeros(feat,T);
b = zeros(T,1);
for t = 1:T
    % select the partition of the trainings set corresponding to the t'th
    % fold
    Xt = X;
    Yt = Y;
    if T > 1
        Xt(:,:,t) = [];
        Yt(:,t) = [];
        Xt = reshape(Xt,feat,J*(T-1));
        Yt = reshape(Yt,J*(T-1),1);
    end
    Wb(:,t) = solve_ll_class_hingequad_qp(Xt,Yt,lambda);
    W(:,t) = Wb(1:end-1,t);
    b(t) = Wb(end,t);
end
    
f = ul_obj_class_hinge( X, Y, W, b );

end

