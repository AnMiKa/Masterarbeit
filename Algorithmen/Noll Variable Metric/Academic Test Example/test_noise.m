x0 = [-4;0.5];
 
% %% Parabola
% fp_h = zeros(20,5);
% fp_n1 = zeros(20,5);
% fp_n4 = zeros(20,5);
% 
% tp_h = zeros(20,5);
% tp_n1 = zeros(20,5);
% tp_n4 = zeros(20,5); 
% 
% kp_h = zeros(20,5);
% kp_n1 = zeros(20,5);
% kp_n4 = zeros(20,5); 
% 
% for times = 1:20
%     for noise = 0:4
%         [fp_h(times,noise+1),~,tp_h(times,noise+1),kp_h(times,noise+1)] = bundle_nonconv_inex(x0,@parab,@grad_parab,noise); 
%         [fp_n1(times,noise+1),~,tp_n1(times,noise+1),kp_n1(times,noise+1)] = noll_variable_metric_nonconv_inex(x0,@parab,@grad_parab,1,noise);
%         [fp_n4(times,noise+1),~,tp_n4(times,noise+1),kp_n4(times,noise+1)] = noll_variable_metric_nonconv_inex(x0,@parab,@grad_parab,4,noise);
%     end
% end
% 
% fp_h = sum(fp_h,1)/20;
% fp_n1 = sum(fp_n1,1)/20;
% fp_n4 = sum(fp_n4,1)/20;
% 
% tp_h = sum(tp_h,1)/20;
% tp_n1 = sum(tp_n1,1)/20;
% tp_n4 = sum(tp_n4,1)/20;
% 
% kp_h = ceil(sum(kp_h,1)/20);
% kp_n1 = ceil(sum(kp_n1,1)/20);
% kp_n4 = ceil(sum(kp_n4,1)/20);


%% Nonsmooth Parabola
fnp_h = zeros(20,5);
fnp_n1 = zeros(20,5);
fnp_n4 = zeros(20,5);

tnp_h = zeros(20,5);
tnp_n1 = zeros(20,5);
tnp_n4 = zeros(20,5); 

knp_h = zeros(20,5);
knp_n1 = zeros(20,5);
knp_n4 = zeros(20,5); 

for times = 1:20
    for noise = 0:4
        [fnp_h(times,noise+1),~,tnp_h(times,noise+1),knp_h(times,noise+1)] = bundle_nonconv_inex(x0,@nonsm_parab,@subgr_nonsm_parab,noise); 
        [fnp_n1(times,noise+1),~,tnp_n1(times,noise+1),knp_n1(times,noise+1)] = noll_variable_metric_nonconv_inex(x0,@nonsm_parab,@subgr_nonsm_parab,1,noise);
        [fnp_n4(times,noise+1),~,tnp_n4(times,noise+1),knp_n4(times,noise+1)] = noll_variable_metric_nonconv_inex(x0,@nonsm_parab,@subgr_nonsm_parab,4,noise);
    end
end

fnp_h = sum(fnp_h,1)/20;
fnp_n1 = sum(fnp_n1,1)/20;
fnp_n4 = sum(fnp_n4,1)/20;

tnp_h = sum(tnp_h,1)/20;
tnp_n1 = sum(tnp_n1,1)/20;
tnp_n4 = sum(tnp_n4,1)/20;

knp_h = ceil(sum(knp_h,1)/20);
knp_n1 = ceil(sum(knp_n1,1)/20);
knp_n4 = ceil(sum(knp_n4,1)/20);

