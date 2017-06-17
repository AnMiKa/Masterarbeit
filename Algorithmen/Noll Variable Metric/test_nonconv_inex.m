% test script nonconvex inexact bundle method

% all specifications same as in paper apart from stepsize

% starting values
x0 = ones(30,1)./(1:30)'.^2;
% relative stopping condition
tol = [1e-3;1e-6];

%% hare algorithm
f_h = zeros(30,10,5,10);
t_h = zeros(30,10,5,10);
k_h = zeros(30,10,5,10);

for i = 1:15 % x-dimension
    for j = 1:2 % tolerance (1e-3, 1e-6)
        for n = 0:4 % form of noise
            if n > 0
                for t = 1:10 % if noise -> do 10 times
                    [f_h(i,1+(j-1)*5,n+1,t),~,t_h(i,1+(j-1)*5,n+1,t),k_h(i,1+(j-1)*5,n+1,t)] = bundle_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,n,250*i,tol(j));
                    [f_h(i,2+(j-1)*5,n+1,t),~,t_h(i,2+(j-1)*5,n+1,t),k_h(i,2+(j-1)*5,n+1,t)] = bundle_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,n,250*i,tol(j));
                    [f_h(i,3+(j-1)*5,n+1,t),~,t_h(i,3+(j-1)*5,n+1,t),k_h(i,3+(j-1)*5,n+1,t)] = bundle_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,n,250*i,tol(j));
                    [f_h(i,4+(j-1)*5,n+1,t),~,t_h(i,4+(j-1)*5,n+1,t),k_h(i,4+(j-1)*5,n+1,t)] = bundle_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,n,250*i,tol(j));
                    [f_h(i,5+(j-1)*5,n+1,t),~,t_h(i,4+(j-1)*5,n+1,t),k_h(i,4+(j-1)*5,n+1,t)] = bundle_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,n,250*i,tol(j));
                end
            else
                [f_h(i,1+(j-1)*5,n+1,1),~,t_h(i,4+(j-1)*5,n+1),k_h(i,4+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,n,250*i,tol(j));
                [f_h(i,2+(j-1)*5,n+1,1),~,t_h(i,4+(j-1)*5,n+1),k_h(i,4+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,n,250*i,tol(j));
                [f_h(i,3+(j-1)*5,n+1,1),~,t_h(i,4+(j-1)*5,n+1),k_h(i,4+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,n,250*i,tol(j));
                [f_h(i,4+(j-1)*5,n+1,1),~,t_h(i,4+(j-1)*5,n+1),k_h(i,4+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,n,250*i,tol(j));
                [f_h(i,5+(j-1)*5,n+1,1),~,t_h(i,4+(j-1)*5,n+1),k_h(i,4+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,n,250*i,tol(j)); 
            end
        end
    end
end

for i = [20,25,30] % x-dimension
    for j = 1:2 % tolerance (1e-3, 1e-6)
        for n = 0:4 % form of noise
            if n > 0
                for t = 1:10 % if noise -> do 10 times
                    [f_h(i,1+(j-1)*5,n+1,t),~,t_h(i,1+(j-1)*5,n+1),k_h(i,1+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,n,250*i,tol(j));
                    [f_h(i,2+(j-1)*5,n+1,t),~,t_h(i,2+(j-1)*5,n+1),k_h(i,2+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,n,250*i,tol(j));
                    [f_h(i,3+(j-1)*5,n+1,t),~,t_h(i,3+(j-1)*5,n+1),k_h(i,3+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,n,250*i,tol(j));
                    [f_h(i,4+(j-1)*5,n+1,t),~,t_h(i,4+(j-1)*5,n+1),k_h(i,4+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,n,250*i,tol(j));
                    [f_h(i,5+(j-1)*5,n+1,t),~,t_h(i,5+(j-1)*5,n+1),k_h(i,5+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,n,250*i,tol(j));
                end
            else
                [f_h(i,1+(j-1)*5,n+1,1),~,t_h(i,1+(j-1)*5,n+1),k_h(i,1+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,n,250*i,tol(j));
                [f_h(i,2+(j-1)*5,n+1,1),~,t_h(i,2+(j-1)*5,n+1),k_h(i,2+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,n,250*i,tol(j));
                [f_h(i,3+(j-1)*5,n+1,1),~,t_h(i,3+(j-1)*5,n+1),k_h(i,3+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,n,250*i,tol(j));
                [f_h(i,4+(j-1)*5,n+1,1),~,t_h(i,4+(j-1)*5,n+1),k_h(i,4+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,n,250*i,tol(j));
                [f_h(i,5+(j-1)*5,n+1,1),~,t_h(i,5+(j-1)*5,n+1),k_h(i,5+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,n,250*i,tol(j));
            end
        end
    end
end

% no noise
log_f_h30_s = f_h(1:15,1:5,1,1);
log_f_h30_b = abs(log10(f_h([20,25,30],1:5,1,1)));

log_f_h60_s = abs(log10(f_h(1:15,6:10,1,1)));
log_f_h60_b = abs(log10(f_h([20,25,30],6:10,1,1)));

% constant noise
log_f_h31_s = abs(log10(sum(f_h(1:15,1:5,2,:),4)/10));
log_f_h31_b = abs(log10(sum(f_h([20,25,30],1:5,2,:),4)/10));

log_f_h61_s = abs(log10(sum(f_h(1:15,6:10,2,:),4)/10));
log_f_h61_b = abs(log10(sum(f_h([20,25,30],6:10,2,:),4)/10));

% vanishing noise
log_f_h32_s = abs(log10(sum(f_h(1:15,1:5,3,:),4)/10));
log_f_h32_b = abs(log10(sum(f_h([20,25,30],1:5,3,:),4)/10));

log_f_h62_s = abs(log10(sum(f_h(1:15,6:10,3,:),4)/10));
log_f_h62_b = abs(log10(sum(f_h([20,25,30],6:10,3,:),4)/10));

% constant gradient noise
log_f_h33_s = abs(log10(sum(f_h(1:15,1:5,4,:),4)/10));
log_f_h33_b = abs(log10(sum(f_h([20,25,30],1:5,4,:),4)/10));

log_f_h63_s = abs(log10(sum(f_h(1:15,6:10,4,:),4)/10));
log_f_h63_b = abs(log10(sum(f_h([20,25,30],6:10,4,:),4)/10));

% vanishing gradient noise
log_f_h34_s = abs(log10(sum(f_h(1:15,1:5,5,:),4)/10));
log_f_h34_b = abs(log10(sum(f_h([20,25,30],1:5,5,:),4)/10));

log_f_h64_s = abs(log10(sum(f_h(1:15,6:10,5,:),4)/10));
log_f_h64_b = abs(log10(sum(f_h([20,25,30],6:10,5,:),4)/10));

% no noise
k_h30_s = k_h(1:15,1:5,1,1);
k_h30_b = k_h([20,25,30],1:5,1,1);

k_h60_s = k_h(1:15,6:10,1,1);
k_h60_b = k_h([20,25,30],6:10,1,1);

% constant noise
k_h31_s = sum(k_h(1:15,1:5,2,:),4)/10;
k_h31_b = sum(k_h([20,25,30],1:5,2,:),4)/10;

k_h61_s = sum(k_h(1:15,6:10,2,:),4)/10;
k_h61_b = sum(k_h([20,25,30],6:10,2,:),4)/10;

% vanishing noise
k_h32_s = sum(k_h(1:15,1:5,3,:),4)/10;
k_h32_b = sum(k_h([20,25,30],1:5,3,:),4)/10;

k_h62_s = sum(k_h(1:15,6:10,3,:),4)/10;
k_h62_b = sum(k_h([20,25,30],6:10,3,:),4)/10;

% constant gradient noise
k_h33_s = sum(k_h(1:15,1:5,4,:),4)/10;
k_h33_b = sum(k_h([20,25,30],1:5,4,:),4)/10;

k_h63_s = sum(k_h(1:15,6:10,4,:),4)/10;
k_h63_b = sum(k_h([20,25,30],6:10,4,:),4)/10;

% vanishing gradient noise
k_h34_s = sum(k_h(1:15,1:5,5,:),4)/10;
k_h34_b = sum(k_h([20,25,30],1:5,5,:),4)/10;

k_h64_s = sum(k_h(1:15,6:10,5,:),4)/10;
k_h64_b = sum(k_h([20,25,30],6:10,5,:),4)/10;


% %% noll algorithm
% f_n = zeros(30,10,2,5,10);
% t_n = zeros(30,10,2,5,10);
% k_n = zeros(30,10,2,5,10);
% 
% for i = 1:15 % x-dimension
%     for j = 1:2 % tolerance (1e-3, 1e-6)
%         for q = 1:2 % form o fQ
%             for n = 0:2 % form of noise
%                 if n > 0 
%                     for t = 1:10 % if noise -> do 10 times
%                         [f_n(i,1+(j-1)*5,q,n+1,t),~,t_n(i,1+(j-1)*5,q,n+1,t),k_n(i,1+(j-1)*5,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,q,n,250*i,tol(j));
%                         [f_n(i,2+(j-1)*5,q,n+1,t),~,t_n(i,2+(j-1)*5,q,n+1,t),k_n(i,2+(j-1)*5,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,q,n,250*i,tol(j));
%                         [f_n(i,3+(j-1)*5,q,n+1,t),~,t_n(i,3+(j-1)*5,q,n+1,t),k_n(i,3+(j-1)*5,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,q,n,250*i,tol(j));
%                         [f_n(i,4+(j-1)*5,q,n+1,t),~,t_n(i,4+(j-1)*5,q,n+1,t),k_n(i,4+(j-1)*5,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,q,n,250*i,tol(j));
%                         [f_n(i,5+(j-1)*5,q,n+1,t),~,t_n(i,5+(j-1)*5,q,n+1,t),k_n(i,5+(j-1)*5,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,q,n,250*i,tol(j));
%                     end
%                 else
%                     [f_n(i,1+(j-1)*5,q,n+1,1),~,t_n(i,1+(j-1)*5,q,n+1,1),k_n(i,1+(j-1)*5,q,n+1,1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,q,n,250*i,tol(j));
%                     [f_n(i,2+(j-1)*5,q,n+1,1),~,t_n(i,2+(j-1)*5,q,n+1,1),k_n(i,2+(j-1)*5,q,n+1,1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,q,n,250*i,tol(j));
%                     [f_n(i,3+(j-1)*5,q,n+1,1),~,t_n(i,3+(j-1)*5,q,n+1,1),k_n(i,3+(j-1)*5,q,n+1,1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,q,n,250*i,tol(j));
%                     [f_n(i,4+(j-1)*5,q,n+1,1),~,t_n(i,4+(j-1)*5,q,n+1,1),k_n(i,4+(j-1)*5,q,n+1,1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,q,n,250*i,tol(j));
%                     [f_n(i,5+(j-1)*5,q,n+1,1),~,t_n(i,5+(j-1)*5,q,n+1,1),k_n(i,5+(j-1)*5,q,n+1,1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,q,n,250*i,tol(j));
%                 end
%             end
%         end
%     end
% end
% 
% for i = [20,25,30] % x-dimension
%     for j = 1:2 % tolerance (1e-3, 1e-6)
%         for q = 1:2 % form o fQ
%             for n = 0:2 % form of noise
%                 if n > 0 
%                     for t = 1:10 % if noise -> do 10 times
%                         [f_n(i,1+(j-1)*5,q,n+1,t),~,t_n(i,1+(j-1)*5,q,n+1,t),k_n(i,1+(j-1)*5,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,q,n,250*i,tol(j));
%                         [f_n(i,2+(j-1)*5,q,n+1,t),~,t_n(i,2+(j-1)*5,q,n+1,t),k_n(i,2+(j-1)*5,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,q,n,250*i,tol(j));
%                         [f_n(i,3+(j-1)*5,q,n+1,t),~,t_n(i,3+(j-1)*5,q,n+1,t),k_n(i,3+(j-1)*5,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,q,n,250*i,tol(j));
%                         [f_n(i,4+(j-1)*5,q,n+1,t),~,t_n(i,4+(j-1)*5,q,n+1,t),k_n(i,4+(j-1)*5,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,q,n,250*i,tol(j));
%                         [f_n(i,5+(j-1)*5,q,n+1,t),~,t_n(i,5+(j-1)*5,q,n+1,t),k_n(i,5+(j-1)*5,q,n+1,t)] = noll_variable_metric_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,q,n,250*i,tol(j));
%                     end
%                 else
%                     [f_n(i,1+(j-1)*5,q,n+1,1),~,t_n(i,1+(j-1)*5,q,n+1,1),k_n(i,1+(j-1)*5,q,n+1,1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,q,n,250*i,tol(j));
%                     [f_n(i,2+(j-1)*5,q,n+1,1),~,t_n(i,2+(j-1)*5,q,n+1,1),k_n(i,2+(j-1)*5,q,n+1,1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,q,n,250*i,tol(j));
%                     [f_n(i,3+(j-1)*5,q,n+1,1),~,t_n(i,3+(j-1)*5,q,n+1,1),k_n(i,3+(j-1)*5,q,n+1,1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,q,n,250*i,tol(j));
%                     [f_n(i,4+(j-1)*5,q,n+1,1),~,t_n(i,4+(j-1)*5,q,n+1,1),k_n(i,4+(j-1)*5,q,n+1,1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,q,n,250*i,tol(j));
%                     [f_n(i,5+(j-1)*5,q,n+1,1),~,t_n(i,5+(j-1)*5,q,n+1,1),k_n(i,5+(j-1)*5,q,n+1,1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,q,n,250*i,tol(j)); 
%                 end
%             end
%         end
%     end
% end
% 
% %% noll scaled
% % no noise
% kQk_nb30_s = k_n(1:15,1:5,1,1,1);
% kQk_nb30_b = k_n([20,25,30],1:5,1,1,1);
% 
% kQk_nb60_s = k_n(1:15,6:10,1,1,1);
% kQk_nb60_b = k_n([20,25,30],6:10,1,1,1);
% 
% % constant noise
% kQk_nb31_s = sum(k_n(1:15,1:5,1,2,:),5)/10;
% kQk_nb31_b = sum(k_n([20,25,30],1:5,1,2,:),5)/10;
% 
% kQk_nb61_s = sum(k_n(1:15,6:10,1,2,:),5)/10;
% kQk_nb61_b = sum(k_n([20,25,30],6:10,1,2,:),5)/10;
% 
% % vanishing noise
% kQk_nb32_s = sum(k_n(1:15,1:5,1,3,:),5)/10;
% kQk_nb32_b = sum(k_n([20,25,30],1:5,1,3,:),5)/10;
% 
% kQk_nb62_s = sum(k_n(1:15,6:10,1,3,:),5)/10;
% kQk_nb62_b = sum(k_n([20,25,30],6:10,1,3,:),5)/10;
% 
% % % constant gradient noise
% % kQk_nb33_s = sum(k_n(1:15,1:5,1,4,:),5)/10;
% % kQk_nb33_b = sum(k_n([20,25,30],1:5,1,4,:),5)/10;
% % 
% % kQk_nb63_s = sum(k_n(1:15,6:10,1,4,:),5)/10;
% % kQk_nb63_b = sum(k_n([20,25,30],6:10,1,4,:),5)/10;
% % 
% % % vanishing gradient noise
% % kQk_nb34_s = sum(k_n(1:15,1:5,1,5,:),5)/10;
% % kQk_nb34_b = sum(k_n([20,25,30],1:5,1,5,:),5)/10;
% % 
% % kQk_nb64_s = sum(k_n(1:15,6:10,1,5,:),5)/10;
% % kQk_nb64_b = sum(k_n([20,25,30],6:10,1,5,:),5)/10;
% 
% % no noise
% kQk_ns30_s = k_n(1:15,1:5,2,1,1);
% kQk_ns30_b = k_n([20,25,30],1:5,2,1,1);
% 
% kQk_ns60_s = k_n(1:15,6:10,2,1,1);
% kQk_ns60_b = k_n([20,25,30],6:10,2,1,1);
% 
% % constant noise
% kQk_ns31_s = sum(k_n(1:15,1:5,2,2,:),5)/10;
% kQk_ns31_b = sum(k_n([20,25,30],1:5,2,2,:),5)/10;
% 
% kQk_ns61_s = sum(k_n(1:15,6:10,2,2,:),5)/10;
% kQk_ns61_b = sum(k_n([20,25,30],6:10,2,2,:),5)/10;
% 
% % vanishing noise
% kQk_ns32_s = sum(k_n(1:15,1:5,2,3,:),5)/10;
% kQk_ns32_b = sum(k_n([20,25,30],1:5,2,3,:),5)/10;
% 
% kQk_ns62_s = sum(k_n(1:15,6:10,2,3,:),5)/10;
% kQk_ns62_b = sum(k_n([20,25,30],6:10,2,3,:),5)/10;
% 
% % % constant gradient noise
% % kQk_ns33_s = sum(k_n(1:15,1:5,2,4,:),5)/10;
% % kQk_ns33_b = sum(k_n([20,25,30],1:5,2,4,:),5)/10;
% % 
% % kQk_ns63_s = sum(k_n(1:15,6:10,2,4,:),5)/10;
% % kQk_ns63_b = sum(k_n([20,25,30],6:10,2,4,:),5)/10;
% % 
% % % vanishing gradient noise
% % kQk_ns34_s = sum(k_n(1:15,1:5,2,5,:),5)/10;
% % kQk_ns34_b = sum(k_n([20,25,30],1:5,2,5,:),5)/10;
% % 
% % kQk_ns64_s = sum(k_n(1:15,6:10,2,5,:),5)/10;
% % kQk_ns64_b = sum(k_n([20,25,30],6:10,2,5,:),5)/10;
% 
% 
%     
% 
% % % noll with BFGS
% % % no noise
% % log_f_nb30_s = abs(log10(f_n(1:15,1:5,1,1,1)));
% % log_f_nb30_b = abs(log10(f_n([20,25,30],1:5,1,1,1)));
% % 
% % log_f_nb60_s = abs(log10(f_n(1:15,6:10,1,1,1)));
% % log_f_nb60_b = abs(log10(f_n([20,25,30],6:10,1,1,1)));
% % 
% % % constant noise
% % log_f_nb31_s = abs(log10(sum(f_n(1:15,1:5,1,2,:),5)/10));
% % log_f_nb31_b = abs(log10(sum(f_n([20,25,30],1:5,1,2,:),5)/10));
% % 
% % log_f_nb61_s = abs(log10(sum(f_n(1:15,6:10,1,2,:),5)/10));
% % log_f_nb61_b = abs(log10(sum(f_n([20,25,30],6:10,1,2,:),5)/10));
% % 
% %vanishing noise
% log_f_nb32_s = abs(log10(sum(f_n(1:15,1:5,1,3,:),5)/10));
% log_f_nb32_b = abs(log10(sum(f_n([20,25,30],1:5,1,3,:),5)/10));
% 
% log_f_nb62_s = abs(log10(sum(f_n(1:15,6:10,1,3,:),5)/10));
% log_f_nb62_b = abs(log10(sum(f_n([20,25,30],6:10,1,3,:),5)/10));
% 
% %constant gradient noise
% log_f_nb33_s = abs(log10(sum(f_n(1:15,1:5,1,4,:),5)/10));
% log_f_nb33_b = abs(log10(sum(f_n([20,25,30],1:5,1,4,:),5)/10));
% 
% log_f_nb63_s = abs(log10(sum(f_n(1:15,6:10,1,4,:),5)/10));
% log_f_nb63_b = abs(log10(sum(f_n([20,25,30],6:10,1,4,:),5)/10));
% 
% %vanishing gradient noise
% log_f_nb34_s = abs(log10(sum(f_n(1:15,1:5,1,5,:),5)/10));
% log_f_nb34_b = abs(log10(sum(f_n([20,25,30],1:5,1,5,:),5)/10));
% 
% log_f_nb64_s = abs(log10(sum(f_n(1:15,6:10,1,5,:),5)/10));
% log_f_nb64_b = abs(log10(sum(f_n([20,25,30],6:10,1,5,:),5)/10));
% 
% 
% %% noll with SR1
% %no noise
% log_f_ns30_s = abs(log10(f_n(1:15,1:5,2,1,1)));
% log_f_ns30_b = abs(log10(f_n([20,25,30],1:5,2,1,1)));
% 
% log_f_ns60_s = abs(log10(f_n(1:15,6:10,2,1,1)));
% log_f_ns60_b = abs(log10(f_n([20,25,30],6:10,2,1,1)));
% 
% %constant noise
% log_f_ns31_s = abs(log10(sum(f_n(1:15,1:5,2,2,:),5)/10));
% log_f_ns31_b = abs(log10(sum(f_n([20,25,30],1:5,2,2,:),5)/10));
% 
% log_f_ns61_s = abs(log10(sum(f_n(1:15,6:10,2,2,:),5)/10));
% log_f_ns61_b = abs(log10(sum(f_n([20,25,30],6:10,2,2,:),5)/10));
% 
% %vanishing noise
% log_f_ns32_s = abs(log10(sum(f_n(1:15,1:5,2,3,:),5)/10));
% log_f_ns32_b = abs(log10(sum(f_n([20,25,30],1:5,2,3,:),5)/10));
% 
% log_f_ns62_s = abs(log10(sum(f_n(1:15,6:10,2,3,:),5)/10));
% log_f_ns62_b = abs(log10(sum(f_n([20,25,30],6:10,2,3,:),5)/10));
% 
% %constant gradient noise
% log_f_ns33_s = abs(log10(sum(f_n(1:15,1:5,2,4,:),5)/10));
% log_f_ns33_b = abs(log10(sum(f_n([20,25,30],1:5,2,4,:),5)/10));
% 
% log_f_ns63_s = abs(log10(sum(f_n(1:15,6:10,2,4,:),5)/10));
% log_f_ns63_b = abs(log10(sum(f_n([20,25,30],6:10,2,4,:),5)/10));
% 
% %vanishing gradient noise
% log_f_ns34_s = abs(log10(sum(f_n(1:15,1:5,2,5,:),5)/10));
% log_f_ns34_b = abs(log10(sum(f_n([20,25,30],1:5,2,5,:),5)/10));
% 
% log_f_ns64_s = abs(log10(sum(f_n(1:15,6:10,2,5,:),5)/10));
% log_f_ns64_b = abs(log10(sum(f_n([20,25,30],6:10,2,5,:),5)/10));
% 
% %% times
% 
% %% Hare
% % no noise
% t_h30_s = t_h(1:15,1:5,1,1);
% t_h30_b = t_h([20,25,30],1:5,1,1);
% 
% t_h60_s = t_h(1:15,6:10,1,1);
% t_h60_b = t_h([20,25,30],6:10,1,1);
% 
% % constant noise
% t_h31_s = sum(t_h(1:15,1:5,2,:),4)/10;
% t_h31_b = sum(t_h([20,25,30],1:5,2,:),4)/10;
% 
% t_h61_s = sum(t_h(1:15,6:10,2,:),4)/10;
% t_h61_b = sum(t_h([20,25,30],6:10,2,:),4)/10;
% 
% % vanishing noise
% t_h32_s = sum(t_h(1:15,1:5,3,:),4)/10;
% t_h32_b = sum(t_h([20,25,30],1:5,3,:),4)/10;
% 
% t_h62_s = sum(t_h(1:15,6:10,3,:),4)/10;
% t_h62_b = sum(t_h([20,25,30],6:10,3,:),4)/10;
% 
% % constant gradient noise
% t_h33_s = sum(t_h(1:15,1:5,4,:),4)/10;
% t_h33_b = sum(t_h([20,25,30],1:5,4,:),4)/10;
% 
% t_h63_s = sum(t_h(1:15,6:10,4,:),4)/10;
% t_h63_b = sum(t_h([20,25,30],6:10,4,:),4)/10;
% 
% % vanishing gradient noise
% t_h34_s = sum(t_h(1:15,1:5,5,:),4)/10;
% t_h34_b = sum(t_h([20,25,30],1:5,5,:),4)/10;
% 
% t_h64_s = sum(t_h(1:15,6:10,5,:),4)/10;
% t_h64_b = sum(t_h([20,25,30],6:10,5,:),4)/10;
% 
% %% noll with BFGS
% %no noise
% t_nb30_s = t_n(1:15,1:5,1,1,1);
% t_nb30_b = t_n([20,25,30],1:5,1,1,1);
% 
% t_nb60_s = t_n(1:15,6:10,1,1,1);
% t_nb60_b = t_n([20,25,30],6:10,1,1,1);
% 
% %constant noise
% t_nb31_s = sum(t_n(1:15,1:5,1,2,:),5)/10;
% t_nb31_b = sum(t_n([20,25,30],1:5,1,2,:),5)/10;
% 
% t_nb61_s = sum(t_n(1:15,6:10,1,2,:),5)/10;
% t_nb61_b = sum(t_n([20,25,30],6:10,1,2,:),5)/10;
% 
% %vanishing noise
% t_nb32_s = sum(t_n(1:15,1:5,1,3,:),5)/10;
% t_nb32_b = sum(t_n([20,25,30],1:5,1,3,:),5)/10;
% 
% t_nb62_s = sum(t_n(1:15,6:10,1,3,:),5)/10;
% t_nb62_b = sum(t_n([20,25,30],6:10,1,3,:),5)/10;
% 
% %constant gradient noise
% t_nb33_s = sum(t_n(1:15,1:5,1,4,:),5)/10;
% t_nb33_b = sum(t_n([20,25,30],1:5,1,4,:),5)/10;
% 
% t_nb63_s = sum(t_n(1:15,6:10,1,4,:),5)/10;
% t_nb63_b = sum(t_n([20,25,30],6:10,1,4,:),5)/10;
% 
% %vanishing gradient noise
% t_nb34_s = sum(t_n(1:15,1:5,1,5,:),5)/10;
% t_nb34_b = sum(t_n([20,25,30],1:5,1,5,:),5)/10;
% 
% t_nb64_s = sum(t_n(1:15,6:10,1,5,:),5)/10;
% t_nb64_b = sum(t_n([20,25,30],6:10,1,5,:),5)/10;
% 
% 
% %% noll with SR1
% %no noise
% t_ns30_s = t_n(1:15,1:5,2,1,1);
% t_ns30_b = t_n([20,25,30],1:5,2,1,1);
% 
% t_ns60_s = t_n(1:15,6:10,2,1,1);
% t_ns60_b = t_n([20,25,30],6:10,2,1,1);
% 
% %constant noise
% t_ns31_s = sum(t_n(1:15,1:5,2,2,:),5)/10;
% t_ns31_b = sum(t_n([20,25,30],1:5,2,2,:),5)/10;
% 
% t_ns61_s = sum(t_n(1:15,6:10,2,2,:),5)/10;
% t_ns61_b = sum(t_n([20,25,30],6:10,2,2,:),5)/10;
% 
% %vanishing noise
% t_ns32_s = sum(t_n(1:15,1:5,2,3,:),5)/10;
% t_ns32_b = sum(t_n([20,25,30],1:5,2,3,:),5)/10;
% 
% t_ns62_s = sum(t_n(1:15,6:10,2,3,:),5)/10;
% t_ns62_b = sum(t_n([20,25,30],6:10,2,3,:),5)/10;
% 
% %constant gradient noise
% t_ns33_s = sum(t_n(1:15,1:5,2,4,:),5)/10;
% t_ns33_b = sum(t_n([20,25,30],1:5,2,4,:),5)/10;
% 
% t_ns63_s = sum(t_n(1:15,6:10,2,4,:),5)/10;
% t_ns63_b = sum(t_n([20,25,30],6:10,2,4,:),5)/10;
% 
% %vanishing gradient noise
% t_ns34_s = sum(t_n(1:15,1:5,2,5,:),5)/10;
% t_ns34_b = sum(t_n([20,25,30],1:5,2,5,:),5)/10;
% 
% t_ns64_s = sum(t_n(1:15,6:10,2,5,:),5)/10;
% t_ns64_b = sum(t_n([20,25,30],6:10,2,5,:),5)/10;
% 
% %% noll scaled
% % no noise
% kQt_nb30_s = kQt_n(1:15,1:5,1,1,1);
% kQt_nb30_b = kQt_n([20,25,30],1:5,1,1,1);
% 
% kQt_nb60_s = kQt_n(1:15,6:10,1,1,1);
% kQt_nb60_b = kQt_n([20,25,30],6:10,1,1,1);
% 
% % constant noise
% kQt_nb31_s = sum(kQt_n(1:15,1:5,1,2,:),5)/10;
% kQt_nb31_b = sum(kQt_n([20,25,30],1:5,1,2,:),5)/10;
% 
% kQt_nb61_s = sum(kQt_n(1:15,6:10,1,2,:),5)/10;
% kQt_nb61_b = sum(kQt_n([20,25,30],6:10,1,2,:),5)/10;
% 
% % vanishing noise
% kQt_nb32_s = sum(kQt_n(1:15,1:5,1,3,:),5)/10;
% kQt_nb32_b = sum(kQt_n([20,25,30],1:5,1,3,:),5)/10;
% 
% kQt_nb62_s = sum(kQt_n(1:15,6:10,1,3,:),5)/10;
% kQt_nb62_b = sum(kQt_n([20,25,30],6:10,1,3,:),5)/10;
% 
% % constant gradient noise
% kQt_nb33_s = sum(kQt_n(1:15,1:5,1,4,:),5)/10;
% kQt_nb33_b = sum(kQt_n([20,25,30],1:5,1,4,:),5)/10;
% 
% kQt_nb63_s = sum(kQt_n(1:15,6:10,1,4,:),5)/10;
% kQt_nb63_b = sum(kQt_n([20,25,30],6:10,1,4,:),5)/10;
% 
% % vanishing gradient noise
% kQt_nb34_s = sum(kQt_n(1:15,1:5,1,5,:),5)/10;
% kQt_nb34_b = sum(kQt_n([20,25,30],1:5,1,5,:),5)/10;
% 
% kQt_nb64_s = sum(kQt_n(1:15,6:10,1,5,:),5)/10;
% kQt_nb64_b = sum(kQt_n([20,25,30],6:10,1,5,:),5)/10;
% 
% % no noise
% kQt_ns30_s = kQt_n(1:15,1:5,2,1,1);
% kQt_ns30_b = kQt_n([20,25,30],1:5,2,1,1);
% 
% kQt_ns60_s = kQt_n(1:15,6:10,2,1,1);
% kQt_ns60_b = kQt_n([20,25,30],6:10,2,1,1);
% 
% % constant noise
% kQt_ns31_s = sum(kQt_n(1:15,1:5,2,2,:),5)/10;
% kQt_ns31_b = sum(kQt_n([20,25,30],1:5,2,2,:),5)/10;
% 
% kQt_ns61_s = sum(kQt_n(1:15,6:10,2,2,:),5)/10;
% kQt_ns61_b = sum(kQt_n([20,25,30],6:10,2,2,:),5)/10;
% 
% % vanishing noise
% kQt_ns32_s = sum(kQt_n(1:15,1:5,2,3,:),5)/10;
% kQt_ns32_b = sum(kQt_n([20,25,30],1:5,2,3,:),5)/10;
% 
% kQt_ns62_s = sum(kQt_n(1:15,6:10,2,3,:),5)/10;
% kQt_ns62_b = sum(kQt_n([20,25,30],6:10,2,3,:),5)/10;
% 
% % constant gradient noise
% kQt_ns33_s = sum(kQt_n(1:15,1:5,2,4,:),5)/10;
% kQt_ns33_b = sum(kQt_n([20,25,30],1:5,2,4,:),5)/10;
% 
% kQt_ns63_s = sum(kQt_n(1:15,6:10,2,4,:),5)/10;
% kQt_ns63_b = sum(kQt_n([20,25,30],6:10,2,4,:),5)/10;
% 
% % vanishing gradient noise
% kQt_ns34_s = sum(kQt_n(1:15,1:5,2,5,:),5)/10;
% kQt_ns34_b = sum(kQt_n([20,25,30],1:5,2,5,:),5)/10;
% 
% kQt_ns64_s = sum(kQt_n(1:15,6:10,2,5,:),5)/10;
% kQt_ns64_b = sum(kQt_n([20,25,30],6:10,2,5,:),5)/10;
% 
