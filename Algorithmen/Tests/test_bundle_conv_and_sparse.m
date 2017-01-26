% Test for the performance of the bundle_conv and the bundle_conv_sparse
% algorithm
% set up matrices consisting of each five random vectors of length 1, 2, 4,
% 8, 16 with values between -10 and 10 as starting values
X0_1  = 20 * rand(1,5) - 10;
X0_2  = 20 * rand(2,5) - 10;
X0_4  = 20 * rand(4,5) - 10;
X0_8  = 20 * rand(8,5) - 10;
X0_16 = 20 * rand(16,5) - 10;

% tests are optimizing the 2-norm
%fun = @norm;
%subgr_fun = @subgr_two_norm;

% tests are optimizing for the 1-norm
fun = @one_norm;
subgr_fun = @sign;

% constants
e_change = 1;
e_no_change = 0;
kmax = 1000;
m = 0.5;
t = 2;
tol = 1e-6;

% run the algorithm with different specifications several times to use the
% results in different tests

% compare the results between normal and sparse algorithm
Res_nc = zeros(5,length(X0_1));
Res_c = zeros(5,length(X0_1));
Res_sparse = zeros(5,length(X0_1));

% see if e gets "very" negative
e_veryneg_nc_table = zeros(5,length(X0_1));
e_veryneg_c_table = zeros(5,length(X0_1));

% see if e has to be changed often ( = e often negative?)
e_changed_table = zeros(5,length(X0_1));

% show number of steps for the algorithm
k_nc_table = zeros(5,length(X0_1));
k_c_table = zeros(5,length(X0_1));
k_sparse_table = zeros(5,length(X0_1));

% check if components of alpha >= 0
a_nonneg_nc_table = zeros(5,length(X0_1));
a_nonneg_c_table = zeros(5,length(X0_1));

% check if components of alpha sum up to 1
a_equ1_nc_table = zeros(5,length(X0_1));
a_equ1_c_table = zeros(5,length(X0_1));

% check how big the smallest alpha component is
a_small_nc_table = zeros(5,length(X0_1));
a_small_c_table = zeros(5,length(X0_1));

% check how big the biggest alpha component is in last iteration
a_big_nc_table = zeros(5,length(X0_1));
a_big_c_table = zeros(5,length(X0_1));

% check if G approximately equal to d
g_eq_d_nc_table = zeros(5,length(X0_1));
g_eq_d_c_table = zeros(5,length(X0_1));

% check if xi has the expected value (equals the other 2 formulations)
xi_exp1_table = zeros(5,length(X0_1));
xi_exp2_table = zeros(5,length(X0_1));
xi_exp3_table = zeros(5,length(X0_1));

% test normal algorithm without changed e
%tic
for i = 1:length(X0_1)
       [f,~,anneg, aequ1, asmall, abig, evneg, ~, k, gd, xi1exp, xi2exp, xi3exp] = bundle_conv_test(X0_1(i),fun,subgr_fun,e_no_change);
       Res_nc(1,i) = f;
       e_veryneg_nc_table(1,i) = evneg;
       a_nonneg_nc_table(1,i) = anneg;
       a_equ1_nc_table(1,i) = aequ1;
       a_small_nc_table(1,i) = asmall;
       a_big_nc_table(1,i) = abig;
       k_nc_table(1,i) = k;
       g_eq_d_nc_table(1,i) = gd;
       xi_exp1_table(1,i) = xi1exp;
       xi_exp2_table(1,i) = xi2exp;
       xi_exp3_table(1,i) = xi3exp;
       
       [f,~,anneg, aequ1, asmall, abig, evneg, ~, k, gd, xi1exp, xi2exp, xi3exp] = bundle_conv_test(X0_2(:,i),fun,subgr_fun,e_no_change); 
       Res_nc(2,i) = f;
       e_veryneg_nc_table(2,i) = evneg;
       a_nonneg_nc_table(2,i) = anneg;
       a_equ1_nc_table(2,i) = aequ1;
       a_small_nc_table(2,i) = asmall;
       a_big_nc_table(2,i) = abig;
       k_nc_table(2,i) = k;
       g_eq_d_nc_table(2,i) = gd;
       xi_exp1_table(2,i) = xi1exp;
       xi_exp2_table(2,i) = xi2exp;
       xi_exp3_table(2,i) = xi3exp;
       
       [f,~,anneg, aequ1, asmall, abig, evneg, ~, k, gd, xi1exp, xi2exp, xi3exp] = bundle_conv_test(X0_4(:,i),fun,subgr_fun,e_no_change);
       Res_nc(3,i) = f;
       e_veryneg_nc_table(3,i) = evneg;
       a_nonneg_nc_table(3,i) = anneg;
       a_equ1_nc_table(3,i) = aequ1;
       a_small_nc_table(3,i) = asmall;
       a_big_nc_table(3,i) = abig;
       k_nc_table(3,i) = k;
       g_eq_d_nc_table(3,i) = gd;
       xi_exp1_table(3,i) = xi1exp;
       xi_exp2_table(3,i) = xi2exp;
       xi_exp3_table(3,i) = xi3exp;
       
       [f,~,anneg, aequ1, asmall, abig, evneg, ~, k, gd, xi1exp, xi2exp, xi3exp] = bundle_conv_test(X0_8(:,i),fun,subgr_fun,e_no_change);
       Res_nc(4,i) = f;
       e_veryneg_nc_table(4,i) = evneg;
       a_nonneg_nc_table(4,i) = anneg;
       a_equ1_nc_table(4,i) = aequ1;
       a_small_nc_table(4,i) = asmall;
       a_big_nc_table(4,i) = abig;
       k_nc_table(4,i) = k;
       g_eq_d_nc_table(4,i) = gd;
       xi_exp1_table(4,i) = xi1exp;
       xi_exp2_table(4,i) = xi2exp;
       xi_exp3_table(4,i) = xi3exp;

       [f,x,anneg, aequ1, asmall, abig, evneg, ec, k, gd, xi1exp, xi2exp, xi3exp] = bundle_conv_test(X0_16(:,i),fun,subgr_fun,e_no_change);
       Res_nc(5,i) = f;
       e_veryneg_nc_table(5,i) = evneg;
       a_nonneg_nc_table(5,i) = anneg;
       a_equ1_nc_table(5,i) = aequ1;
       a_small_nc_table(5,i) = asmall;
       a_big_nc_table(5,i) = abig;
       k_nc_table(5,i) = k;
       g_eq_d_nc_table(5,i) = gd;
       xi_exp1_table(5,i) = xi1exp;
       xi_exp2_table(5,i) = xi2exp;
       xi_exp3_table(5,i) = xi3exp;       
