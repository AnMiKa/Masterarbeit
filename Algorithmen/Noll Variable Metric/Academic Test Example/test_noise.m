% x0 = [-4;0.5];
% 
% %% Parabola
% fp_h = zeros(10,5);
% fp_n1 = zeros(10,5);
% fp_n4 = zeros(10,5);
% 
% tp_h = zeros(10,5);
% tp_n1 = zeros(10,5);
% tp_n4 = zeros(10,5); 
% 
% kp_h = zeros(10,5);
% kp_n1 = zeros(10,5);
% kp_n4 = zeros(10,5); 
% 
% for times = 1:10
%     for noise = 0:4
%         [fp_h(times,noise+1),~,tp_h(times,noise+1),kp_h(times,noise+1)] = bundle_nonconv_inex(x0,@parab,@grad_parab,noise); 
%         [fp_n1(times,noise+1),~,tp_n1(times,noise+1),kp_n1(times,noise+1)] = noll_variable_metric_nonconv_inex(x0,@parab,@grad_parab,1,noise);
%         [fp_n4(times,noise+1),~,tp_n4(times,noise+1),kp_n4(times,noise+1)] = noll_variable_metric_nonconv_inex(x0,@parab,@grad_parab,4,noise);
%     end
% end
% 
% fp_h = sum(fp_h,1)/10;
% fp_n1 = sum(fp_n1,1)/10;
% fp_n4 = sum(fp_n4,1)/10;
% 
% tp_h = sum(tp_h,1)/10;
% tp_n1 = sum(tp_n1,1)/10;
% tp_n4 = sum(tp_n4,1)/10;
% 
% kp_h = ceil(sum(kp_h,1)/10);
% kp_n1 = ceil(sum(kp_n1,1)/10);
% kp_n4 = ceil(sum(kp_n4,1)/10);
% 
% 
% %% Nonsmooth Parabola
% fnp_h = zeros(10,5);
% fnp_n1 = zeros(10,5);
% fnp_n4 = zeros(10,5);
% 
% tnp_h = zeros(10,5);
% tnp_n1 = zeros(10,5);
% tnp_n4 = zeros(10,5); 
% 
% knp_h = zeros(10,5);
% knp_n1 = zeros(10,5);
% knp_n4 = zeros(10,5); 
% 
% for times = 1:10
%     for noise = 0:4
%         [fnp_h(times,noise+1),~,tnp_h(times,noise+1),knp_h(times,noise+1)] = bundle_nonconv_inex(x0,@nonsm_parab,@subgr_nonsm_parab,noise); 
%         [fnp_n1(times,noise+1),~,tnp_n1(times,noise+1),knp_n1(times,noise+1)] = noll_variable_metric_nonconv_inex(x0,@nonsm_parab,@subgr_nonsm_parab,1,noise);
%         [fnp_n4(times,noise+1),~,tnp_n4(times,noise+1),knp_n4(times,noise+1)] = noll_variable_metric_nonconv_inex(x0,@nonsm_parab,@subgr_nonsm_parab,4,noise);
%     end
% end
% 
% fnp_h = sum(fp_h,1)/10;
% fnp_n1 = sum(fp_n1,1)/10;
% fnp_n4 = sum(fp_n4,1)/10;
% 
% tnp_h = sum(tp_h,1)/10;
% tnp_n1 = sum(tp_n1,1)/10;
% tnp_n4 = sum(tp_n4,1)/10;
% 
% knp_h = ceil(sum(kp_h,1)/10);
% knp_n1 = ceil(sum(kp_n1,1)/10);
% knp_n4 = ceil(sum(kp_n4,1)/10);

%% plot results
figure
hold on
box on

bar(1:5,[kp_h' kp_n1' kp_n4'],1)

% Add a legend
legend('Bundle Nonconv Inex', 'Variable Metric BFGS', 'Variable Metric BFGS Adaptive')
title('...')
xlabel('noise forms')
ylabel('number of steps')
%axis([0.85, 16, 0, 9.5])
%xticks()
set(gca,'ygrid','on')
