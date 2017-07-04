% test script nonconvex inexact bundle method

% all specifications same as in paper apart from stepsize and stopping
% tolerance

% starting values
x0 = ones(50,1)./(1:50)'.^2;
% relative stopping condition
tol = 1e-6;

%% hare algorithm
f_h = zeros(5,5,5,10);
t_h = zeros(5,5,5,10);
k_h = zeros(5,5,5,10);

for dim = [20,25,30,40,50] % x-dimension
    for noise = 0:4 % form of noise
        if noise > 0
            for t = 1:10 % if noise -> do 10 times
                [f_h(dim,noise+1,1,t),~,t_h(dim,noise+1,1,t),k_h(dim,noise+1,1,t)] = bundle_nonconv_inex(x0(1:dim),@f1_testfunction,@subgr_f1_testfunction,noise,250*dim,tol);
                [f_h(dim,noise+1,2,t),~,t_h(dim,noise+1,2,t),k_h(dim,noise+1,2,t)] = bundle_nonconv_inex(x0(1:dim),@f2_testfunction,@subgr_f2_testfunction,noise,250*dim,tol);
                [f_h(dim,noise+1,3,t),~,t_h(dim,noise+1,3,t),k_h(dim,noise+1,3,t)] = bundle_nonconv_inex(x0(1:dim),@f3_testfunction,@subgr_f3_testfunction,noise,250*dim,tol);
                [f_h(dim,noise+1,4,t),~,t_h(dim,noise+1,4,t),k_h(dim,noise+1,4,t)] = bundle_nonconv_inex(x0(1:dim),@f4_testfunction,@subgr_f4_testfunction,noise,250*dim,tol);
                [f_h(dim,noise+1,5,t),~,t_h(dim,noise+1,5,t),k_h(dim,noise+1,5,t)] = bundle_nonconv_inex(x0(1:dim),@f5_testfunction,@subgr_f5_testfunction,noise,250*dim,tol);
            end
        else
            [f_h(dim,noise+1,1,1),~,t_h(dim,noise+1,1,1),k_h(dim,noise+1,1,1)] = bundle_nonconv_inex(x0(1:dim),@f1_testfunction,@subgr_f1_testfunction,noise,250*dim,tol);
            [f_h(dim,noise+1,2,1),~,t_h(dim,noise+1,2,1),k_h(dim,noise+1,2,1)] = bundle_nonconv_inex(x0(1:dim),@f2_testfunction,@subgr_f2_testfunction,noise,250*dim,tol);
            [f_h(dim,noise+1,3,1),~,t_h(dim,noise+1,3,1),k_h(dim,noise+1,3,1)] = bundle_nonconv_inex(x0(1:dim),@f3_testfunction,@subgr_f3_testfunction,noise,250*dim,tol);
            [f_h(dim,noise+1,4,1),~,t_h(dim,noise+1,4,1),k_h(dim,noise+1,4,1)] = bundle_nonconv_inex(x0(1:dim),@f4_testfunction,@subgr_f4_testfunction,noise,250*dim,tol);
            [f_h(dim,noise+1,5,1),~,t_h(dim,noise+1,5,1),k_h(dim,noise+1,5,1)] = bundle_nonconv_inex(x0(1:dim),@f5_testfunction,@subgr_f5_testfunction,noise,250*dim,tol); 
        end
    end
end

% no noise
log_f_h0 = abs(log10(f_h([20,25,30,40,50],1,:,1)));
k_h0 = k_h([20,25,30,40,50],1,:,1);

% constant noise
log_f_h1 = abs(log10(sum(f_h([20,25,30,40,50],2,:,:),4)/10));
k_h1 = ceil(sum(k_h([20,25,30,40,50],2,:,:),4)/10);

% vanishing noise
log_f_h2 = abs(log10(sum(f_h([20,25,30,40,50],3,:,:),4)/10));
k_h2 = ceil(sum(k_h([20,25,30,40,50],3,:,:),4)/10);

% constant gradient noise
log_f_h3 = abs(log10(sum(f_h([20,25,30,40,50],4,:,:),4)/10));
k_h3 = ceil(sum(k_h([20,25,30,40,50],4,:,:),4)/10);

% vanishing gradient noise
log_f_h4 = abs(log10(sum(f_h([20,25,30,40,50],5,:,:),4)/10));
k_h4 = ceil(sum(k_h([20,25,30,40,50],5,:,:),4)/10);


%% noll algorithm
f_n = zeros(5,2,5,5,10);
t_n = zeros(5,2,5,5,10);
k_n = zeros(5,2,5,5,10);

