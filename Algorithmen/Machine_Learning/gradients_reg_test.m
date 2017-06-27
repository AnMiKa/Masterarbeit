% script for gradient testing for regression algorithm

[X,Y] = precond_data('Data/ready_to_use/pima_standard_pm1.mat',1,1:768,1);
[feat, n] = size(X);
Ceps = 20*rand(2,1)-10;

%% Test 1: df/d(C,eps) for hinge loss for w
eps = 1e-6;
dfdl_num = zeros(2,1);
W11 = solve_ll_reg_moore_qp(X,Y,Ceps+eps*[1;0]);
W21 = solve_ll_reg_moore_qp(X,Y,Ceps-eps*[1;0]);
W12 = solve_ll_reg_moore_qp(X,Y,Ceps+eps*[0;1]);
W22 = solve_ll_reg_moore_qp(X,Y,Ceps-eps*[0;1]);
W = solve_ll_reg_moore_qp(X,Y,Ceps);
dfdl_num(1) = 1/(2*eps)*(ul_obj_reg_moore(X,Y,W11)-ul_obj_reg_moore(X,Y,W21));
dfdl_num(2) = 1/(2*eps)*(ul_obj_reg_moore(X,Y,W12)-ul_obj_reg_moore(X,Y,W22));
Dw = subgr_ll_reg_moore(W,X,Y,Ceps);
dfdl_fun = subgr_ul_reg_moore(W,X,Y,Dw);
abs(dfdl_num-dfdl_fun)
assert(sum(abs(dfdl_num-dfdl_fun)<1e-6) == 2,'df/dlambda for hingequad loss gives bigger variation than 10^-6 in %d variable(s)',sum(abs(dfdl_num-dfdl_fun)<1e-6)) 

% %% Test 2: df/dw - runs
% eps = 1e-7;
% W = rand(feat,1);
% b = rand(1);
% dfdwb_num = zeros(feat+1,1);
% I = eye(feat);
% for i = 1:feat
%     dfdwb_num(i) = 1/(2*eps)*(ul_obj_class_hinge(X,Y,W+I(:,i)*eps,b)-ul_obj_class_hinge(X,Y,W-I(:,i)*eps,b));
% end
% dfdwb_num(feat+1) = 1/(2*eps)*(ul_obj_class_hinge(X,Y,W,b+eps)-ul_obj_class_hinge(X,Y,W,b-eps));
% dfdwb_fun = subgr_ul_class_hinge_wb(X,Y,W,b);
% sum(abs(dfdwb_num-dfdwb_fun)>1e-6)
% assert(sum(abs(dfdwb_num-dfdwb_fun)>1e-6)==0,'df/dw gives bigger variation than 10^-6 in %d components.\n',sum(abs(dfdwb_num-dfdwb_fun)>1e-6)); 
% 
% %% Test 3b:  dwb/dlambda for hinge loss for w, b
% eps = 1e-10;
% Wb1 = solve_ll_class_hinge_qpas(X,Y,lambda+eps);
% Wb2 = solve_ll_class_hinge_qpas(X,Y,lambda-eps);
% Wb = solve_ll_class_hinge_qpas(X,Y,lambda);
% W = Wb(1:feat);
% b = Wb(feat+1);
% dwbdl_num = 1/(2*eps)*(Wb1-Wb2);
% dwbdl_fun = subgr_ll_class_hinge(W,lambda);
% abs(dwbdl_num-dwbdl_fun')
% assert(sum(abs(dwbdl_num-dwbdl_fun')>1e-6)==0,'dwb/dlambda for hingequad loss gives bigger variation than 10^-6 in %d components. \n',sum(abs(dwbdl_num-dwbdl_fun')>1e-6)==0) 
