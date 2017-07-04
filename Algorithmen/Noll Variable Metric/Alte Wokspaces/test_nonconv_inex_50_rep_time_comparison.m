% test script nonconvex inexact bundle method

% all specifications same as in paper apart from stepsize

% starting values
x0 = ones(50,1)./(1:50)'.^2;
% relative stopping condition
tol = 1e-6;

% %% hare algorithm
% f_h = zeros(50,2,50);
% t_h = zeros(50,2,50);
% k_h = zeros(50,2,50);
% 
% for i = 1:15 % x-dimension
%     for n = 0:1 % form of noise
%         for t = 1:50 % do 50 times
%             [f_h(i,n+1,t),~,t_h(i,n+1,t),k_h(i,n+1,t)] = bundle_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,n,250*i,tol);
%             [f_h(i,n+1,t),~,t_h(i,n+1,t),k_h(i,n+1,t)] = bundle_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,n,250*i,tol);
%             [f_h(i,n+1,t),~,t_h(i,n+1,t),k_h(i,n+1,t)] = bundle_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,n,250*i,tol);
%             [f_h(i,n+1,t),~,t_h(i,n+1,t),k_h(i,n+1,t)] = bundle_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,n,250*i,tol);
%             [f_h(i,n+1,t),~,t_h(i,n+1,t),k_h(i,n+1,t)] = bundle_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,n,250*i,tol);
%         end
%     end
% end
% 
% for i = [20,25,30,35,40,50] % x-dimension
%     for n = 0:1 % form of noise
%         for t = 1:50 % do 50 times
%             [f_h(i,n+1,t),~,t_h(i,n+1),k_h(i,n+1)] = bundle_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,n,250*i,tol);
%             [f_h(i,n+1,t),~,t_h(i,n+1),k_h(i,n+1)] = bundle_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,n,250*i,tol);
%             [f_h(i,n+1,t),~,t_h(i,n+1),k_h(i,n+1)] = bundle_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,n,250*i,tol);
%             [f_h(i,n+1,t),~,t_h(i,n+1),k_h(i,n+1)] = bundle_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,n,250*i,tol);
%             [f_h(i,n+1,t),~,t_h(i,n+1),k_h(i,n+1)] = bundle_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,n,250*i,tol);
%         end
%     end
% end
% 
% %% function value
% % no noise
% log_f_h60_s = abs(log10(f_h(1:15,1,1)));
% log_f_h60_b = abs(log10(f_h([20,25,30,35,40,50],1,1)));
% 
% % constant noise
% log_f_h61_s = abs(log10(sum(f_h(1:15,2,:),4)/50));
% log_f_h61_b = abs(log10(sum(f_h([20,25,30,35,40,50],2,:),4)/50));
% 
% %% time
% % no noise
% t_h60_s = sum(t_h(1:15,1,:),3)/50;
% t_h60_b = sum(t_h([20,25,30,35,40,50],1,:),3)/50;
% 
% % constant noise
% t_h61_s = sum(t_h(1:15,2,:),3)/50;
% t_h61_b = sum(t_h([20,25,30,35,40,50],2,:),3)/50;
% 
% %% iterations
% % no noise
% k_h60_s = k_h(1:15,1,1);
% k_h60_b = k_h([20,25,30,35,40,50],1,1);
% 
% % constant noise
% k_h61_s = ceil(sum(k_h(1:15,2,:),3)/50);
% k_h61_b = ceil(sum(k_h([20,25,30,35,40,50],2,:),3)/50);


%% noll algorithm
f_n = zeros(50,2,2,50);
t_n = zeros(50,2,2,50);
k_n = zeros(50,2,2,50);

