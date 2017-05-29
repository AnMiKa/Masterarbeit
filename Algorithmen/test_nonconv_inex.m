% test script nonconvex inexact bundle method

% all specifications same as in paper apart from stepsize

% starting values
x0 = ones(30,1)./(1:30)'.^2;
% relative stopping condition
tol = [1e-3;1e-6];

% hare algorithm
f_h = zeros(30,10,5);
t_h = zeros(30,10,5);

for i = 1:15
    for j = 1:2
       for n = 0:4
           [f_h(i,1+(j-1)*5,n+1),~,t_h(i,1+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,n,250*i,tol(j));
           [f_h(i,2+(j-1)*5,n+1),~,t_h(i,2+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,n,250*i,tol(j));
           [f_h(i,3+(j-1)*5,n+1),~,t_h(i,3+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,n,250*i,tol(j));
           [f_h(i,4+(j-1)*5,n+1),~,t_h(i,4+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,n,250*i,tol(j));
           [f_h(i,5+(j-1)*5,n+1),~,t_h(i,5+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,n,250*i,tol(j));
       end
    end
end

for i = [20,25,30]
    for j = 1:2
        for n = 0:4
            [f_h(i,1+(j-1)*5,n+1),~,t_h(i,1+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,n,250*i,tol(j));
            [f_h(i,2+(j-1)*5,n+1),~,t_h(i,2+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,n,250*i,tol(j));
            [f_h(i,3+(j-1)*5,n+1),~,t_h(i,3+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,n,250*i,tol(j));
            [f_h(i,4+(j-1)*5,n+1),~,t_h(i,4+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,n,250*i,tol(j));
            [f_h(i,5+(j-1)*5,n+1),~,t_h(i,5+(j-1)*5,n+1)] = bundle_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,n,250*i,tol(j));
        end
    end
end

% no noise
f_h30_av_s = sum(f_h(1:15,1:5,1),2)/5;
f_h30_av_b = sum(f_h(16:30,1:5,1),2)/5;
log_f_h30_s = abs(log10(f_h30_av_s));
log_f_h30_b = abs(log10(f_h30_av_b));

f_h60_av_s = sum(f_h(1:15,6:10,1),2)/5;
f_h60_av_b = sum(f_h(16:30,6:10,1),2)/5;
log_f_h60_s = abs(log10(f_h60_av_s));
log_f_h60_b = abs(log10(f_h60_av_b));

% constant noise
f_h31_av_s = sum(f_h(1:15,1:5,2),2)/5;
f_h31_av_b = sum(f_h(16:30,1:5,2),2)/5;
log_f_h31_s = abs(log10(f_h31_av_s));
log_f_h31_b = abs(log10(f_h31_av_b));

f_h61_av_s = sum(f_h(1:15,6:10,2),2)/5;
f_h61_av_b = sum(f_h(16:30,6:10,2),2)/5;
log_f_h61_s = abs(log10(f_h61_av_s));
log_f_h61_b = abs(log10(f_h61_av_b));

% vanishing noise
f_h32_av_s = sum(f_h(1:15,1:5,3),2)/5;
f_h32_av_b = sum(f_h(16:30,1:5,3),2)/5;
log_f_h32_s = abs(log10(f_h32_av_s));
log_f_h32_b = abs(log10(f_h32_av_b));

f_h62_av_s = sum(f_h(1:15,6:10,3),2)/5;
f_h62_av_b = sum(f_h(16:30,6:10,3),2)/5;
log_f_h62_s = abs(log10(f_h62_av_s));
log_f_h62_b = abs(log10(f_h62_av_b));

% constant gradient noise
f_h33_av_s = sum(f_h(1:15,1:5,4),2)/5;
f_h33_av_b = sum(f_h(16:30,1:5,4),2)/5;
log_f_h33_s = abs(log10(f_h33_av_s));
log_f_h33_b = abs(log10(f_h33_av_b));

f_h63_av_s = sum(f_h(1:15,6:10,4),2)/5;
f_h63_av_b = sum(f_h(16:30,6:10,4),2)/5;
log_f_h63_s = abs(log10(f_h63_av_s));
log_f_h63_b = abs(log10(f_h63_av_b));

% vanishing gradient noise
f_h34_av_s = sum(f_h(1:15,1:5,5),2)/5;
f_h34_av_b = sum(f_h(16:30,1:5,5),2)/5;
log_f_h34_s = abs(log10(f_h34_av_s));
log_f_h34_b = abs(log10(f_h34_av_b));

f_h64_av_s = sum(f_h(1:15,6:10,5),2)/5;
f_h64_av_b = sum(f_h(16:30,6:10,5),2)/5;
log_f_h64_s = abs(log10(f_h64_av_s));
log_f_h64_b = abs(log10(f_h64_av_b));


% noll algorithm
f_n = zeros(30,10,2,5);
t_n = zeros(30,10,2,5);

for i = 1:15
    for j = 1:2
        for q = 1:2
            for n = 0:4
                [f_n(i,1+(j-1)*5,q,n+1),~,t_n(i,1+(j-1)*5,q,n+1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,q,n,250*i,tol(j));
                [f_n(i,2+(j-1)*5,q,n+1),~,t_n(i,2+(j-1)*5,q,n+1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,q,n,250*i,tol(j));
                [f_n(i,3+(j-1)*5,q,n+1),~,t_n(i,3+(j-1)*5,q,n+1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,q,n,250*i,tol(j));
                [f_n(i,4+(j-1)*5,q,n+1),~,t_n(i,4+(j-1)*5,q,n+1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,q,n,250*i,tol(j));
                [f_n(i,5+(j-1)*5,q,n+1),~,t_n(i,5+(j-1)*5,q,n+1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,q,n,250*i,tol(j));
            end
        end
    end
end

for i = [20,25,30]
    for j = 1:2
        for q = 1:2
            for n = 0:4
                [f_n(i,1+(j-1)*5,q,n+1),~,t_n(i,1+(j-1)*5,q,n+1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f1_testfunction,@subgr_f1_testfunction,q,n,250*i,tol(j));
                [f_n(i,2+(j-1)*5,q,n+1),~,t_n(i,2+(j-1)*5,q,n+1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f2_testfunction,@subgr_f2_testfunction,q,n,250*i,tol(j));
                [f_n(i,3+(j-1)*5,q,n+1),~,t_n(i,3+(j-1)*5,q,n+1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f3_testfunction,@subgr_f3_testfunction,q,n,250*i,tol(j));
                [f_n(i,4+(j-1)*5,q,n+1),~,t_n(i,4+(j-1)*5,q,n+1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f4_testfunction,@subgr_f4_testfunction,q,n,250*i,tol(j));
                [f_n(i,5+(j-1)*5,q,n+1),~,t_n(i,5+(j-1)*5,q,n+1)] = noll_variable_metric_nonconv_inex(x0(1:i),@f5_testfunction,@subgr_f5_testfunction,q,n,250*i,tol(j));
            end
        end
    end
end
    
% noll with BFGS
% no noise
f_nb30_av_s = sum(f_n(1:15,1:5,1,1),2)/5;
f_nb30_av_b = sum(f_n(16:30,1:5,1,1),2)/5;
log_f_nb30_s = abs(log10(f_nb30_av_s));
log_f_nb30_b = abs(log10(f_nb30_av_b));

f_nb60_av_s = sum(f_n(1:15,6:10,1,1),2)/5;
f_nb60_av_b = sum(f_n(16:30,6:10,1,1),2)/5;
log_f_nb60_s = abs(log10(f_nb60_av_s));
log_f_nb60_b = abs(log10(f_nb60_av_b));

% constant noise
f_nb31_av_s = sum(f_n(1:15,1:5,1,2),2)/5;
f_nb31_av_b = sum(f_n(16:30,1:5,1,2),2)/5;
log_f_nb31_s = abs(log10(f_nb31_av_s));
log_f_nb31_b = abs(log10(f_nb31_av_b));

f_nb61_av_s = sum(f_n(1:15,6:10,1,2),2)/5;
f_nb61_av_b = sum(f_n(16:30,6:10,1,2),2)/5;
log_f_nb61_s = abs(log10(f_nb61_av_s));
log_f_nb61_b = abs(log10(f_nb61_av_b));

% vanishing noise
f_nb32_av_s = sum(f_n(1:15,1:5,1,3),2)/5;
f_nb32_av_b = sum(f_n(16:30,1:5,1,3),2)/5;
log_f_nb32_s = abs(log10(f_nb32_av_s));
log_f_nb32_b = abs(log10(f_nb32_av_b));

f_nb62_av_s = sum(f_n(1:15,6:10,1,3),2)/5;
f_nb62_av_b = sum(f_n(16:30,6:10,1,3),2)/5;
log_f_nb62_s = abs(log10(f_nb62_av_s));
log_f_nb62_b = abs(log10(f_nb62_av_b));

% constant gradient noise
f_nb33_av_s = sum(f_n(1:15,1:5,1,4),2)/5;
f_nb33_av_b = sum(f_n(16:30,1:5,1,4),2)/5;
log_f_nb33_s = abs(log10(f_nb33_av_s));
log_f_nb33_b = abs(log10(f_nb33_av_b));

f_nb63_av_s = sum(f_n(1:15,6:10,1,4),2)/5;
f_nb63_av_b = sum(f_n(16:30,6:10,1,4),2)/5;
log_f_nb63_s = abs(log10(f_nb63_av_s));
log_f_nb63_b = abs(log10(f_nb63_av_b));

% vanishing gradient noise
f_nb34_av_s = sum(f_n(1:15,1:5,1,5),2)/5;
f_nb34_av_b = sum(f_n(16:30,1:5,1,5),2)/5;
log_f_nb34_s = abs(log10(f_nb34_av_s));
log_f_nb34_b = abs(log10(f_nb34_av_b));

f_nb64_av_s = sum(f_n(1:15,6:10,1,5),2)/5;
f_nb64_av_b = sum(f_n(16:30,6:10,1,5),2)/5;
log_f_nb64_s = abs(log10(f_nb64_av_s));
log_f_nb64_b = abs(log10(f_nb64_av_b));

% noll with SR1
% no noise
f_ns30_av_s = sum(f_n(1:15,1:5,2,1),2)/5;
f_ns30_av_b = sum(f_n(16:30,1:5,2,1),2)/5;
log_f_ns30_s = abs(log10(f_ns30_av_s));
log_f_ns30_b = abs(log10(f_ns30_av_b));

f_ns60_av_s = sum(f_n(1:15,6:10,2,1),2)/5;
f_ns60_av_b = sum(f_n(16:30,6:10,2,1),2)/5;
log_f_ns60_s = abs(log10(f_ns60_av_s));
log_f_ns60_b = abs(log10(f_ns60_av_b));

% constant noise
f_ns31_av_s = sum(f_n(1:15,1:5,2,2),2)/5;
f_ns31_av_b = sum(f_n(16:30,1:5,2,2),2)/5;
log_f_ns31_s = abs(log10(f_ns31_av_s));
log_f_ns31_b = abs(log10(f_ns31_av_b));

f_ns61_av_s = sum(f_n(1:15,6:10,2,2),2)/5;
f_ns61_av_b = sum(f_n(16:30,6:10,2,2),2)/5;
log_f_ns61_s = abs(log10(f_ns61_av_s));
log_f_ns61_b = abs(log10(f_ns61_av_b));

% vanishing noise
f_ns32_av_s = sum(f_n(1:15,1:5,2,3),2)/5;
f_ns32_av_b = sum(f_n(16:30,1:5,2,3),2)/5;
log_f_ns32_s = abs(log10(f_ns32_av_s));
log_f_ns32_b = abs(log10(f_ns32_av_b));

f_ns62_av_s = sum(f_n(1:15,6:10,2,3),2)/5;
f_ns62_av_b = sum(f_n(16:30,6:10,2,3),2)/5;
log_f_ns62_s = abs(log10(f_ns62_av_s));
log_f_ns62_b = abs(log10(f_ns62_av_b));

% constant gradient noise
f_ns33_av_s = sum(f_n(1:15,1:5,2,4),2)/5;
f_ns33_av_b = sum(f_n(16:30,1:5,2,4),2)/5;
log_f_ns33_s = abs(log10(f_ns33_av_s));
log_f_ns33_b = abs(log10(f_ns33_av_b));

f_ns63_av_s = sum(f_n(1:15,6:10,2,4),2)/5;
f_ns63_av_b = sum(f_n(16:30,6:10,2,4),2)/5;
log_f_ns63_s = abs(log10(f_ns63_av_s));
log_f_ns63_b = abs(log10(f_ns63_av_b));

% vanishing gradient noise
f_ns34_av_s = sum(f_n(1:15,1:5,2,5),2)/5;
f_ns34_av_b = sum(f_n(16:30,1:5,2,5),2)/5;
log_f_ns34_s = abs(log10(f_ns34_av_s));
log_f_ns34_b = abs(log10(f_ns34_av_b));

f_ns64_av_s = sum(f_n(1:15,6:10,2,5),2)/5;
f_ns64_av_b = sum(f_n(16:30,6:10,2,5),2)/5;
log_f_ns64_s = abs(log10(f_ns64_av_s));
log_f_ns64_b = abs(log10(f_ns64_av_b));

% noll with LBFGS
% not yet programmed

