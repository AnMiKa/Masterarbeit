function [] = boundary_outr(w,W,X,Y)

% w = (w,b) (before: (-b,w))
% data: struct with X and Y
% dimensions of X, Y
% X: feat x number of instances
% Y: number of instances x 1
% linestyles for different boundaries

% plot the data points
%figure
plotdata_outr(X,Y);
hold on;
box on
myax = axis; 
axis manual;

m = 50; % grid points for contour
tx = myax(1) + (myax(2)-myax(1))*(0:m)'/m;

%[n,d] = size(data.X);
[~, folds] = size(W);
normw = 1/norm(w(1:end-1));

%Plot optimal boundary
ty = -w(3)/w(2) - tx*w(1)/w(2);
plot(tx,ty,'k');
% plot margin around it
ty = (-w(3)+normw)/w(2) - tx*w(1)/w(2);
plot(tx,ty,':k');
ty = (-w(3)-normw)/w(2) - tx*w(1)/w(2);
plot(tx,ty,':k');

for d = 1:folds
    % plot other boundaries 
    ty = -W(3,d)/W(2,d) - tx*W(1,d)/W(2,d);
    plot(tx,ty,'--k');
end

legend('Class 1','Class 2');
title('Decision lines for the \texttt{synsmall} data set','Interpreter','latex')

pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];
hold off;