end
%disp and time doesn't work, don't know why
%disp('Time for normal algorithm: ')

% test normal algorithm with changed e
for i = 1:length(X0_1)
       [f,~,anneg, aequ1, asmall, abig, evneg, ec, k, gd] = bundle_conv_test(X0_1(i),fun,subgr_fun,e_change);
       Res_c(1,i) = f;
       e_veryneg_c_table(1,i) = evneg;
       e_changed_table(1,i) = ec;
       a_nonneg_c_table(1,i) = anneg;
       a_equ1_c_table(1,i) = aequ1;
       a_small_c_table(1,i) = asmall;
       a_big_c_table(1,i) = abig;
       k_c_table(1,i) = k;
       g_eq_d_c_table(1,i) = gd;
       
       [f,~,anneg, aequ1, asmall, abig, evneg, ec, k, gd] = bundle_conv_test(X0_2(:,i),fun,subgr_fun,e_change); 
       Res_c(2,i) = f;
       e_veryneg_c_table(2,i) = evneg;
       e_changed_table(2,i) = ec;
       a_nonneg_c_table(2,i) = anneg;
       a_equ1_c_table(2,i) = aequ1;
       a_small_c_table(2,i) = asmall;
       a_big_c_table(2,i) = abig;
       k_c_table(2,i) = k;
       g_eq_d_c_table(2,i) = gd;

       [f,~,anneg, aequ1, asmall, abig, evneg, ec, k, gd] = bundle_conv_test(X0_4(:,i),fun,subgr_fun,e_change);
       Res_c(3,i) = f;
       e_veryneg_c_table(3,i) = evneg;
       e_changed_table(3,i) = ec;
       a_nonneg_c_table(3,i) = anneg;
       a_equ1_c_table(3,i) = aequ1;
       a_small_c_table(3,i) = asmall;
       a_big_c_table(3,i) = abig;
       k_c_table(3,i) = k;
       g_eq_d_c_table(3,i) = gd;

     
       [f,~,anneg, aequ1, asmall, abig, evneg, ec, k, gd] = bundle_conv_test(X0_8(:,i),fun,subgr_fun,e_change);
       Res_c(4,i) = f;
       e_veryneg_c_table(4,i) = evneg;
       e_changed_table(4,i) = ec;
       a_nonneg_c_table(4,i) = anneg;
       a_equ1_c_table(4,i) = aequ1;
       a_small_c_table(4,i) = asmall;
       a_big_c_table(4,i) = abig;
       k_c_table(4,i) = k;
       g_eq_d_c_table(4,i) = gd;
              
       [f,x,anneg, aequ1, asmall, abig, evneg, ec, k, gd] = bundle_conv_test(X0_16(:,i),fun,subgr_fun,e_change);
       Res_c(5,i) = f;
       e_veryneg_c_table(5,i) = evneg;
       e_changed_table(5,i) = ec;
       a_nonneg_c_table(5,i) = anneg;
       a_equ1_c_table(5,i) = aequ1;
       a_small_c_table(5,i) = asmall;
       a_big_c_table(5,i) = abig;
       k_c_table(5,i) = k;
       g_eq_d_c_table(5,i) = gd;

end

