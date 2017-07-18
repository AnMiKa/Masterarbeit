% skript: find optimality intervall for lambda

% logarithmic scale for lambda
lambda = [logspace(-15,0,10),logspace(0,2,90)];
%lambda = linspace(0,100,500);

err = zeros(length(lambda),1);
norm_W = zeros(length(lambda),5);

for l = 1:length(lambda)
    [err(l),norm_W(l,:)] = class_error(lambda(l),Xbox5,Ybox5);
end

% plot lambda vs. error
figure
plot(lambda,err)
norm_W(1,:)