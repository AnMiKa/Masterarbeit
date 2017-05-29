%plots of the averages over all 5 test functions

%% no noise
% tol: 1e-3, smaller dimension
% Create a stem plot using the stem function
figure
p_av_30_s = stem(log_f_h30_s, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb30_s, 'p--c','filled')
stem(log_f_ns30_s, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, no noise')
ylabel('log distance from 0')
hold off

% tol: 1e-3, bigger dimension
% Create a stem plot using the stem function
figure
p_av_30_b = stem(log_f_h30_b, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb30_b, 'p--c','filled')
stem(log_f_ns30_b, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, no noise')
ylabel('log distance from 0')
hold off

% tol: 1e-6, smaller dimension
% Create a stem plot using the stem function
figure
p_av_60_s = stem(log_f_h60_s, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb60_s, 'p--c','filled')
stem(log_f_ns60_s, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, no noise')
ylabel('log distance from 0')
hold off

% tol: 1e-6, bigger dimension
% Create a stem plot using the stem function
figure
p_av_60_b = stem(log_f_h60_b, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb60_b, 'p--c','filled')
stem(log_f_ns60_b, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, no noise')
ylabel('log distance from 0')
hold off

%% constant noise
% tol: 1e-3, smaller dimension
% Create a stem plot using the stem function
figure
p_av_31_s = stem(log_f_h31_s, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb31_s, 'p--c','filled')
stem(log_f_ns31_s, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, constant noise')
ylabel('log distance from 0')
hold off

% tol: 1e-3, bigger dimension
% Create a stem plot using the stem function
figure
p_av_31_b = stem(log_f_h31_b, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb31_b, 'p--c','filled')
stem(log_f_ns31_b, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, constant noise')
ylabel('log distance from 0')
hold off

% tol: 1e-6, smaller dimension
% Create a stem plot using the stem function
figure
p_av_61_s = stem(log_f_h61_s, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb61_s, 'p--c','filled')
stem(log_f_ns61_s, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, constant noise')
ylabel('log distance from 0')
hold off

% tol: 1e-6, bigger dimension
% Create a stem plot using the stem function
figure
p_av_61_s = stem(log_f_h61_b, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb61_b, 'p--c','filled')
stem(log_f_ns61_b, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, constant noise')
ylabel('log distance from 0')
hold off

%% vanishing noise
% tol: 1e-3, smaller dimension
% Create a stem plot using the stem function
figure
p_av_32_s = stem(log_f_h32_s, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb32_s, 'p--c','filled')
stem(log_f_ns32_s, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, vanishing noise')
ylabel('log distance from 0')
hold off

% tol: 1e-3, bigger dimension
% Create a stem plot using the stem function
figure
p_av_32_b = stem(log_f_h32_b, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb32_b, 'p--c','filled')
stem(log_f_ns32_b, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, vanishing noise')
ylabel('log distance from 0')
hold off

% tol: 1e-6, smaller dimension
% Create a stem plot using the stem function
figure
p_av_62_s = stem(log_f_h62_s, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb62_s, 'p--c','filled')
stem(log_f_ns62_s, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, vanishing noise')
ylabel('log distance from 0')
hold off

% tol: 1e-6, bigger dimension
% Create a stem plot using the stem function
figure
p_av_62_b = stem(log_f_h62_b, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb62_b, 'p--c','filled')
stem(log_f_ns62_b, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, vanishing noise')
ylabel('log distance from 0')
hold off

%% constant gradient noise
% tol: 1e-3, smaller dimension
% Create a stem plot using the stem function
figure
p_av_33_s = stem(log_f_h33_s, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb33_s, 'p--c','filled')
stem(log_f_ns33_s, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, constant gradient noise')
ylabel('log distance from 0')
hold off

% tol: 1e-3, bigger dimension
% Create a stem plot using the stem function
figure
p_av_33_b = stem(log_f_h33_b, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb33_b, 'p--c','filled')
stem(log_f_ns33_b, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, constant gradient noise')
ylabel('log distance from 0')
hold off

% tol: 1e-6, smaller dimension
% Create a stem plot using the stem function
figure
p_av_63_s = stem(log_f_h63_s, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb63_s, 'p--c','filled')
stem(log_f_ns63_s, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, constant gradient noise')
ylabel('log distance from 0')
hold off

% tol: 1e-6, bigger dimension
% Create a stem plot using the stem function
figure
p_av_63_b = stem(log_f_h63_b, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb63_b, 'p--c','filled')
stem(log_f_ns63_b, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, constant gradient noise')
ylabel('log distance from 0')
hold off

%% vanishing gradient noise
% tol: 1e-3, smaller dimension
% Create a stem plot using the stem function
figure
p_av_34_s = stem(log_f_h34_s, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb34_s, 'p--c','filled')
stem(log_f_ns34_s, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, vanishing gradient noise')
ylabel('log distance from 0')
hold off

% tol: 1e-3, bigger dimension
% Create a stem plot using the stem function
figure
p_av_34_b = stem(log_f_h34_b, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb34_b, 'p--c','filled')
stem(log_f_ns34_b, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-3, vanishing gradient noise')
ylabel('log distance from 0')
hold off

% tol: 1e-6, smaller dimension
% Create a stem plot using the stem function
figure
p_av_64_s = stem(log_f_h64_s, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb64_s, 'p--c','filled')
stem(log_f_ns64_s, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, vanishing gradient noise')
ylabel('log distance from 0')
hold off

% tol: 1e-6, bigger dimension
% Create a stem plot using the stem function
figure
p_av_64_b = stem(log_f_h64_b, 'p--','filled');
hold on
% Add the second and third data sets to the plot
stem(log_f_nb64_b, 'p--c','filled')
stem(log_f_ns64_b, 'p--m','filled')
% Add a legend
legend('Nonconv Iinex Bundle', 'Variable Metric BFGS', ...
    'Varible Metric SR1')
title('tol: 1e-6, vanishing gradient noise')
ylabel('log distance from 0')
hold off
