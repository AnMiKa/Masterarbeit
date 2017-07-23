function [ err, W, b, norm_W ] = class_error(lambda,X,Y)


% calculate wb for all folds
Wb = solve_ll_class_hingequad_qp(X,Y,lambda);
W = Wb(1:end-1,:);
b = Wb(end,:);

[~,T] = size(Wb);
norm_W = zeros(1,T+1);

for t = 1:T
    norm_W(t) = norm(W(:,t));
end
norm_W(T+1) = 1/T*sum(norm_W(1:T));

% calculate average error over all folds
err = ul_obj_class_hinge(X,Y,W,b);

end