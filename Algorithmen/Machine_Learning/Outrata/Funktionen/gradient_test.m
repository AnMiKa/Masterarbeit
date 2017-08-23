% script to numerically test the programmed subgradients

% data
X = Xtcan;
Y = Ytcan;
C = linspace(0.02,0.06,1000);
%100*rand(1);

[feat,J,T,G] = size(X);

% try different eps
eps = 1e-7;

%% calculate all fun-values
[W,dfdw_fun,dfdC_fun] = solve_ll_and_subgr(C,X,Y);

%% Test 1: runs
% % test the partial derivative of the upper level objective with respect to
% % w
% 
% % dLuppdw_num = zeros(feat,1);
% I = eye(feat);
% dfdw_num = zeros(feat,1);
% for i = 1:feat
%     dfdw_num(i) = 1/(2*eps)*(ul_obj_class_hingequad(X,Y,W+I(:,i)*eps)-...
%         ul_obj_class_hingequad(X,Y,W-I(:,i)*eps));
% end
% 
% d1 = abs(dfdw_num-dfdw_fun)
% 

%% Test 2:
% subgradient of the upper level objective with solution of lower level
% inserted with respect to C

% if this test works: great, then everything is differentiable and the
% bundle algorithm is in fact not needed
% or always the right subgradient is chosen... why?
% if this does not work, try numerically calculating left and right
% gradient and check if norm of programmed subgradient lies in between

dfdC_num = zeros(1,10);
% dfdC_numu = zeros(G,1);
% dfdC_numl = zeros(G,1);
for c = 1:100:length(C)
    Wl = solve_ll_and_subgr(C(c)-eps,X,Y);
    Wu = solve_ll_and_subgr(C(c)+eps,X,Y);
    dfdC_num(1,c) = 1/(2*eps)*(ul_obj_class_hingequad(X,Y,Wu)-...
        ul_obj_class_hingequad(X,Y,Wl));
end
% I = eye(G);
% for g = 1:G
%     Wl = solve_ll_and_subgr(C(g)-I(:,g)*eps,X,Y);
%     Wu = solve_ll_and_subgr(C(g)+I(:,g)*eps,X,Y);
%     dfdC_num(g) = 1/(2*eps)*(ul_obj_class_hingequad(X,Y,Wu)-...
%         ul_obj_class_hingequad(X,Y,Wl));
%     dfdC_numu(g) = 1/(eps)*(ul_obj_class_hingequad(X,Y,Wu)-...
%         ul_obj_class_hingequad(X,Y,W));
%     dfdC_numl(g) = 1/(eps)*(ul_obj_class_hingequad(X,Y,W)-...
%         ul_obj_class_hingequad(X,Y,Wl));
% end
%dfdC_num-dfdC_numl
%dfdC_num-dfdC_numu
%dfdC_numu-dfdC_numl
% dfdC_num
% dfdC_fun
% d2 = abs(dfdC_num-dfdC_fun)
% C