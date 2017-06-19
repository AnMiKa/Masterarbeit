% test script nonconvex inexact bundle method

% all specifications same as in paper apart from stepsize and stopping
% tolerance

% starting values
x0 = ones(30,1)./(1:30)'.^2;
% relative stopping condition
tol = 1e-6;

%% hare algorithm
f_h = zeros(15,5,10);
t_h = zeros(15,5,10);
k_h = zeros(15,5,10);

for dim = 1:15 % x-dimension
    for noise = 0:4 % form of noise
        if noise > 0
            for t = 1:10 % if noise -> do 10 times
                [f_h(dim,noise+1,t),~,t_h(dim,noise+1,t),k_h(dim,noise+1,t)] = bundle_nonconv_inex(x0(1:dim),@f1_testfunction,@subgr_f1_testfunction,noise,250*dim,tol);
                [f_h(dim,noise+1,t),~,t_h(dim,noise+1,t),k_h(dim,noise+1,t)] = bundle_nonconv_inex(x0(1:dim),@f2_testfunction,@subgr_f2_testfunction,noise,250*dim,tol);
                [f_h(dim,noise+1,t),~,t_h(dim,noise+1,t),k_h(dim,noise+1,t)] = bundle_nonconv_inex(x0(1:dim),@f3_testfunction,@subgr_f3_testfunction,noise,250*dim,tol);
                [f_h(dim,noise+1,t),~,t_h(dim,noise+1,t),k_h(dim,noise+1,t)] = bundle_nonconv_inex(x0(1:dim),@f4_testfunction,@subgr_f4_testfunction,noise,250*dim,tol);
                [f_h(dim,noise+1,t),~,t_h(dim,noise+1,t),k_h(dim,noise+1,t)] = bundle_nonconv_inex(x0(1:dim),@f5_testfunction,@subgr_f5_testfunction,noise,250*dim,tol);
            end
        else
            [f_h(dim,noise+1,1),~,t_h(dim,noise+1),k_h(dim,noise+1)] = bundle_nonconv_inex(x0(1:dim),@f1_testfunction,@subgr_f1_testfunction,noise,250*dim,tol);
            [f_h(dim,noise+1,1),~,t_h(dim,noise+1),k_h(dim,noise+1)] = bundle_nonconv_inex(x0(1:dim),@f2_testfunction,@subgr_f2_testfunction,noise,250*dim,tol);
            [f_h(dim,noise+1,1),~,t_h(dim,noise+1),k_h(dim,noise+1)] = bundle_nonconv_inex(x0(1:dim),@f3_testfunction,@subgr_f3_testfunction,noise,250*dim,tol);
            [f_h(dim,noise+1,1),~,t_h(dim,noise+1),k_h(dim,noise+1)] = bundle_nonconv_inex(x0(1:dim),@f4_testfunction,@subgr_f4_testfunction,noise,250*dim,tol);
            [f_h(dim,noise+1,1),~,t_h(dim,noise+1),k_h(dim,noise+1)] = bundle_nonconv_inex(x0(1:dim),@f5_testfunction,@subgr_f5_testfunction,noise,250*dim,tol); 
        end
    end
end

% no noise
log_f_h0 = abs(log10(f_h(:,1,1)));
k_h0 = k_h(:,1,1);

% constant noise
log_f_h1 = abs(log10(sum(f_h(:,2,:),3)/10));
k_h1 = ceil(sum(k_h(:,2,:),3)/10);

% vanishing noise
log_f_h2 = abs(log10(sum(f_h(:,3,:),3)/10));
k_h2 = ceil(sum(k_h(:,3,:),3)/10);

% constant gradient noise
log_f_h3 = abs(log10(sum(f_h(:,4,:),3)/10));
k_h3 = ceil(sum(k_h(:,4,:),3)/10);

% vanishing gradient noise
log_f_h4 = abs(log10(sum(f_h(:,5,:),3)/10));
k_h4 = ceil(sum(k_h(:,5,:),3)/10);


%% noll algorithm
f_n = zeros(15,2,5,10);
t_n = zeros(15,2,5,10);
k_n = zeros(15,2,5,10);