%% plot results
% %% Parabola
% % number of steps
% figure('position',[0 0 400 320])
% hold on
% box on
% 
% b1 = bar(1:5,[kp_h' kp_n1' kp_n4'],1);
% b1(1).FaceColor = 'c';
% b1(2).FaceColor = 'b';
% b1(3).FaceColor = 'm';
% %colormap cool
% 
% % Add a legend
% legend('Bundle Nonconv Inex', 'Variable Metric BFGS', 'Variable Metric BFGS Adaptive')
% title('$p(x) = x_1^2+50x_2^2$','Interpreter','latex')
% xlabel('noise forms','Interpreter','latex')
% ylabel('number of steps','Interpreter','latex')
% axis([0.5, 5.5, 0, 65])
% yticks(0:20:60)
% yticklabels(0:20:60)
% xticks(1:5)
% xticklabels({'N_0','N^{f,g}_c','N^{f,g}_v','N^{g}_c','N^{g}_v'})
% % minimal whitespace
% set(gca,'ygrid','on')
% pbaspect([1 2/3 1])
% ax = gca;
% outerpos = ax.OuterPosition;
% ti = ax.TightInset; 
% left = outerpos(1) + ti(1);
% bottom = outerpos(2) + ti(2);
% ax_width = outerpos(3) - ti(1) - ti(3);
% ax_height = outerpos(4) - ti(2) - ti(4);
% ax.Position = [left bottom ax_width ax_height];
% 
% % accuracy
% figure('position',[0 0 400 320])
% hold on
% box on
% 
% b1 = bar(1:5,[abs(log10(fp_h')) abs(log10(fp_n1')) abs(log10(fp_n4'))],1);
% b1(1).FaceColor = 'c';
% b1(2).FaceColor = 'b';
% b1(3).FaceColor = 'm';
% 
% % Add a legend
% legend('Bundle Nonconv Inex', 'Variable Metric BFGS', 'Variable Metric BFGS Adaptive')
% title('$p(x) = x_1^2+50x_2^2$','Interpreter','latex')
% xlabel('noise forms','Interpreter','latex')
% ylabel('log distance to 0','Interpreter','latex')
% axis([0.5, 5.5, 0, 14])
% yticks(0:2:14)
% yticklabels(0:2:14)
% xticks(1:5)
% xticklabels({'N_0','N^{f,g}_c','N^{f,g}_v','N^{g}_c','N^{g}_v'})
% % minimal whitespace
% set(gca,'ygrid','on')
% pbaspect([1 2/3 1])
% ax = gca;
% outerpos = ax.OuterPosition;
% ti = ax.TightInset; 
% left = outerpos(1) + ti(1);
% bottom = outerpos(2) + ti(2);
% ax_width = outerpos(3) - ti(1) - ti(3);
% ax_height = outerpos(4) - ti(2) - ti(4);
% ax.Position = [left bottom ax_width ax_height];

%% Nonsmooth Parabola
% number of steps
figure('position',[0 0 400 320])
hold on
box on

b1 = bar(1:5,[knp_h' knp_n1' knp_n4'],1);
b1(1).FaceColor = 'c';
b1(2).FaceColor = 'b';
b1(3).FaceColor = 'm';
%colormap cool

% Add a legend
legend('Bundle Nonconv Inex', 'Variable Metric BFGS', 'Variable Metric BFGS Adaptive')
title('$p_n(x) = 0.5x_1^2+0.5|x_1|+25x_2^2+25|x_2|$','Interpreter','latex')
xlabel('noise forms','Interpreter','latex')
ylabel('number of steps','Interpreter','latex')
axis([0.5, 5.5, 0, 65])
yticks(0:20:60)
yticklabels(0:20:60)
xticks(1:5)
xticklabels({'N_0','N^{f,g}_c','N^{f,g}_v','N^{g}_c','N^{g}_v'})
% minimal whitespace
set(gca,'ygrid','on')
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

% accuracy
figure('position',[0 0 400 320])
hold on
box on

b1 = bar(1:5,[abs(log10(fnp_h')) abs(log10(fnp_n1')) abs(log10(fnp_n4'))],1);
b1(1).FaceColor = 'c';
b1(2).FaceColor = 'b';
b1(3).FaceColor = 'm';

% Add a legend
legend('Bundle Nonconv Inex', 'Variable Metric BFGS', 'Variable Metric BFGS Adaptive')
title('$p_n(x) = 0.5x_1^2+0.5|x_1|+25x_2^2+25|x_2|$','Interpreter','latex')
xlabel('noise forms','Interpreter','latex')
ylabel('log distance to 0','Interpreter','latex')
axis([0.5, 5.5, 0, 14])
yticks(0:2:14)
yticklabels(0:2:14)
xticks(1:5)
xticklabels({'N_0','N^{f,g}_c','N^{f,g}_v','N^{g}_c','N^{g}_v'})
% minimal whitespace
set(gca,'ygrid','on')
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];
