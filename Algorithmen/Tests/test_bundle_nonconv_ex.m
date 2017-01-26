% Test for the performance of the bundle_nonconv_ex algorithm
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
kmax = 1000;
m = 0.5;
t = 2;
tol = 1e-6;

% run the algorithm with different specifications several times to use the
% results in different tests

% check if results are within the tolerance
Res = zeros(5,length(X0_1));

% see how negative e gets
e_howneg_table = zeros(5,length(X0_1));

% check that c does not get negative
c_neg_table = zeros(5,length(X0_1));

% see how big eta gets (does it stay bounded?)
eta_howbig_table = zeros(5,length(X0_1));

% show number of steps for the algorithm
k_table = zeros(5,length(X0_1));

% check if components of alpha >= 0
a_nonneg_table = zeros(5,length(X0_1));

% check if components of alpha sum up to 1
a_equ1_table = zeros(5,length(X0_1));

% check how big the smallest alpha component is
a_small_table = zeros(5,length(X0_1));

% check if S approximately equal to -1/t * d
s_eq_d_table = zeros(5,length(X0_1));

% check how big the difference between the two formulations of delta is
deltas_noneq_table = zeros(5,length(X0_1));

% check if xi has the expected value (equals the other 2 formulations)
xi_exp1_table = zeros(5,length(X0_1));
xi_exp2_table = zeros(5,length(X0_1));
xi_exp3_table = zeros(5,length(X0_1));

% check if different formulations of C almost equal
C_exp_table = zeros(5,length(X0_1));

for i = 1:length(X0_1)
       [f,~, deltas_neq, xi1exp, xi2exp, xi3exp, Cexp, anneg, aequ1, asmall, cneg, ehneg, etabig, k, sd] = ...
           bundle_nonconv_ex_test(X0_1(i),fun,subgr_fun);
       Res(1,i) = f;
       e_howneg_table(1,i) = ehneg;
       eta_howbig_table(1,i) = etabig;
       a_nonneg_table(1,i) = anneg;
       a_equ1_table(1,i) = aequ1;
       a_small_table(1,i) = asmall;
       k_table(1,i) = k;
       s_eq_d_table(1,i) = sd;
       deltas_noneq_table(1,i) = deltas_neq;
       xi_exp1_table(1,i) = xi1exp;
       xi_exp2_table(1,i) = xi2exp;
       xi_exp3_table(1,i) = xi3exp;
       C_exp_table(1,i) = Cexp;
       c_neg_table(1,i) = cneg;
       
       [f,~, deltas_neq, xi1exp, xi2exp, xi3exp, Cexp, anneg, aequ1, asmall, cneg, ehneg, etabig, k, sd] = ...
           bundle_nonconv_ex_test(X0_2(:,i),fun,subgr_fun); 
       Res(2,i) = f;
       e_howneg_table(2,i) = ehneg;
       eta_howbig_table(2,i) = etabig;
       a_nonneg_table(2,i) = anneg;
       a_equ1_table(2,i) = aequ1;
       a_small_table(2,i) = asmall;
       k_table(2,i) = k;
       s_eq_d_table(2,i) = sd;
       deltas_noneq_table(2,i) = deltas_neq;
       xi_exp1_table(2,i) = xi1exp;
       xi_exp2_table(2,i) = xi2exp;
       xi_exp3_table(2,i) = xi3exp;
       C_exp_table(2,i) = Cexp;
       c_neg_table(2,i) = cneg;
       
       [f,~, deltas_neq, xi1exp, xi2exp, xi3exp, Cexp, anneg, aequ1, asmall, cneg, ehneg, etabig, k, sd] = ...
           bundle_nonconv_ex_test(X0_4(:,i),fun,subgr_fun);
       Res(3,i) = f;
       e_howneg_table(3,i) = ehneg;
       eta_howbig_table(3,i) = etabig;
       a_nonneg_table(3,i) = anneg;
       a_equ1_table(3,i) = aequ1;
       a_small_table(3,i) = asmall;
       k_table(3,i) = k;
       s_eq_d_table(3,i) = sd;
       deltas_noneq_table(3,i) = deltas_neq;
       xi_exp1_table(3,i) = xi1exp;
       xi_exp2_table(3,i) = xi2exp;       
       xi_exp3_table(3,i) = xi3exp;
       C_exp_table(3,i) = Cexp;
       c_neg_table(3,i) = cneg;
       
       [f,~, deltas_neq, xi1exp, xi2exp, xi3exp, Cexp, anneg, aequ1, asmall, cneg, ehneg, etabig, k, sd] = ...
           bundle_nonconv_ex_test(X0_8(:,i),fun,subgr_fun);
       Res(4,i) = f;
       e_howneg_table(4,i) = ehneg;
       eta_howbig_table(4,i) = etabig;
       a_nonneg_table(4,i) = anneg;
       a_equ1_table(4,i) = aequ1;
       a_small_table(4,i) = asmall;
       k_table(4,i) = k;
       s_eq_d_table(4,i) = sd;
       deltas_noneq_table(4,i) = deltas_neq;
       xi_exp1_table(4,i) = xi1exp;
       xi_exp2_table(4,i) = xi2exp;
       xi_exp3_table(4,i) = xi3exp;
       C_exp_table(4,i) = Cexp;
       c_neg_table(4,i) = cneg;
       
       [f, ~, deltas_neq, xi1exp, xi2exp, xi3exp, Cexp, anneg, aequ1, asmall, cneg, ehneg, etabig, k, sd] = ...
           bundle_nonconv_ex_test(X0_16(:,i),fun,subgr_fun);
       Res(5,i) = f;
       e_howneg_table(5,i) = ehneg;
       eta_howbig_table(5,i) = etabig;
       a_nonneg_table(5,i) = anneg;
       a_equ1_table(5,i) = aequ1;
       a_small_table(5,i) = asmall;
       k_table(5,i) = k;
       s_eq_d_table(5,i) = sd;
       deltas_noneq_table(5,i) = deltas_neq;
       xi_exp1_table(5,i) = xi1exp;
       xi_exp2_table(5,i) = xi2exp;
       xi_exp3_table(5,i) = xi3exp;
       C_exp_table(5,i) = Cexp;
       c_neg_table(5,i) = cneg;
