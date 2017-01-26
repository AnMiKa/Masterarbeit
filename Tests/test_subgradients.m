% Test für die Subgradienten der Testfunktionen h_i und f1,...,f5

%was kann man an den nichtglatten Stellen machen?

% x1 = 20*rand(1,10) - 10;
% x2 = 20*rand(2,10) - 10;
% x4 = 20*rand(4,10) - 10;

x1 = [-5.5661, -5.6201, 0.4446, -1.3315, 4.8261, -8.5910, 6.9467, 3.5976, -7.2670, 7.1680];
x2 = [-6.0033, 0.8609, -9.8869, 5.2958, -8.8637, -6.5169, 0.6858, 8.3411, 7.7406, -6.3294; ...
       2.1468, -6.7535, 5.4297, -1.5786, 1.7149, 4.5722, -4.9387, 5.1639, -8.6240, 4.7415];
x4 = [3.9343, 2.2247, -4.0237, 7.7572, 6.3087, -4.7855, 0.8271, 7.1896, 7.1331, -0.9922;...
      5.5399, 7.1154, 4.0794, 6.8590, -9.9728, -9.5440, 8.5234, -3.1904, -2.3137, -0.5276; ...
      0.0381, 3.4159, -2.3678, 7.9760, -9.9382, -1.5183, -4.0300, -7.2376, 3.9138, 8.9941; ...
     -1.4901, 0.4718, 1.3537, 8.7801, -8.2506, -3.1787, -3.2383, 0.1560, 2.5581, -8.3300];


l = length(x1);
eps = 1e-4;

%initiate emty matrices for the subgradients (from implemented functions)
sgf11 = zeros(1,l);
sgf12 = zeros(2,l);
sgf14 = zeros(4,l);

sgf21 = zeros(1,l);
sgf22 = zeros(2,l);
sgf24 = zeros(4,l);

sgf31 = zeros(1,l);
sgf32 = zeros(2,l);
sgf34 = zeros(4,l);

sgf41 = zeros(1,l);
sgf42 = zeros(2,l);
sgf44 = zeros(4,l);

sgf51 = zeros(1,l);
sgf52 = zeros(2,l);
sgf54 = zeros(4,l);

%initiate emty matrices for the approximated subgradients
%(approximated by finite differences)
sgf11_a = zeros(1,l);
sgf12_a = zeros(2,l);
sgf14_a = zeros(4,l);

sgf21_a = zeros(1,l);
sgf22_a = zeros(2,l);
sgf24_a = zeros(4,l);

sgf31_a = zeros(1,l);
sgf32_a = zeros(2,l);
sgf34_a = zeros(4,l);

sgf41_a = zeros(1,l);
sgf42_a = zeros(2,l);
sgf44_a = zeros(4,l);

sgf51_a = zeros(1,l);
sgf52_a = zeros(2,l);
sgf54_a = zeros(4,l);

%calculate subgradients
for i = 1:l
    sgf11(i) = subgr_f1_testfunction(x1(i));
    sgf12(:,i) = subgr_f1_testfunction(x2(:,i));
    sgf14(:,i) = subgr_f1_testfunction(x4(:,i));
    
    sgf21(i) = subgr_f2_testfunction(x1(i));
    sgf22(:,i) = subgr_f2_testfunction(x2(:,i));
    sgf24(:,i) = subgr_f2_testfunction(x4(:,i));
    
    sgf31(i) = subgr_f3_testfunction(x1(i));
    sgf32(:,i) = subgr_f3_testfunction(x2(:,i));
    sgf34(:,i) = subgr_f3_testfunction(x4(:,i));
    
    sgf41(i) = subgr_f4_testfunction(x1(i));
    sgf42(:,i) = subgr_f4_testfunction(x2(:,i));
    sgf44(:,i) = subgr_f4_testfunction(x4(:,i));
    
    sgf51(i) = subgr_f5_testfunction(x1(i));
    sgf52(:,i) = subgr_f5_testfunction(x2(:,i));
    sgf54(:,i) = subgr_f5_testfunction(x4(:,i));
end

 I2 = eye(2);
 I4 = eye(4);