for i = 1:15 % x-dimension
    for q = 1:2 % form o fQ
        for n = 0:1 % form of noise
            for t = 1:50 % do 50 times
                [f_n(i,q,n+1,t),~,t_n(i,q,n+1,t),k_n(i,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,q,n,250*i,tol);
                [f_n(i,q,n+1,t),~,t_n(i,q,n+1,t),k_n(i,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,q,n,250*i,tol);
                [f_n(i,q,n+1,t),~,t_n(i,q,n+1,t),k_n(i,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,q,n,250*i,tol);
                [f_n(i,q,n+1,t),~,t_n(i,q,n+1,t),k_n(i,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,q,n,250*i,tol);
                [f_n(i,q,n+1,t),~,t_n(i,q,n+1,t),k_n(i,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,q,n,250*i,tol);
            end
        end
    end
end

for i = [20,25,30,35,40,50] % x-dimension
    for q = 1:2 % form o fQ
        for n = 0:1 % form of noise
            for t = 1:50 % do 50 times
                [f_n(i,q,n+1,t),~,t_n(i,q,n+1,t),k_n(i,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,q,n,250*i,tol);
                [f_n(i,q,n+1,t),~,t_n(i,q,n+1,t),k_n(i,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,q,n,250*i,tol);
                [f_n(i,q,n+1,t),~,t_n(i,q,n+1,t),k_n(i,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,q,n,250*i,tol);
                [f_n(i,q,n+1,t),~,t_n(i,q,n+1,t),k_n(i,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,q,n,250*i,tol);
                [f_n(i,q,n+1,t),~,t_n(i,q,n+1,t),k_n(i,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,q,n,250*i,tol);
            end
        end
    end
end

%% BFGS
%% function value
% no noise
log_fv_nb60_s = abs(log10(f_n(1:15,1,1,1)));
log_fv_nb60_b = abs(log10(f_n([20,25,30,35,40,50],1,1,1)));

% constant noise
log_fv_nb61_s = abs(log10(sum(f_n(1:15,1,2,:),4)/50));
log_fv_nb61_b = abs(log10(sum(f_n([20,25,30,35,40,50],1,2,:),4)/50));

%% time
% no noise
tv_nb60_s = sum(t_n(1:15,1,1,:),4)/50;
tv_nb60_b = sum(t_n([20,25,30,35,40,50],1,1,:),4)/50;

% constant noise
tv_nb61_s = sum(t_n(1:15,1,2,:),4)/50;
tv_nb61_b = sum(t_n([20,25,30,35,40,50],1,2,:),4)/50;

%% iterations
% no noise
kv_nb60_s = k_n(1:15,1,1,1);
kv_nb60_b = k_n([20,25,30,35,40,50],1,1,1);

% constant noise
kv_nb61_s = ceil(sum(k_n(1:15,1,2,:),4)/50);
kv_nb61_b = ceil(sum(k_n([20,25,30,35,40,50],1,2,:),4)/50);

%% SR1
%% function value
% no noise
log_fv_ns60_s = abs(log10(f_n(1:15,2,1,1)));
log_fv_ns60_b = abs(log10(f_n([20,25,30,35,40,50],2,1,1)));

% constant noise
log_fv_ns61_s = abs(log10(sum(f_n(1:15,2,2,:),4)/50));
log_fv_ns61_b = abs(log10(sum(f_n([20,25,30,35,40,50],2,2,:),4)/50));

%% time
% no noise
tv_ns60_s = sum(t_n(1:15,2,1,:),3)/50;
tv_ns60_b = sum(t_n([20,25,30,35,40,50],2,1,:),3)/50;

% constant noise
tv_ns61_s = sum(t_n(1:15,2,2,:),3)/50;
tv_ns61_b = sum(t_n([20,25,30,35,40,50],2,2,:),3)/50;

%% iterations
% no noise
kv_ns60_s = k_n(1:15,2,1,1);
kv_ns60_b = k_n([20,25,30,35,40,50],2,1,1);

% constant noise
kv_ns61_s = ceil(sum(k_n(1:15,2,2,:),3)/50);
kv_ns61_b = ceil(sum(k_n([20,25,30,35,40,50],2,2,:),3)/50);


