function [] = boundary_folds_outr(W,X,Y)

% w = (w,b) (before: (-b,w))
% data: struct with X and Y
% dimensions of X, Y
% X: feat x number of instances
% Y: number of instances x 1
% linestyles for different boundaries
[~,folds] = size(W);

for f = 1:folds
    % data points
    Xf = X;
    Xf(:,:,f) = [];
    Yf = Y;
    Yf(:,f) = [];
    plotdata_outr(Xf,Yf);
    hold on;
    box on
    myax = axis; 
    axis manual;

    m = 50; % grid points for contour
    tx = myax(1) + (myax(2)-myax(1))*(0:m)'/m;

    %[n,d] = size(data.X);
    normw = 1/norm(W(1:end-1,f));

    %Plot optimal boundary
    ty = -W(3,f)/W(2,f) - tx*W(1,f)/W(2,f);
    plot(tx,ty,'k');
    % plot margin around it
    ty = (-W(3,f)+normw)/W(2,f) - tx*W(1,f)/W(2,f);
    plot(tx,ty,':k');
    ty = (-W(3,f)-normw)/W(2,f) - tx*W(1,f)/W(2,f);
    plot(tx,ty,':k');

    legend('Class 1','Class 2');
    title(['Separating line for fold ' num2str(f)],'Interpreter','latex')

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
end
end
