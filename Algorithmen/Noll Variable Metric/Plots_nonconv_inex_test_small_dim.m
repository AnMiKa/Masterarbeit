%plots the 5 test functions for different x-dimensions and forms of noise
%large dimension
%% no noise
% %Create a stem plot using the stem function
% figure('position',[10 10 400 320])
% hold on
% box on
% x = 1:14;
% for i = 1:5
%     stem(x+(i-1)*.15,log_f_h0(1:14,i), '*:m')
%     stem(x+(i-1)*.15,log_f_n10(1:14,i), 'p:b','filled','LineWidth',1)
%     stem(x+(i-1)*.15,log_f_n40(1:14,i), 'p:c','filled','LineWidth',0.6)
% end
% %Add a legend
% legend('Bundle Nonconv Inex', 'Variable Metric BFGS', ...
%     'Variable Metric BFGS Adaptive')
% title('no noise','Interpreter','latex')
% xlabel('$n$','Interpreter','latex')
% ylabel('abs log distance from 0','Interpreter','latex')
% axis([0.85, 15, 0, 12.5])
% xticks(1:14)
% xticklabels(2:15)
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
% %Create a stem plot using the stem function
% figure('position',[10 10 400 320])
% hold on
% box on
% x = 1:14;
% for i = 1:5
%     stem(x+(i-1)*.15,k_h0(1:14,i), '*:m')
%     stem(x+(i-1)*.15,k_n10(1:14,i), 'p:b','filled','LineWidth',1)
%     stem(x+(i-1)*.15,k_n40(1:14,i), 'p:c')
% end
% legend('Bundle Nonconv Inex', 'Variable Metric BFGS', ...
%     'Variable Metric BFGS Adaptive','Location','northwest')
% title('no noise','Interpreter','latex')
% xlabel('$n$','Interpreter','latex')
% ylabel('number of steps','Interpreter','latex')
% axis([0.85, 15, 0, 500])
% xticks(1:14)
% xticklabels(2:15)
% yticks(0:100:500)
% set(gca,'ygrid','on')
% pbaspect([1 2/3 1])
% 
% ax = gca;
% outerpos = ax.OuterPosition;
% ti = ax.TightInset; 
% left = outerpos(1) + ti(1);
% bottom = outerpos(2) + ti(2);
% ax_width = outerpos(3) - ti(1) - ti(3);
% ax_height = outerpos(4) - ti(2) - ti(4);
% ax.Position = [left bottom ax_width ax_height];
% 
% %% constant noise
% %Create a stem plot using the stem function
% figure('position',[10 10 400 320])
% hold on
% box on
% x = 1:14;
% for i = 1:5
%     stem(x+(i-1)*.15,log_f_h1(1:14,i), '*:m')
%     stem(x+(i-1)*.15,log_f_n11(1:14,i), 'p:b','filled','LineWidth',1)
%     stem(x+(i-1)*.15,log_f_n41(1:14,i), 'p:c')
% end
% %Add a legend
% legend('Bundle Nonconv Inex', 'Variable Metric BFGS', ...
%     'Variable Metric BFGS Adaptive')
% title('constant noise','Interpreter','latex')
% xlabel('$n$','Interpreter','latex')
% ylabel('abs log distance from 0','Interpreter','latex')
% axis([0.85, 15, 0, 12.5])
% xticks(1:14)
% xticklabels(2:15)
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
% %Create a stem plot using the stem function
% figure('position',[10 10 400 320])
% hold on
% box on
% x = 1:14;
% for i = 1:5
%     stem(x+(i-1)*.15,k_h1(1:14,i), '*:m')
%     stem(x+(i-1)*.15,k_n11(1:14,i), 'p:b','filled','LineWidth',1)
%     stem(x+(i-1)*.15,k_n41(1:14,i), 'p:c')
% end
% %Add a legend
% legend('Bundle Nonconv Inex', 'Variable Metric BFGS', ...
%     'Variable Metric BFGS Adaptive','Location','northwest')
% title('constant noise','Interpreter','latex')
% xlabel('$n$','Interpreter','latex')
% ylabel('number of steps','Interpreter','latex')
% axis([0.85, 15, 0, 5000])
% xticks(1:14)
% xticklabels(2:15)
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
% %% vanishing noise
% %Create a stem plot using the stem function
% figure('position',[10 10 400 320])
% hold on
% box on
% x = 1:14;
% for i = 1:5
%     stem(x+(i-1)*.15,log_f_h2(1:14,i), '*:m')
%     stem(x+(i-1)*.15,log_f_n12(1:14,i), 'p:b','filled','LineWidth',1)
%     stem(x+(i-1)*.15,log_f_n42(1:14,i), 'p:c')
% end
% %Add a legend
% legend('Bundle Nonconv Inex', 'Variable Metric BFGS', ...
%     'Variable Metric BFGS Adaptive')
% title('vanishing noise','Interpreter','latex')
% xlabel('$n$','Interpreter','latex')
% ylabel('abs log distance from 0','Interpreter','latex')
% axis([0.85, 15, 0, 12.5])
% xticks(1:14)
% xticklabels(2:15)
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
% %Create a stem plot using the stem function
% figure('position',[10 10 400 320])
% hold on
% box on
% x = 1:14;
% for i = 1:5
%     stem(x+(i-1)*.15,k_h2(1:14,i), '*:m')
%     stem(x+(i-1)*.15,k_n12(1:14,i), 'p:b','filled','LineWidth',1)
%     stem(x+(i-1)*.15,k_n42(1:14,i), 'p:c')
% end
% %Add a legend
% legend('Bundle Nonconv Inex', 'Variable Metric BFGS', ...
%     'Variable Metric BFGS Adaptive','Location','northwest')
% title('vanishing noise','Interpreter','latex')
% xlabel('$n$','Interpreter','latex')
% ylabel('number of steps','Interpreter','latex')
% axis([0.85, 15, 0, 5000])
% xticks(1:14)
% xticklabels(2:15)
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

