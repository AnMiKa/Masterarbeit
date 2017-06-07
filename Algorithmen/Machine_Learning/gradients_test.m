% script for gradient testing

[X,Y] = precond_data('Data/Kunapuli/pima_standard_pm1.mat',1,1:768,1);
[feat, n] = size(X);
lambda = 20*rand(1)-10;

%% Test 1: df/dlambda for hingequad loss for w, b - 'runs' except for ionosphere (10^-3)
eps = 1e-7;
Wb1 = solve_ll_class_hingequad_qpas(X,Y,lambda+eps);
Wb2 = solve_ll_class_hingequad_qpas(X,Y,lambda-eps);
Wb = solve_ll_class_hingequad_qpas(X,Y,lambda);
W = Wb(1:feat);
b = Wb(feat+1);
W1 = Wb1(1:feat);
b1 = Wb1(feat+1);
W2 = Wb2(1:feat);
b2 = Wb2(feat+1);
% leaving out the scaling gives a lot better results
dfdl_num = 1/(200*eps)*(ul_obj_class_hinge(X,Y,W1,b1)-ul_obj_class_hinge(X,Y,W2,b2));
Dwb = subgr_ll_class_hingequad(W,b,X,Y,lambda);
dfdl_fun = 1/100*subgr_ul_class_hinge(W,b,X,Y,Dwb);
abs(dfdl_num-dfdl_fun)
assert(abs(dfdl_num-dfdl_fun)<1e-4,'df/dlambda for hingequad loss gives bigger variation than 10^-4') 

%% Test 2: df/dw - runs
eps = 1e-7; 
W = rand(feat,1);
b = rand(1);
dfdwb_num = zeros(feat+1,1);
I = eye(feat);
for i = 1:feat
    dfdwb_num(i) = 1/(2*eps)*(ul_obj_class_hinge(X,Y,W+I(:,i)*eps,b)-ul_obj_class_hinge(X,Y,W-I(:,i)*eps,b));
end
dfdwb_num(feat+1) = 1/(2*eps)*(ul_obj_class_hinge(X,Y,W,b+eps)-ul_obj_class_hinge(X,Y,W,b-eps));
dfdwb_fun = subgr_ul_class_hinge_wb(X,Y,W,b);

assert(sum(abs(dfdwb_num-dfdwb_fun)>1e-6)==0,'df/dw gives bigger variation than 10^-6 in %d components.\n',sum(abs(dfdwb_num-dfdwb_fun)>1e-6)); 
% now eps = 10^-8 and 10^-5 or eps = 10^-7 and 10^-6 because of scaling 

%% Test 2a: same subgradients - runs
% W = rand(feat,1);
% b = rand(1);
% dfdwb_1 = subgr_ul_class_hinge_wb(X,Y,W,b);
% dfdwb_2 = subgr_ul_class_hinge(W,b,X,Y,eye(feat+1));
% 
% assert(sum((dfdwb_1-dfdwb_2') == 0)==feat+1, 'Maximum difference between the two gradient functions is %d. \n', max(dfdwb_1-dfdwb_2'));


%% Test 3: dwb/dlambda for hingequad loss for w, b - 'runs' except for ionosphere (10^-3)
eps = 1e-8;
Wb1 = solve_ll_class_hingequad_qpas(X,Y,lambda+eps);
Wb2 = solve_ll_class_hingequad_qpas(X,Y,lambda-eps);
Wb = solve_ll_class_hingequad_qpas(X,Y,lambda);
W = Wb(1:feat);
b = Wb(feat+1);
dwbdl_num = 1/(2*eps)*(Wb1-Wb2);
dwbdl_fun = subgr_ll_class_hingequad(W,b,X,Y,lambda);
abs(dwbdl_num-dwbdl_fun')
assert(sum(abs(dwbdl_num-dwbdl_fun')>1e-3)==0,'dwb/dlambda for hingequad loss gives bigger variation than 10^-3 in %d components. \n',sum(abs(dwbdl_num-dwbdl_fun')>1e-6)==0) 