end

%% Test 1: check if minimization results are within the tolerance
Res
assert(max(max(abs(Res))) < tol,'Algorithm does not solve to the asked tolerance')

%% Test 2: show how many steps each algorithm needs
k_table

%% Test 3: check how negative e gets
e_howneg_table;
assert(max(max(abs(e_howneg_table))) < 1e-6, 'e gets more negative than -1e-6')
%ok

%% Test 4: see how big the difference betweeen the two formulations of delta is
deltas_noneq_table
assert(max(max(deltas_noneq_table)) < 1e-10, 'biggest difference between deltas is more than 1e-10')

%% Test 5: check that c is never < 0
assert(max(max(c_neg_table)) == 0, 'c is smaller than 0')
% ok

%% Test 6: check that components of alpha are always >= 0
a_nonneg_table;
assert(max(max(a_nonneg_table)) == 0, 'components of alpha < 0')
% ok

%% Test 7: check that alpha sums up to 1
a_equ1_table
assert(max(max(a_equ1_table)) < 1e-5, 'components of alpha differ more than 1e-5 form 1')
% ok

%% Test 8: Check how small smallest alphacomponent is
a_small_table;
%ok

%% Test 9a: see how big the difference between the two xi-formulations is
xi_exp1_table
assert(max(max(xi_exp1_table)) < 1e-10, 'different formulations of xi differ more than 1e-10')

%% Test 9b: see how big the difference between the two xi-formulations is
xi_exp2_table
assert(max(max(xi_exp2_table)) < 1e-10, 'different formulations of xi differ more than 1e-10')

%% Test 9c: see how big the difference between the two xi-formulations is
xi_exp3_table
assert(max(max(xi_exp3_table)) < 1e-10, 'different formulations of xi differ more than 1e-10')

%% Test 10: Check if S and -1/t * d are almost equal
s_eq_d_table
assert(max(max(s_eq_d_table)) < 1e-15, 'norm(S+1/t*d) > 1e-15')

%% Test 11: Check if C-formulations almost equal
C_exp_table;
assert(max(max(C_exp_table)) < 1e-15, 'different formulations of C differ more than 1e-10')
% ok

% limits of asserts are best possible for optimization of