%plots the 5 test functions for different x-dimensions and forms of noise
%large dimension
%% no noise
%Create a stem plot using the stem function
figure('position',[0 0 400 320])
hold on
box on
x = 1:5;
for i = 1:5
    stem(x+(i-1)*.15,log_f_n10_1(1:5,i), '*:m')
    stem(x+(i-1)*.15,log_f_n10(1:5,i), 'p:b','filled','LineWidth',1)
    stem(x+(i-1)*.15,log_f_n50(1:5,i), 'p:c','filled')
end
%Add a legend
legend('Variable Metric BFGS, 1.2', 'Variable Metric BFGS, 2', ...
    'Variable Metric BFGS k-scaled')
title('no noise','Interpreter','latex')
xlabel('$n$','Interpreter','latex')
ylabel('abs log distance from 0','Interpreter','latex')
axis([0.85, 6, 0, 12.5])
xticks(1:6)
xticklabels([20,25,30,40,50])
set(gca,'ygrid','on')
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_n1eight = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_n1eight];

%Create a stem plot using the stem function
figure('position',[10 10 400 320])
hold on
box on
x = 1:5;
for i = 1:5
    stem(x+(i-1)*.15,k_n10_1(1:5,i), '*:m')
    stem(x+(i-1)*.15,k_n10(1:5,i), 'p:b','filled','LineWidth',1)
    stem(x+(i-1)*.15,k_n50(1:5,i), 'p:c','filled')
end
legend('Variable Metric BFGS, 1.2', 'Variable Metric BFGS, 2', ...
    'Variable Metric BFGS k-scaled','Location','northwest')
title('no noise','Interpreter','latex')
xlabel('$n$','Interpreter','latex')
ylabel('number of steps','Interpreter','latex')
axis([0.85, 6, 0, 15000])
xticks(1:6)
xticklabels([20,25,30,40,50])
%yticks(0:50:60000)
set(gca,'ygrid','on')
pbaspect([1 2/3 1])

ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_n1eight = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_n1eight];

%% constant noise
%Create a stem plot using the stem function
figure('position',[10 10 400 320])
hold on
box on
x = 1:5;
for i = 1:5
    stem(x+(i-1)*.15,log_f_n11_1(1:5,i), '*:m')
    stem(x+(i-1)*.15,log_f_n11(1:5,i), 'p:b','filled','LineWidth',1)
    stem(x+(i-1)*.15,log_f_n51(1:5,i), 'p:c','filled')
end
%Add a legend
legend('Variable Metric BFGS, 1.2', 'Variable Metric BFGS, 2', ...
    'Variable Metric BFGS k-scaled')
title('constant noise','Interpreter','latex')
xlabel('$n$','Interpreter','latex')
ylabel('abs log distance from 0','Interpreter','latex')
axis([0.85, 6, 0, 12.5])
xticks(1:6)
xticklabels([20,25,30,40,50])
set(gca,'ygrid','on')
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_n1eight = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_n1eight];

%Create a stem plot using the stem function
figure('position',[10 10 400 320])
hold on
box on
x = 1:5;
for i = 1:5
    stem(x+(i-1)*.15,k_n11_1(1:5,i), '*:m')
    stem(x+(i-1)*.15,k_n11(1:5,i), 'p:b','filled','LineWidth',1)
    stem(x+(i-1)*.15,k_n51(1:5,i), 'p:c','filled')
end
%Add a legend
legend('Variable Metric BFGS, 1.2', 'Variable Metric BFGS, 2', ...
    'Variable Metric BFGS k-scaled','Location','northwest')
title('constant noise','Interpreter','latex')
xlabel('$n$','Interpreter','latex')
ylabel('number of steps','Interpreter','latex')
axis([0.85, 6, 0, 15000])
xticks(1:6)
xticklabels([20,25,30,40,50])
set(gca,'ygrid','on')
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_n1eight = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_n1eight];

%% vanishing noise
%Create a stem plot using the stem function
figure('position',[10 10 400 320])
hold on
box on
x = 1:5;
for i = 1:5
    stem(x+(i-1)*.15,log_f_n12_1(1:5,i), '*:m')
    stem(x+(i-1)*.15,log_f_n12(1:5,i), 'p:b','filled','LineWidth',1)
    stem(x+(i-1)*.15,log_f_n52(1:5,i), 'p:c','filled')
end
%Add a legend
legend('Variable Metric BFGS, 1.2', 'Variable Metric BFGS, 2', ...
    'Variable Metric BFGS k-scaled')
title('vanishing noise','Interpreter','latex')
xlabel('$n$','Interpreter','latex')
ylabel('abs log distance from 0','Interpreter','latex')
axis([0.85, 6, 0, 12.5])
xticks(1:6)
xticklabels([20,25,30,40,50])
set(gca,'ygrid','on')
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_n1eight = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_n1eight];