% test sparse algorithm without changed e
for i = 1:length(X0_1)
       [f,~,~,~,~,~,~,k] = bundle_conv_test(X0_1(i),fun,subgr_fun,e_no_change);
       Res_sparse(1,i) = f;
       k_sparse_table(1,i) = k;
       
       [f,~,~,~,~,~,~,k] = bundle_conv_test(X0_2(:,i),fun,subgr_fun,e_no_change); 
       Res_sparse(2,i) = f;
       k_sparse_table(2,i) = k;
       
       [f,~,~,~,~,~,~,k] = bundle_conv_test(X0_4(:,i),fun,subgr_fun,e_no_change);
       Res_sparse(3,i) = f;
       k_sparse_table(3,i) = k;
     
       [f,~,~,~,~,~,~,k] = bundle_conv_test(X0_8(:,i),fun,subgr_fun,e_no_change);
       Res_sparse(4,i) = f;
       k_sparse_table(4,i) = k;

       [f,~,~,~,~,~,~,k] = bundle_conv_test(X0_16(:,i),fun,subgr_fun,e_no_change);
       Res_sparse(5,i) = f;
       k_sparse_table(5,i) = k;
end

%% Test 1a: check minimization results and compare normal and sparse
% tol-test
% for a non-bijective function it could be tested if the found argmins are
% the same
assert(max(max(abs(Res_nc))) < tol,'Normal algorithm without changed e does not solve to the asked tolerance')

%% Test 1b: tol-test, e changed
assert(max(max(abs(Res_c))) < tol,'Normal algorithm with changed e does not solve to the asked tolerance')
% ok

%% Test 1c: test if sparse and nonsparse are doing the same thing
assert(max(max(abs(Res_nc - Res_sparse))) == 0, 'Sparse and nonsparse algorihtm do not do the same things')
% if this test passes, rest only has to be tested on one algorithm
%assert(max(max(abs(Res_sparse))) < tol, 'Sparse algorithm does not solve to the asked tolerance')
diff_res_non_sparse = Res_nc - Res_sparse;
diff_steps_non_sparse = k_nc_table - k_sparse_table;
%ok

%% Test 2a: check if e gets "too negative" when not changed
e_veryneg_nc_table;
assert(max(max(abs(e_veryneg_nc_table))) < tol * 1e-7,'e < -tol * 1e-7 in normal algortihm, change e')
% ok

%% Test 2b: check if e gets "too negative" when changed
e_veryneg_c_table;
assert(max(max(abs(e_veryneg_c_table))) < tol * 1e-7,'e < -tol * 1e-7 in normal algortihm, change e')
% ok

%% Test 3: check how often e has to be changed
e_changed_table
k_c_table;
rel_e_change = e_changed_table./k_c_table
% ok

%% Test 4: check if k differs if e is changed
diff_k_nc_c = k_nc_table - k_c_table
%assert(max(max(abs(k_nc_table - k_c_table))) < kmax * 0.3,...
%    'iteration number between e changed and not changed differs more than 30% of the max iterations')
% ok    

%% Test 5: check that components of alpha always >= 0
a_nonneg_nc_table;
a_nonneg_c_table;
assert(max(max(a_nonneg_nc_table)) == 0, 'components of alpha < 0, no change')
assert(max(max(a_nonneg_c_table)) == 0, 'components of alpha < 0, change')
%ok

%% Test 6: check that alpha sums up to 1
a_equ1_nc_table
a_equ1_c_table
assert(max(max(a_equ1_nc_table)) < 1e-6, 'components of alpha differ more than 1e-6 form 1 , no change')
assert(max(max(a_equ1_c_table)) < 1e-6, 'components of alpha differ more than 1e-6 form 1, change')
%ok

%% Test 7: Check how small smalles alphacomponent is, no change
a = min(sum(a_small_nc_table,2)./5);
b= max(sum(a_small_nc_table,2)./5);
a_small_nc_table
assert(min(sum(a_small_nc_table,2)./5) < 1e-9, 'min of average > 1e-10, no change')
assert(max(sum(a_small_nc_table,2)./5) < 1, 'max of average > 1e0, no change')
%ok

%% Test 7: Check how small smallest alphacomponent is, change
a_small_c_table
assert(min(sum(a_small_c_table,2)./5) < 1e-9, 'min of average > 1e-10, change')
assert(max(sum(a_small_c_table,2)./5) < 1, 'max of average > 1e0, change')
%ok

%% Test 8: Check how big biggest alpha component is in last iteration
a_big_nc_table;
a_big_c_table;

%% Test 9: Check if G and d are almost equal
g_eq_d_nc_table
g_eq_d_c_table
assert(max(max(g_eq_d_nc_table)) < 1e-15, 'norm(G+d) > 1e-15, no change')
assert(max(max(g_eq_d_c_table)) < 1e-15, 'norm(G+d) > 1e-15, change')

%% Test 10a: see how big the difference between the two xi-formulations is
xi_exp1_table
assert(max(max(xi_exp1_table)) < 1e-10, 'different formulations of xi differ more than 1e-10')

%% Test 10b: see how big the difference between the two xi-formulations is
xi_exp2_table
assert(max(max(xi_exp2_table)) < 1e-10, 'different formulations of xi differ more than 1e-10')

%% Test 10c: see how big the difference between the two xi-formulations is
xi_exp3_table
assert(max(max(xi_exp3_table)) < 1e-10, 'different formulations of xi differ more than 1e-10')

% limits of asserts are best possible for optimization of the 1-norm