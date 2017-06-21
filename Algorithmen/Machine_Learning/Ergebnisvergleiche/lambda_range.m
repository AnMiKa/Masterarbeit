% skript: find optimality intervall for lambda

% logarithmic scale
%lambda = logspace(-15,5,100);
lambda = linspace(93,236,100);
% pima
errp = zeros(length(lambda),1);
for l = 1:length(lambda)
    errp(l) = final_class_error(lambda(l),Xvp,Yvp);
end