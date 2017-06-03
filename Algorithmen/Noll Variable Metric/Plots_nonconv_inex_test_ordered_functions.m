%plots the 5 test functions for different x-dimensions and noise forms
%ordered by function

%% no noise
% tol: 1e-3, smaller dimension
% Create a stem plot using the stem function
figure
hold on
for d = 1:15
    for f = 1:5
        stem((3*f-2)+(d-1)*.15,log_f_h30_s(d,f), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
        stem((3*f-2)+(d-1)*.15,log_f_nb30_s(d,f), 'p:c','filled')
        stem((3*f-2)+(d-1)*.15,log_f_ns30_s(d,f), 'x:m','filled')
    end
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, no noise')
xlabel('test function')
ylabel('abs log distance from 0')
axis([0.8, 16.2, 0, 9.5])
%xticks([1,4,7,10,13])
%xticklabels([1,2,3,4,5])
set(gca,'ygrid','on')
savefig('1e-3_0s_ord.fig')
hold off

% tol: 1e-3, bigger dimension
figure
hold on
for d = 1:3
    for f = 1:5
        stem((f)+(d-1)*.15,log_f_h30_b(d,f), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
        stem((f)+(d-1)*.15,log_f_nb30_b(d,f), 'p:c','filled')
        stem((f)+(d-1)*.15,log_f_ns30_b(d,f), 'x:m','filled')
    end
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, no noise')
xlabel('n')
ylabel('abs log distance from 0')
axis([0.8, 6, 0, 9.5])
%xticks(1:5)
%xticklabels([1,2,3,4,5])
set(gca,'ygrid','on')
savefig('1e-3_0b_ord.fig')
hold off

% tol: 1e-6, smaller dimension
% Create a stem plot using the stem function
figure
hold on
for d = 1:15
    for f = 1:5
        stem((3*f-2)+(d-1)*.15,log_f_h60_s(d,f), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
        stem((3*f-2)+(d-1)*.15,log_f_nb60_s(d,f), 'p:c','filled')
        stem((3*f-2)+(d-1)*.15,log_f_ns60_s(d,f), 'x:m','filled')
    end
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, no noise')
xlabel('test function')
ylabel('abs log distance from 0')
axis([0.8, 16.2, 0, 9.5])
%xticks([1,4,7,10,13])
%xticklabels([1,2,3,4,5])
set(gca,'ygrid','on')
savefig('1e-6_0s_ord.fig')
hold off

% tol: 1e-6, bigger dimension
figure
hold on
for d = 1:3
    for f = 1:5
        stem((f)+(d-1)*.15,log_f_h60_b(d,f), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
        stem((f)+(d-1)*.15,log_f_nb60_b(d,f), 'p:c','filled')
        stem((f)+(d-1)*.15,log_f_ns60_b(d,f), 'x:m','filled')
    end
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, no noise')
xlabel('n')
ylabel('abs log distance from 0')
axis([0.8, 6, 0, 9.5])
%xticks(1:5)
%xticklabels([1,2,3,4,5])
set(gca,'ygrid','on')
savefig('1e-6_0b_ord.fig')
hold off
 
 
%% constant noise
% tol: 1e-3, smaller dimension
% Create a stem plot using the stem function
figure
hold on
for d = 1:15
    for f = 1:5
        stem((3*f-2)+(d-1)*.15,log_f_h31_s(d,f), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
        stem((3*f-2)+(d-1)*.15,log_f_nb31_s(d,f), 'p:c','filled')
        stem((3*f-2)+(d-1)*.15,log_f_ns31_s(d,f), 'x:m','filled')
    end
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, constant noise')
xlabel('test function')
ylabel('abs log distance from 0')
axis([0.8, 16.2, 0, 9.5])
%xticks([1,4,7,10,13])
%xticklabels([1,2,3,4,5])
set(gca,'ygrid','on')
savefig('1e-3_1s_ord.fig')
hold off

% tol: 1e-3, bigger dimension
figure
hold on
for d = 1:3
    for f = 1:5
        stem((f)+(d-1)*.15,log_f_h31_b(d,f), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
        stem((f)+(d-1)*.15,log_f_nb31_b(d,f), 'p:c','filled')
        stem((f)+(d-1)*.15,log_f_ns31_b(d,f), 'x:m','filled')
    end
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, constant noise')
xlabel('n')
ylabel('abs log distance from 0')
axis([0.8, 6, 0, 9.5])
%xticks(1:5)
%xticklabels([1,2,3,4,5])
set(gca,'ygrid','on')
savefig('1e-3_1b_ord.fig')
hold off

% tol: 1e-6, smaller dimension
% Create a stem plot using the stem function
figure
hold on
for d = 1:15
    for f = 1:5
        stem((3*f-2)+(d-1)*.15,log_f_h61_s(d,f), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
        stem((3*f-2)+(d-1)*.15,log_f_nb61_s(d,f), 'p:c','filled')
        stem((3*f-2)+(d-1)*.15,log_f_ns61_s(d,f), 'x:m','filled')
    end
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, constant noise')
xlabel('test function')
ylabel('abs log distance from 0')
axis([0.8, 16.2, 0, 9.5])
%xticks([1,4,7,10,13])
%xticklabels([1,2,3,4,5])
set(gca,'ygrid','on')
savefig('1e-6_1s_ord.fig')
hold off

% tol: 1e-6, bigger dimension
figure
hold on
for d = 1:3
    for f = 1:5
        stem((f)+(d-1)*.15,log_f_h61_b(d,f), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
        stem((f)+(d-1)*.15,log_f_nb61_b(d,f), 'p:c','filled')
        stem((f)+(d-1)*.15,log_f_ns61_b(d,f), 'x:m','filled')
    end
end
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, constant noise')
xlabel('n')
ylabel('abs log distance from 0')
axis([0.8, 6, 0, 9.5])
%xticks(1:5)
%xticklabels([1,2,3,4,5])
set(gca,'ygrid','on')
savefig('1e-6_1b_ord.fig')
hold off


% %% vanishing noise
% % tol: 1e-3, smaller dimension
% % Create a stem plot using the stem function
% figure
% hold on
% x = 1:15;
% for d = 1:5
%     stem(x+(d-1)*.15,log_f_h32_s(:,d), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
%     stem(x+(d-1)*.15,log_f_nb32_s(:,d), 'p:c','filled')
%     stem(x+(d-1)*.15,log_f_ns32_s(:,d), 'x:m','filled')
% end
% % Add a legend
% legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
%     'Varible Metric SR1')
% title('tol: 1e-3, vanishing noise')
% xlabel('n')
% ylabel('abs log distance from 0')
% axis([0.85, 16, 0, 9.5])
% xticks(1:15)
% set(gca,'ygrid','on')
% 
% hold off
% 
% % tol: 1e-3, bigger dimension
% figure
% hold on
% x = 1:3;
% for d = 1:5
%     stem(x+(d-1)*.15,log_f_h32_b(:,d), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
%     stem(x+(d-1)*.15,log_f_nb32_b(:,d), 'p:c','filled')
%     stem(x+(d-1)*.15,log_f_ns32_b(:,d), 'x:m','filled')
% end
% % Add a legend
% legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
%     'Varible Metric SR1')
% title('tol: 1e-3, vanishing noise')
% xlabel('n')
% ylabel('abs log distance from 0')
% axis([0.85, 4, 0, 9.5])
% xticks(1:3)
% xticklabels({'20','25','30'})
% set(gca,'ygrid','on')
% hold off
% 
% % tol: 1e-6, smaller dimension
% % Create a stem plot using the stem function
% figure
% hold on
% x = 1:15;
% for d = 1:5
%     stem(x+(d-1)*.15,log_f_h62_s(:,d), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
%     stem(x+(d-1)*.15,log_f_nb62_s(:,d), 'p:c','filled')
%     stem(x+(d-1)*.15,log_f_ns62_s(:,d), 'x:m','filled')
% end
% % Add a legend
% legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
%     'Varible Metric SR1')
% title('tol: 1e-6, vanishing noise')
% xlabel('n')
% ylabel('abs log distance from 0')
% axis([0.85, 16, 0, 9.5])
% xticks(1:15)
% set(gca,'ygrid','on')
% 
% hold off
% 
% % tol: 1e-6, bigger dimension
% figure
% hold on
% x = 1:3;
% for d = 1:5
%     stem(x+(d-1)*.15,log_f_h62_b(:,d), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
%     stem(x+(d-1)*.15,log_f_nb62_b(:,d), 'p:c','filled')
%     stem(x+(d-1)*.15,log_f_ns62_b(:,d), 'x:m','filled')
% end
% % Add a legend
% legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
%     'Varible Metric SR1')
% title('tol: 1e-6, vanishing noise')
% xlabel('n')
% ylabel('abs log distance from 0')
% axis([0.85, 4, 0, 9.5])
% xticks(1:3)
% xticklabels({'20','25','30'})
% set(gca,'ygrid','on')
% hold off
% 
% 
% %% constant gradient noise
% % tol: 1e-3, smaller dimension
% % Create a stem plot using the stem function
% figure
% hold on
% x = 1:15;
% for d = 1:5
%     stem(x+(d-1)*.15,log_f_h33_s(:,d), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
%     stem(x+(d-1)*.15,log_f_nb33_s(:,d), 'p:c','filled')
%     stem(x+(d-1)*.15,log_f_ns33_s(:,d), 'x:m','filled')
% end
% % Add a legend
% legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
%     'Varible Metric SR1')
% title('tol: 1e-3, constant gradient noise')
% xlabel('n')
% ylabel('abs log distance from 0')
% axis([0.85, 16, 0, 9.5])
% xticks(1:15)
% set(gca,'ygrid','on')
% 
% hold off
% 
% % tol: 1e-3, bigger dimension
% figure
% hold on
% x = 1:3;
% for d = 1:5
%     stem(x+(d-1)*.15,log_f_h33_b(:,d), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
%     stem(x+(d-1)*.15,log_f_nb33_b(:,d), 'p:c','filled')
%     stem(x+(d-1)*.15,log_f_ns33_b(:,d), 'x:m','filled')
% end
% % Add a legend
% legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
%     'Varible Metric SR1')
% title('tol: 1e-3, constant gradient noise')
% xlabel('n')
% ylabel('abs log distance from 0')
% axis([0.85, 4, 0, 9.5])
% xticks(1:3)
% xticklabels({'20','25','30'})
% set(gca,'ygrid','on')
% hold off
% 
% % tol: 1e-6, smaller dimension
% % Create a stem plot using the stem function
% figure
% hold on
% x = 1:15;
% for d = 1:5
%     stem(x+(d-1)*.15,log_f_h63_s(:,d), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
%     stem(x+(d-1)*.15,log_f_nb63_s(:,d), 'p:c','filled')
%     stem(x+(d-1)*.15,log_f_ns63_s(:,d), 'x:m','filled')
% end
% % Add a legend
% legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
%     'Varible Metric SR1')
% title('tol: 1e-6, constant gradient noise')
% xlabel('n')
% ylabel('abs log distance from 0')
% axis([0.85, 16, 0, 9.5])
% xticks(1:15)
% set(gca,'ygrid','on')
% 
% hold off
% 
% % tol: 1e-6, bigger dimension
% figure
% hold on
% x = 1:3;
% for d = 1:5
%     stem(x+(d-1)*.15,log_f_h63_b(:,d), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
%     stem(x+(d-1)*.15,log_f_nb63_b(:,d), 'p:c','filled')
%     stem(x+(d-1)*.15,log_f_ns63_b(:,d), 'x:m','filled')
% end
% % Add a legend
% legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
%     'Varible Metric SR1')
% title('tol: 1e-6, constant gradient noise')
% xlabel('n')
% ylabel('abs log distance from 0')
% axis([0.85, 4, 0, 9.5])
% xticks(1:3)
% xticklabels({'20','25','30'})
% set(gca,'ygrid','on')
% hold off
% 
% 
% %% vanishing gradient noise
% % tol: 1e-3, smaller dimension
% % Create a stem plot using the stem function
% figure
% hold on
% x = 1:15;
% for d = 1:5
%     stem(x+(d-1)*.15,log_f_h34_s(:,d), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
%     stem(x+(d-1)*.15,log_f_nb34_s(:,d), 'p:c','filled')
%     stem(x+(d-1)*.15,log_f_ns34_s(:,d), 'x:m','filled')
% end
% % Add a legend
% legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
%     'Varible Metric SR1')
% title('tol: 1e-3, vanishing gradient noise')
% xlabel('n')
% ylabel('abs log distance from 0')
% axis([0.85, 16, 0, 9.5])
% xticks(1:15)
% set(gca,'ygrid','on')
% 
% hold off
% 
% % tol: 1e-3, bigger dimension
% figure
% hold on
% x = 1:3;
% for d = 1:5
%     stem(x+(d-1)*.15,log_f_h34_b(:,d), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
%     stem(x+(d-1)*.15,log_f_nb34_b(:,d), 'p:c','filled')
%     stem(x+(d-1)*.15,log_f_ns34_b(:,d), 'x:m','filled')
% end
% % Add a legend
% legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
%     'Varible Metric SR1')
% title('tol: 1e-3, vanishing noise')
% xlabel('n')
% ylabel('abs log distance from 0')
% axis([0.85, 4, 0, 9.5])
% xticks(1:3)
% xticklabels({'20','25','30'})
% set(gca,'ygrid','on')
% hold off
% 
% % tol: 1e-6, smaller dimension
% % Create a stem plot using the stem function
% figure
% hold on
% x = 1:15;
% for d = 1:5
%     stem(x+(d-1)*.15,log_f_h64_s(:,d), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
%     stem(x+(d-1)*.15,log_f_nb64_s(:,d), 'p:c','filled')
%     stem(x+(d-1)*.15,log_f_ns64_s(:,d), 'x:m','filled')
% end
% % Add a legend
% legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
%     'Varible Metric SR1')
% title('tol: 1e-6, vanishing noise')
% xlabel('n')
% ylabel('abs log distance from 0')
% axis([0.85, 16, 0, 9.5])
% xticks(1:15)
% set(gca,'ygrid','on')
% 
% hold off
% 
% % tol: 1e-6, bigger dimension
% figure
% hold on
% x = 1:3;
% for d = 1:5
%     stem(x+(d-1)*.15,log_f_h64_b(:,d), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
%     stem(x+(d-1)*.15,log_f_nb64_b(:,d), 'p:c','filled')
%     stem(x+(d-1)*.15,log_f_ns64_b(:,d), 'x:m','filled')
% end
% % Add a legend
% legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
%     'Varible Metric SR1')
% title('tol: 1e-6, vanishing gradient noise')
% xlabel('n')
% ylabel('abs log distance from 0')
% axis([0.85, 4, 0, 9.5])
% xticks(1:3)
% xticklabels({'20','25','30'})
% set(gca,'ygrid','on')
% hold off