%plots the computation times for the 5 test functions for different x-dimensions and forms of noise

%% no noise
% tol: 1e-3, smaller dimension
% Create a stem plot using the stem function
figure
hold on
box on
x = 1:15;
for i = 1:5
    stem(x+(i-1)*.15,t_h30_s(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb30_s(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns30_s(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, no noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 16, 0, min(max(max(t_h30_s)),15)])
xticks(1:15)
set(gca,'ygrid','on')
savefig('1e-3_0s.fig')
hold off

% tol: 1e-3, bigger dimension
figure
hold on
box on
x = 1:3;
for i = 1:5
    stem(x+(i-1)*.15,t_h30_b(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb30_b(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns30_b(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, no noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 4, 0, min(max(max(t_h30_b)),15)])
xticks(1:3)
xticklabels({'20','25','30'})
set(gca,'ygrid','on')
savefig('1e-3_0b.fig')
hold off

% tol: 1e-6, smaller dimension
% Create a stem plot using the stem function
figure
hold on
box on
x = 1:15;
for i = 1:5
    stem(x+(i-1)*.15,t_h60_s(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb60_s(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns60_s(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, no noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 16, 0, min(max(max(t_h60_s)),15)])
xticks(1:15)
set(gca,'ygrid','on')
savefig('1e-6_0s.fig')
hold off

% tol: 1e-6, bigger dimension
figure
box on
hold on
x = 1:3;
for i = 1:5
    stem(x+(i-1)*.15,t_h60_b(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb60_b(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns60_b(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, no noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 4, 0, min(max(max(t_h60_b)),15)])
xticks(1:3)
xticklabels({'20','25','30'})
set(gca,'ygrid','on')
savefig('1e-6_0b.fig')
hold off


%% constant noise
% tol: 1e-3, smaller dimension
% Create a stem plot using the stem function
figure
hold on
box on
x = 1:15;
for i = 1:5
    stem(x+(i-1)*.15,t_h31_s(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb31_s(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns31_s(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, constant noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 16, 0, min(max(max(t_h31_s)),15)])
xticks(1:15)
set(gca,'ygrid','on')
savefig('1e-3_1s.fig')
hold off

% tol: 1e-3, bigger dimension
figure
hold on
box on
x = 1:3;
for i = 1:5
    stem(x+(i-1)*.15,t_h31_b(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb31_b(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns31_b(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, constant noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 4, 0, min(max(max(t_h31_b)),15)])
xticks(1:3)
xticklabels({'20','25','30'})
set(gca,'ygrid','on')
savefig('1e-3_1b.fig')
hold off

% tol: 1e-6, smaller dimension
% Create a stem plot using the stem function
figure
hold on
box on
x = 1:15;
for i = 1:5
    stem(x+(i-1)*.15,t_h61_s(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb61_s(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns61_s(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, constant noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 16, 0, min(max(max(t_h61_s)),15)])
xticks(1:15)
set(gca,'ygrid','on')
savefig('1e-6_1s.fig')
hold off

% tol: 1e-6, bigger dimension
figure
hold on
box on
x = 1:3;
for i = 1:5
    stem(x+(i-1)*.15,t_h61_b(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb61_b(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns61_b(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, constant noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 4, 0, min(max(max(t_h61_b)),15)])
xticks(1:3)
xticklabels({'20','25','30'})
set(gca,'ygrid','on')
savefig('1e-6_1b.fig')
hold off


%% vanishing noise
% tol: 1e-3, smaller dimension
% Create a stem plot using the stem function
figure
hold on
box on
x = 1:15;
for i = 1:5
    stem(x+(i-1)*.15,t_h32_s(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb32_s(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns32_s(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, vanishing noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 16, 0, min(max(max(t_h32_s)),15)])
xticks(1:15)
set(gca,'ygrid','on')
savefig('1e-3_2s.fig')
hold off

% tol: 1e-3, bigger dimension
figure
hold on
box on
x = 1:3;
for i = 1:5
    stem(x+(i-1)*.15,t_h32_b(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb32_b(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns32_b(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, vanishing noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 4, 0, min(max(max(t_h32_b)),15)])
xticks(1:3)
xticklabels({'20','25','30'})
set(gca,'ygrid','on')
savefig('1e-3_2b.fig')
hold off

% tol: 1e-6, smaller dimension
% Create a stem plot using the stem function
figure
hold on
box on
x = 1:15;
for i = 1:5
    stem(x+(i-1)*.15,t_h62_s(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb62_s(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns62_s(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, vanishing noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 16, 0, min(max(max(t_h62_s)),15)])
xticks(1:15)
set(gca,'ygrid','on')
savefig('1e-6_2s.fig')
hold off

% tol: 1e-6, bigger dimension
figure
hold on
box on
x = 1:3;
for i = 1:5
    stem(x+(i-1)*.15,t_h62_b(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb62_b(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns62_b(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, vanishing noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 4, 0, min(max(max(t_h62_b)),15)])
xticks(1:3)
xticklabels({'20','25','30'})
set(gca,'ygrid','on')
savefig('1e-6_2b.fig')
hold off


%% constant gradient noise
% tol: 1e-3, smaller dimension
% Create a stem plot using the stem function
figure
box on
hold on
x = 1:15;
for i = 1:5
    stem(x+(i-1)*.15,t_h33_s(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb33_s(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns33_s(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, constant gradient noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 16, 0, min(max(max(t_h33_s)),15)])
xticks(1:15)
set(gca,'ygrid','on')
savefig('1e-3_3s.fig')
hold off

% tol: 1e-3, bigger dimension
figure
hold on
box on
x = 1:3;
for i = 1:5
    stem(x+(i-1)*.15,t_h33_b(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb33_b(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns33_b(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, constant gradient noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 4, 0, min(max(max(t_h33_b)),15)])
xticks(1:3)
xticklabels({'20','25','30'})
set(gca,'ygrid','on')
savefig('1e-3_3b.fig')
hold off

% tol: 1e-6, smaller dimension
% Create a stem plot using the stem function
figure
hold on
box on
x = 1:15;
for i = 1:5
    stem(x+(i-1)*.15,t_h63_s(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb63_s(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns63_s(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, constant gradient noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 16, 0, min(max(max(t_h63_s)),15)])
xticks(1:15)
set(gca,'ygrid','on')
savefig('1e-6_3s.fig')
hold off

% tol: 1e-6, bigger dimension
figure
box on
hold on
x = 1:3;
for i = 1:5
    stem(x+(i-1)*.15,t_h63_b(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb63_b(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns63_b(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, constant gradient noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 4, 0, min(max(max(t_h63_b)),15)])
xticks(1:3)
xticklabels({'20','25','30'})
set(gca,'ygrid','on')
savefig('1e-6_3b.fig')
hold off


%% vanishing gradient noise
% tol: 1e-3, smaller dimension
% Create a stem plot using the stem function
figure
hold on
box on
x = 1:15;
for i = 1:5
    stem(x+(i-1)*.15,t_h34_s(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb34_s(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns34_s(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, vanishing gradient noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 16, 0, min(max(max(t_h34_s)),15)])
xticks(1:15)
set(gca,'ygrid','on')
savefig('1e-3_4s.fig')
hold off

% tol: 1e-3, bigger dimension
figure
hold on
box on
x = 1:3;
for i = 1:5
    stem(x+(i-1)*.15,t_h34_b(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb34_b(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns34_b(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, vanishing noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 4, 0, min(max(max(t_h34_b)),15)])
xticks(1:3)
xticklabels({'20','25','30'})
set(gca,'ygrid','on')
savefig('1e-3_4b.fig')
hold off

% tol: 1e-6, smaller dimension
% Create a stem plot using the stem function
figure
hold on
box on
x = 1:15;
for i = 1:5
    stem(x+(i-1)*.15,t_h64_s(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb64_s(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns64_s(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, vanishing noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 16, 0, min(max(max(t_h64_s)),15)])
xticks(1:15)
set(gca,'ygrid','on')
savefig('1e-6_4s.fig')
hold off

% tol: 1e-6, bigger dimension
figure
hold on
box on
x = 1:3;
for i = 1:5
    stem(x+(i-1)*.15,t_h64_b(:,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,t_nb64_b(:,i), 'p:c','filled')
    stem(x+(i-1)*.15,t_ns64_b(:,i), 'x:m','filled')
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, vanishing gradient noise')
xlabel('n')
ylabel('computation time (sek)')
axis([0.85, 4, 0, min(max(max(t_h64_s)),15)])
xticks(1:3)
xticklabels({'20','25','30'})
set(gca,'ygrid','on')
savefig('1e-6_4b.fig')
hold off