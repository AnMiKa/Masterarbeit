% skript: find optimality intervall for lambda by plotting the error

function [err, graderr, norm_W] = lambda_range_plot(X,Y,lambda)

% logarithmic scale for lambda
%lambda = [logspace(-15,0,10),logspace(0,2,90)];
%lambda = linspace(0,50,500);

[~,T] = size(Y);
len = length(lambda);

err = zeros(len,1);
graderr = zeros(floor(len/10),1);
norm_W = zeros(len,T+1);


llambda = zeros(floor(len/10),1);
for l = 1:length(lambda)
    [err(l),W,b,norm_W(l,:)] = class_error(lambda(l),X,Y);
    Dwb = subgr_ll_class_hingequad(W,b,X,Y,lambda(l));
    graderr(l) = subgr_ul_class_hinge(W,b,X,Y,Dwb);
end

%graderr_p = graderr.*llambda

% plot lambda vs. error
%figure
plot(lambda,err,'b')
plot(lambda,graderr,'m')
%norm_W(1,:)

end