for dim = 1:15 % x-dimension
    for q = [1,4] % form of Q
        for noise = 0:4 % form of noise
            if noise > 0 
                for t = 1:10 % if noise -> do 10 times
                    [f_n(dim,q,noise+1,t),~,t_n(dim,q,noise+1,t),k_n(dim,q,noise+1,t)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f1_testfunction,@subgr_f1_testfunction,q,noise,250*dim,tol);
                    [f_n(dim,q,noise+1,t),~,t_n(dim,q,noise+1,t),k_n(dim,q,noise+1,t)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f2_testfunction,@subgr_f2_testfunction,q,noise,250*dim,tol);
                    [f_n(dim,q,noise+1,t),~,t_n(dim,q,noise+1,t),k_n(dim,q,noise+1,t)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f3_testfunction,@subgr_f3_testfunction,q,noise,250*dim,tol);
                    [f_n(dim,q,noise+1,t),~,t_n(dim,q,noise+1,t),k_n(dim,q,noise+1,t)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f4_testfunction,@subgr_f4_testfunction,q,noise,250*dim,tol);
                    [f_n(dim,q,noise+1,t),~,t_n(dim,q,noise+1,t),k_n(dim,q,noise+1,t)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f5_testfunction,@subgr_f5_testfunction,q,noise,250*dim,tol);
                end
            else
                [f_n(dim,q,noise+1,1),~,t_n(dim,q,noise+1,1),k_n(dim,q,noise+1,1)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f1_testfunction,@subgr_f1_testfunction,q,noise,250*dim,tol);
                [f_n(dim,q,noise+1,1),~,t_n(dim,q,noise+1,1),k_n(dim,q,noise+1,1)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f2_testfunction,@subgr_f2_testfunction,q,noise,250*dim,tol);
                [f_n(dim,q,noise+1,1),~,t_n(dim,q,noise+1,1),k_n(dim,q,noise+1,1)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f3_testfunction,@subgr_f3_testfunction,q,noise,250*dim,tol);
                [f_n(dim,q,noise+1,1),~,t_n(dim,q,noise+1,1),k_n(dim,q,noise+1,1)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f4_testfunction,@subgr_f4_testfunction,q,noise,250*dim,tol);
                [f_n(dim,q,noise+1,1),~,t_n(dim,q,noise+1,1),k_n(dim,q,noise+1,1)] = noll_variable_metric_nonconv_inex(x0(1:dim),@f5_testfunction,@subgr_f5_testfunction,q,noise,250*dim,tol);
            end
        end
    end
end

% no noise
log_f_n10 = abs(log10(f_n(:,1,1,1)));
k_n10 = k_n(:,1,1,1);
log_f_n40 = abs(log10(f_n(:,2,1,1)));
k_n40 = k_n(:,2,1,1);

% constant noise
log_f_n11 = abs(log10(sum(f_n(:,1,2,:),4)/10));
k_n11 = ceil(sum(k_n(:,1,2,:),4)/10);
log_f_n41 = abs(log10(sum(f_n(:,2,2,:),4)/10));
k_n41 = ceil(sum(k_n(:,2,2,:),4)/10);

% vanishing noise
log_f_n12 = abs(log10(sum(f_n(:,1,3,:),4)/10));
k_n12 = ceil(sum(k_n(:,1,3,:),4)/10);
log_f_n42 = abs(log10(sum(f_n(:,2,3,:),4)/10));
k_n42 = ceil(sum(k_n(:,2,3,:),4)/10);

% constant gradient noise
log_f_n13 = abs(log10(sum(f_n(:,1,4,:),4)/10));
k_n13 = ceil(sum(k_n(:,1,4,:),4)/10);
log_f_n43 = abs(log10(sum(f_n(:,2,4,:),4)/10));
k_n43 = ceil(sum(k_n(:,2,4,:),4)/10);

% vanishing gradient noise
log_f_n14 = abs(log10(sum(f_n(:,1,5,:),4)/10));
k_n14 = ceil(sum(k_n(:,1,5,:),4)/10);
log_f_n44 = abs(log10(sum(f_n(:,2,5,:),4)/10));
k_n44 = ceil(sum(k_n(:,2,5,:),4)/10);