%Create a stem plot using the stem function
figure('position',[10 10 400 320])
hold on
box on
x = 1:5;
for i = 1:5
    stem(x+(i-1)*.15,k_n12_1(1:5,i), '*:m')
    stem(x+(i-1)*.15,k_n12(1:5,i), 'p:b','filled','LineWidth',1)
    stem(x+(i-1)*.15,k_n52(1:5,i), 'p:c','filled')
end
%Add a legend
legend('Variable Metric BFGS, 1.2', 'Variable Metric BFGS, 2', ...
    'Variable Metric BFGS k-scaled','Location','northwest')
title('vanishing noise','Interpreter','latex')
xlabel('$n$','Interpreter','latex')
ylabel('number of steps','Interpreter','latex')
axis([0.85, 6, 0, 15000])
xticks(1:6)
xticklabels([20,25,30,40,50])
set(gca,'ygrid','on')
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_n1eight = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_n1eight];

%% constant gradient noise
% Create a stem plot using the stem function
figure('position',[10 10 400 320])
hold on
box on
x = 1:5;
for i = 1:5
    stem(x+(i-1)*.15,log_f_n13_1(1:5,i), '*:m')
    stem(x+(i-1)*.15,log_f_n13(1:5,i), 'p:b','filled','LineWidth',1)
    stem(x+(i-1)*.15,log_f_n53(1:5,i), 'p:c','filled')
end
% Add a legend
legend('Variable Metric BFGS, 1.2', 'Variable Metric BFGS, 2', ...
    'Variable Metric BFGS k-scaled')
title('constant gradient noise','Interpreter','latex')
xlabel('$n$','Interpreter','latex')
ylabel('abs log distance from 0','Interpreter','latex')
axis([0.85, 6, 0, 12.5])
xticks(1:6)
xticklabels([20,25,30,40,50])
set(gca,'ygrid','on')
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_n1eight = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_n1eight];

% Create a stem plot using the stem function
figure('position',[10 10 400 320])
hold on
box on
x = 1:5;
for i = 1:5
    stem(x+(i-1)*.15,k_n13_1(1:5,i), '*:m')
    stem(x+(i-1)*.15,k_n13(1:5,i), 'p:b','filled','LineWidth',1)
    stem(x+(i-1)*.15,k_n53(1:5,i), 'p:c','filled')
end
% Add a legend
legend('Variable Metric BFGS, 1.2', 'Variable Metric BFGS, 2', ...
    'Variable Metric BFGS k-scaled','Location','northwest')
title('constant gradient noise','Interpreter','latex')
xlabel('$n$','Interpreter','latex')
ylabel('number of steps','Interpreter','latex')
axis([0.85, 6, 0, 6000])
xticks(1:6)
xticklabels([20,25,30,40,50])
set(gca,'ygrid','on')
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_n1eight = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_n1eight];

%% vanishing gradient noise
%Create a stem plot using the stem function
figure('position',[10 10 400 320])
hold on
box on
x = 1:5;
for i = 1:5
    stem(x+(i-1)*.15,log_f_n14_1(1:5,i), '*:m')
    stem(x+(i-1)*.15,log_f_n14(1:5,i), 'p:b','filled','LineWidth',1)
    stem(x+(i-1)*.15,log_f_n54(1:5,i), 'p:c','filled')
end
% Add a legend
legend('Variable Metric BFGS, 1.2', 'Variable Metric BFGS, 2', ...
    'Variable Metric BFGS k-scaled')
title('vanishing gradient noise','Interpreter','latex')
xlabel('$n$','Interpreter','latex')
ylabel('abs log distance from 0','Interpreter','latex')
axis([0.85, 6, 0, 12.5])
xticks(1:6)
xticklabels([20,25,30,40,50])
set(gca,'ygrid','on')
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_n1eight = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_n1eight];

% Create a stem plot using the stem function
figure('position',[10 10 400 320])
hold on
box on
x = 1:5;
for i = 1:5
    stem(x+(i-1)*.15,k_n14_1(1:5,i), '*:m')
    stem(x+(i-1)*.15,k_n14(1:5,i), 'p:b','filled','LineWidth',1)
    stem(x+(i-1)*.15,k_n54(1:5,i), 'p:c','filled')
end
% Add a legend
legend('Variable Metric BFGS, 1.2', 'Variable Metric BFGS, 2', ...
    'Variable Metric BFGS k-scaled','Location','northwest')
title('vanishing gradient noise','Interpreter','latex')
xlabel('$n$','Interpreter','latex')
ylabel('number of steps','Interpreter','latex')
axis([0.85, 6, 0, 6000])
xticks(1:6)
xticklabels([20,25,30,40,50])
set(gca,'ygrid','on')
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_n1eight = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_n1eight];