for dim = [20,25,30,40,50] % x-dimension
    for q = [1,4] % form of Q
        for noise = 0:4 % form of noise
            if noise > 0 
                for t = 1:10 % if noise -> do 10 times
                    [f_n(dim,q,noise+1,1,t),~,t_n(dim,q,noise+1,1,t),k_n(dim,q,noise+1,1,t)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f1_testfunction,@subgr_f1_testfunction,q,noise,250*dim,tol);
                    [f_n(dim,q,noise+1,2,t),~,t_n(dim,q,noise+1,2,t),k_n(dim,q,noise+1,2,t)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f2_testfunction,@subgr_f2_testfunction,q,noise,250*dim,tol);
                    [f_n(dim,q,noise+1,3,t),~,t_n(dim,q,noise+1,3,t),k_n(dim,q,noise+1,3,t)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f3_testfunction,@subgr_f3_testfunction,q,noise,250*dim,tol);
                    [f_n(dim,q,noise+1,4,t),~,t_n(dim,q,noise+1,4,t),k_n(dim,q,noise+1,4,t)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f4_testfunction,@subgr_f4_testfunction,q,noise,250*dim,tol);
                    [f_n(dim,q,noise+1,5,t),~,t_n(dim,q,noise+1,5,t),k_n(dim,q,noise+1,5,t)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f5_testfunction,@subgr_f5_testfunction,q,noise,250*dim,tol);
                end
            else
                [f_n(dim,q,noise+1,1,1),~,t_n(dim,q,noise+1,1,1),k_n(dim,q,noise+1,1,1)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f1_testfunction,@subgr_f1_testfunction,q,noise,250*dim,tol);
                [f_n(dim,q,noise+1,2,1),~,t_n(dim,q,noise+1,2,1),k_n(dim,q,noise+1,2,1)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f2_testfunction,@subgr_f2_testfunction,q,noise,250*dim,tol);
                [f_n(dim,q,noise+1,3,1),~,t_n(dim,q,noise+1,3,1),k_n(dim,q,noise+1,3,1)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f3_testfunction,@subgr_f3_testfunction,q,noise,250*dim,tol);
                [f_n(dim,q,noise+1,4,1),~,t_n(dim,q,noise+1,4,1),k_n(dim,q,noise+1,4,1)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f4_testfunction,@subgr_f4_testfunction,q,noise,250*dim,tol);
                [f_n(dim,q,noise+1,5,1),~,t_n(dim,q,noise+1,5,1),k_n(dim,q,noise+1,5,1)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f5_testfunction,@subgr_f5_testfunction,q,noise,250*dim,tol);
            end
        end
    end
end

% no noise
log_f_n10 = abs(log10(f_n([20,25,30,40,50],1,:,1)));
k_n10 = k_n([20,25,30,40,50],1,:,1);
log_f_n40 = abs(log10(f_n([20,25,30,40,50],4,:,1)));
k_n40 = k_n([20,25,30,40,50],4,:,1);

% constant noise
log_f_n11 = abs(log10(sum(f_n([20,25,30,40,50],1,2,:,:),5)/10));
k_n11 = ceil(sum(k_n([20,25,30,40,50],1,2,:,:),5)/10);
log_f_n41 = abs(log10(sum(f_n([20,25,30,40,50],4,2,:,:),5)/10));
k_n41 = ceil(sum(k_n([20,25,30,40,50],4,2,:,:),5)/10);

% vanishing noise
log_f_n12 = abs(log10(sum(f_n([20,25,30,40,50],1,3,:,:),5)/10));
k_n12 = ceil(sum(k_n([20,25,30,40,50],1,3,:,:),5)/10);
log_f_n42 = abs(log10(sum(f_n([20,25,30,40,50],4,3,:,:),5)/10));
k_n42 = ceil(sum(k_n([20,25,30,40,50],4,3,:,:),5)/10);

% constant gradient noise
log_f_n13 = abs(log10(sum(f_n([20,25,30,40,50],1,4,:,:),5)/10));
k_n13 = ceil(sum(k_n([20,25,30,40,50],1,4,:,:),5)/10);
log_f_n43 = abs(log10(sum(f_n([20,25,30,40,50],4,4,:,:),5)/10));
k_n43 = ceil(sum(k_n([20,25,30,40,50],4,4,:,:),5)/10);

% vanishing gradient noise
log_f_n14 = abs(log10(sum(f_n([20,25,30,40,50],1,5,:,:),5)/10));
k_n14 = ceil(sum(k_n([20,25,30,40,50],1,5,:,:),5)/10);
log_f_n44 = abs(log10(sum(f_n([20,25,30,40,50],4,5,:,:),5)/10));
k_n44 = ceil(sum(k_n([20,25,30,40,50],4,5,:,:),5)/10);
