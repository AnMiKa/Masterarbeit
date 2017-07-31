% skript: find optimality point for lambda by plotting the error
% in 2D

function [err] = lambda_surf_plot(X,Y,lambda)

% lambda: upper bound for lambda

% make mehgrid from this
lx = linspace(1e-15,lambda,50);
ly = lx;

len = length(lx);

[xx,yy] = meshgrid(lx,ly);

err = zeros(len);

for i = 1:len
    for j = 1:len
        err(i,j) = class_error([xx(i),yy(j)],X,Y);
    end
end


% plot lambda vs. error
figure
surf(xx,yy,err)
figure
plot(lx,err(25,:))
end