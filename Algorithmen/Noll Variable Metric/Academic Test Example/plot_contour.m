%% Plotting Script

%% Example: Parabola
[fp_n,~,~,~,x_hats_p] = noll_variable_metric_nonconv_inex([-4;0.5],@parab,@grad_parab,1);
[fp_h,~,~,~,x_Hats_p] = bundle_nonconv_inex([-4;0.5],@parab,@grad_parab);

% plot contour plot of the function
% set the contour lines
V = logspace(-3,2,25);

% do contour plot
x = -4.5:0.01:1;
y = -1:0.01:1;
[X,Y] = meshgrid(x,y);
Z = zeros(length(y),length(x));
for i = 1:length(x)
    for j = 1: length(y)
        Z(j,i) = parab([x(i);y(j)],0);
    end
end

figure('position',[0 0 400 300])
hold on
% plot the level lines of the parabola
contour(X,Y,Z,V);
colormap('cool')
% plot the iteration points and lines between them
s1 = plot(x_hats_p(1,:),x_hats_p(2,:),'b-p', 'MarkerFaceColor','b');
s2 = plot(x_Hats_p(1,:),x_Hats_p(2,:),'m-*');

box on
pbaspect([1 2/3 1])
legend([s1,s2],{'Variable Metric BFGS','Bundle Nonconv Inex'})
title('$p(x) = x_1^2+50x_2^2$','Interpreter','latex')
xlabel('$x_1$','Interpreter','latex')
ylabel('$x_2$','Interpreter','latex')
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

%% Example: Nonsmooth Parabola
[fnp_n,~,~,~,x_hats_np] = noll_variable_metric_nonconv_inex([-4;0.5],@nonsm_parab,@subgr_nonsm_parab,1);
%[fnp4_n,~,~,x_hats_np4] = noll_variable_metric_nonconv_inex([-4;0.5],@nonsm_parab,@subgr_nonsm_parab,4);
[fnp_h,~,~,~,x_Hats_np] = bundle_nonconv_inex([-4;0.5],@parab,@grad_parab);

% plot contour plot of the function
% set the contour lines
V = logspace(-3,2,25);

% do contour plot
x = -4.5:0.01:1;
y = -1:0.01:1;
[X,Y] = meshgrid(x,y);
Z = zeros(length(y),length(x));
for i = 1:length(x)
    for j = 1: length(y)
        Z(j,i) = nonsm_parab([x(i);y(j)],0);
    end
end

figure('position',[0 0 400 300])
hold on
% plot the level lines of the parabola
l = contour(X,Y,Z,V);
colormap('cool')
% plot the iteration points and lines between them
s1 = plot(x_hats_np(1,:),x_hats_np(2,:),'b-p', 'MarkerFaceColor','b');
%s2 = plot(x_hats_np4(1,:),x_hats_np4(2,:),'k-+');
s3 = plot(x_Hats_np(1,:),x_Hats_np(2,:),'m-*');

box on
pbaspect([1 2/3 1])
legend([s1,s2,s3],{'Variable Metric BFGS','Bundle Nonconv Inex'})
title('$p_n(x) = 0.5x_1^2+0.5|x_1|+25x_2^2+25|x_2|$','Interpreter','latex')
xlabel('$x_1$','Interpreter','latex')
ylabel('$x_2$','Interpreter','latex')
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