%% constant gradient noise
% % Create a stem plot using the stem function
% figure('position',[10 10 400 320])
% hold on
% box on
% x = 1:14;
% for i = 1:5
%     stem(x+(i-1)*.15,log_f_h3(1:14,i), '*:m')
%     stem(x+(i-1)*.15,log_f_n13(1:14,i), 'p:b','filled','LineWidth',1)
%     stem(x+(i-1)*.15,log_f_n43(1:14,i), 'p:c')
% end
% % Add a legend
% legend('Bundle Nonconv Inex', 'Variable Metric BFGS', ...
%     'Variable Metric BFGS Adaptive')
% title('constant gradient noise','Interpreter','latex')
% xlabel('$n$','Interpreter','latex')
% ylabel('abs log distance from 0','Interpreter','latex')
% axis([0.85, 15, 0, 12.5])
% xticks(1:14)
% xticklabels(2:15)
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

% Create a stem plot using the stem function
figure('position',[10 10 400 320])
hold on
box on
x = 1:14;
for i = 1:5
    stem(x+(i-1)*.15,k_h3(1:14,i), '*:m')
    stem(x+(i-1)*.15,k_n13(1:14,i), 'p:b','filled','LineWidth',1)
    stem(x+(i-1)*.15,k_n43(1:14,i), 'p:c')
end
% Add a legend
legend('Bundle Nonconv Inex', 'Variable Metric BFGS', ...
    'Variable Metric BFGS Adaptive','Location','northwest')
title('constant gradient noise','Interpreter','latex')
xlabel('$n$','Interpreter','latex')
ylabel('number of steps','Interpreter','latex')
axis([0.85, 15, 0, 500])
xticks(1:14)
xticklabels(2:15)
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

%% vanishing gradient noise
% Create a stem plot using the stem function
figure('position',[10 10 400 320])
hold on
box on
x = 1:14;
for i = 1:5
    stem(x+(i-1)*.15,log_f_h4(1:14,i), '*:m')
    stem(x+(i-1)*.15,log_f_n14(1:14,i), 'p:b','filled','LineWidth',1)
    stem(x+(i-1)*.15,log_f_n44(1:14,i), 'p:c')
end
% Add a legend
legend('Bundle Nonconv Inex', 'Variable Metric BFGS', ...
    'Variable Metric BFGS Adaptive')
title('vanishing gradient noise','Interpreter','latex')
xlabel('$n$','Interpreter','latex')
ylabel('abs log distance from 0','Interpreter','latex')
axis([0.85, 15, 0, 12.5])
xticks(1:14)
xticklabels(2:15)
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

% Create a stem plot using the stem function
figure('position',[10 10 400 320])
hold on
box on
x = 1:14;
for i = 1:5
    stem(x+(i-1)*.15,k_h4(1:14,i), '*:m')
    stem(x+(i-1)*.15,k_n14(1:14,i), 'p:b','filled','LineWidth',1)
    stem(x+(i-1)*.15,k_n44(1:14,i), 'p:c')
end
% Add a legend
legend('Bundle Nonconv Inex', 'Variable Metric BFGS', ...
    'Variable Metric BFGS Adaptive','Location','northwest')
title('vanishing gradient noise','Interpreter','latex')
xlabel('$n$','Interpreter','latex')
ylabel('number of steps','Interpreter','latex')
axis([0.85, 15, 0, 500])
xticks(1:14)
xticklabels(2:15)
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