%calculate the approximate subgradients
for i = 1:l
    sgf11_a(i) = (f1_testfunction(x1(i) + eps/2) - f1_testfunction(x1(i) - eps/2))/eps;
    sgf21_a(i) = (f2_testfunction(x1(i) + eps/2) - f2_testfunction(x1(i) - eps/2))/eps;
    sgf31_a(i) = (f3_testfunction(x1(i) + eps/2) - f3_testfunction(x1(i) - eps/2))/eps;
    sgf41_a(i) = (f4_testfunction(x1(i) + eps/2) - f4_testfunction(x1(i) - eps/2))/eps;
    sgf51_a(i) = (f5_testfunction(x1(i) + eps/2) - f5_testfunction(x1(i) - eps/2))/eps;
    
    for j = 1:2
        sgf12_a(j,i) = (f1_testfunction(x2(:,i) + eps/2*I2(:,j)) - f1_testfunction(x2(:,i) - eps/2*I2(:,j)))/eps;
        sgf22_a(j,i) = (f2_testfunction(x2(:,i) + eps/2*I2(:,j)) - f2_testfunction(x2(:,i) - eps/2*I2(:,j)))/eps;
        sgf32_a(j,i) = (f3_testfunction(x2(:,i) + eps/2*I2(:,j)) - f3_testfunction(x2(:,i) - eps/2*I2(:,j)))/eps;
        sgf42_a(j,i) = (f4_testfunction(x2(:,i) + eps/2*I2(:,j)) - f4_testfunction(x2(:,i) - eps/2*I2(:,j)))/eps;
        sgf52_a(j,i) = (f5_testfunction(x2(:,i) + eps/2*I2(:,j)) - f5_testfunction(x2(:,i) - eps/2*I2(:,j)))/eps;
    end
    for j = 1:4
        sgf14_a(j,i) = (f1_testfunction(x4(:,i) + eps/2*I4(:,j)) - f1_testfunction(x4(:,i) - eps/2*I4(:,j)))/eps;
        sgf24_a(j,i) = (f2_testfunction(x4(:,i) + eps/2*I4(:,j)) - f2_testfunction(x4(:,i) - eps/2*I4(:,j)))/eps;
        sgf34_a(j,i) = (f3_testfunction(x4(:,i) + eps/2*I4(:,j)) - f3_testfunction(x4(:,i) - eps/2*I4(:,j)))/eps;
        sgf44_a(j,i) = (f4_testfunction(x4(:,i) + eps/2*I4(:,j)) - f4_testfunction(x4(:,i) - eps/2*I4(:,j)))/eps;
        sgf54_a(j,i) = (f5_testfunction(x4(:,i) + eps/2*I4(:,j)) - f5_testfunction(x4(:,i) - eps/2*I4(:,j)))/eps;
    end
end

%% Test 1a: compare f1 to f1_a for x1
sgf11;
sgf11_a;
assert(max(max(abs(sgf11-sgf11_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 1b: compare f1 to f1_a for x2
sgf12;
sgf12_a;
assert(max(max(abs(sgf12-sgf12_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 1c: compare f1 to f1_a for x4
sgf14;
sgf14_a;
assert(max(max(abs(sgf14-sgf14_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 2a: compare f2 to f2_a for x1
sgf21;
sgf21_a;
assert(max(max(abs(sgf21-sgf21_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 2b: compare f2 to f2_a for x2
sgf22;
sgf22_a;
assert(max(max(abs(sgf22-sgf22_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 2c: compare f2 to f2_a for x4
sgf24;
sgf24_a;
assert(max(max(abs(sgf24-sgf24_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 3a: compare f3 to f3_a for x1
sgf31;
sgf31_a;
assert(max(max(abs(sgf31-sgf31_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 3b: compare f3 to f3_a for x2
sgf32;
sgf32_a;
assert(max(max(abs(sgf32-sgf32_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 3c: compare f3 to f3_a for x4
sgf34;
sgf34_a;
assert(max(max(abs(sgf34-sgf34_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 4a: compare f4 to f4_a for x1
sgf41;
sgf41_a;
assert(max(max(abs(sgf41-sgf41_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 4b: compare f4 to f4_a for x2
sgf42;
sgf42_a;
assert(max(max(abs(sgf42-sgf42_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 4c: compare f4 to f4_a for x4
sgf44;
sgf44_a;
assert(max(max(abs(sgf44-sgf44_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 5a: compare f5 to f5_a for x1
sgf51;
sgf51_a;
assert(max(max(abs(sgf51-sgf51_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 5b: compare f5 to f5_a for x2
sgf52;
sgf52_a;
assert(max(max(abs(sgf52-sgf52_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );

%% Test 5c: compare f5 to f5_a for x4
sgf54;
sgf54_a;
assert(max(max(abs(sgf54-sgf54_a))) < 1e-5, 'subgradient and approximation differ more than 1e-5' );


