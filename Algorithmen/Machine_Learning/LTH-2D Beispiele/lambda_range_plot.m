% skript: find optimality intervall for lambda by plotting the error

function [err, norm_W] = lambda_range_plot(X,Y,lambda)

% logarithmic scale for lambda
%lambda = [logspace(-15,0,10),logspace(0,2,90)];
%lambda = linspace(0,50,500);

[~,T] = size(Y);

err = zeros(length(lambda),1);
norm_W = zeros(length(lambda),T+1);

for l = 1:length(lambda)
    [err(l),norm_W(l,:)] = class_error(lambda(l),X,Y);
end

% plot lambda vs. error
figure
plot(lambda,err)
%norm_W(1,:)

end