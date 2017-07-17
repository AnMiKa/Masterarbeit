% skript: find optimality intervall for lambda

% logarithmic scale
lambda = logspace(-15,2,100);
%lambda = linspace(93,236,100);

err = zeros(length(lambda),1);
for l = 1:length(lambda)
    err(l) = final_class_error(lambda(l),Xtwqr56,Ytwqr56',Xvwqr561,Yvwqr561);
end

figure
plot(lambda,err)