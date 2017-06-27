% find minima of different data sets

% lambda values
%lambda = logspace(-15,3,100);
lambda = linspace(0,40,100);

%% Cancer
% load('Validation Data/Cancer.mat')
% load('Training Data/Cancer.mat')
% 
% % calculate w, b with hingequad
% Xtc1 = reshape(Xtcancer1,[9,240]);
% Xtc2 = reshape(Xtcancer2,[9,240]);
% Xtc3 = reshape(Xtcancer3,[9,240]);
% Ytc1 = reshape(Ytcancer1,[240,1]);
% Ytc2 = reshape(Ytcancer2,[240,1]);
% Ytc3 = reshape(Ytcancer3,[240,1]);
% Wbhq1 = zeros(10,length(lambda));
% Wbhq2 = zeros(10,length(lambda));
% Wbhq3 = zeros(10,length(lambda));
% 
% for l = 1:length(lambda)
%     Wbhq1(:,l) = postpro_wb_class_hingequad_qp(Xtc1,Ytc1,lambda(l));
%     Wbhq2(:,l) = postpro_wb_class_hingequad_qp(Xtc2,Ytc2,lambda(l));
%     Wbhq3(:,l) = postpro_wb_class_hingequad_qp(Xtc3,Ytc3,lambda(l));
% end
% Whq1 = Wbhq1(1:9,:);
% bhq1 = Wbhq1(10,:);
% Whq2 = Wbhq1(1:9,:);
% bhq2 = Wbhq1(10,:);
% Whq3 = Wbhq1(1:9,:);
% bhq3 = Wbhq1(10,:);
% 
% errhqm1 = zeros(1,length(lambda));
% errhqh = zeros(1,length(lambda));
% errhqhq1 = zeros(1,length(lambda)); 
% errhqm2 = zeros(1,length(lambda));
% errhqhq2 = zeros(1,length(lambda)); 
% errhqm3 = zeros(1,length(lambda));
% errhqhq3 = zeros(1,length(lambda)); 
% 
% % caculate the error for the different loss functions
% for l = 1:length(lambda)
%     errhqm1(l) = postpro_err_misclass(Whq1(:,l),bhq1(l),Xvcancer1,Yvcancer1);
%     errhqh(l) = postpro_err_hinge(Whq1(:,l),bhq1(l),Xvcancer1,Yvcancer1);
%     errhqhq1(l) = postpro_err_hingequad(Whq1(:,l),bhq1(l),Xvcancer1,Yvcancer1);
%     errhqm2(l) = postpro_err_misclass(Whq2(:,l),bhq2(l),Xvcancer2,Yvcancer2);
%     errhqm3(l) = postpro_err_misclass(Whq3(:,l),bhq3(l),Xvcancer3,Yvcancer3);
%     errhqhq2(l) = postpro_err_hingequad(Whq2(:,l),bhq2(l),Xvcancer2,Yvcancer2);
%     errhqhq3(l) = postpro_err_hingequad(Whq3(:,l),bhq3(l),Xvcancer3,Yvcancer3);
% end
% 
% % plot
% figure
% hold on
% title('inner level: hingequad','Interpreter','latex')
% p1 = plot(lambda,100*errhqm1,'m');
% plot(lambda,100*errhqm2,'m')
% plot(lambda,100*errhqm3,'m')
% p2 = plot(lambda,100*errhqh,'b');
% p3 = plot(lambda,100*errhqhq1,'c');
% plot(lambda,100*errhqhq2,'c')
% plot(lambda,100*errhqhq3,'c')
% 
% legend([p1,p2,p3],{'Misclassification loss','Hingeloss','Hingequad'})

%% Pima
load('Validation Data/Pima.mat')
load('Training Data/Pima.mat')

% calculate w, b with hingequad
Xtp1 = reshape(Xtpima1,[8,240]);
Xtp2 = reshape(Xtpima2,[8,240]);
Xtp3 = reshape(Xtpima3,[8,240]);
Ytp1 = reshape(Ytpima1,[240,1]);
Ytp2 = reshape(Ytpima2,[240,1]);
Ytp3 = reshape(Ytpima3,[240,1]);
Wbhq1 = zeros(9,length(lambda));
Wbhq2 = zeros(9,length(lambda));
Wbhq3 = zeros(9,length(lambda));

for l = 1:length(lambda)
    Wbhq1(:,l) = postpro_wb_class_hingequad_qp(Xtp1,Ytp1,lambda(l));
    Wbhq2(:,l) = postpro_wb_class_hingequad_qp(Xtp2,Ytp2,lambda(l));
    Wbhq3(:,l) = postpro_wb_class_hingequad_qp(Xtp3,Ytp3,lambda(l));
end

Whq1 = Wbhq1(1:8,:);
bhq1 = Wbhq1(9,:);
Whq2 = Wbhq2(1:8,:);
bhq2 = Wbhq2(9,:);
Whq3 = Wbhq3(1:8,:);
bhq3 = Wbhq3(9,:);

errhqm1 = zeros(1,length(lambda));
errhqh = zeros(1,length(lambda));
errhqhq1 = zeros(1,length(lambda)); 
errhqm2 = zeros(1,length(lambda));
errhqhq2 = zeros(1,length(lambda)); 
errhqm3 = zeros(1,length(lambda));
errhqhq3 = zeros(1,length(lambda)); 

% caculate the error for the different loss functions
for l = 1:length(lambda)
    errhqm1(l) = postpro_err_misclass(Whq1(:,l),bhq1(l),Xvpima1,Yvpima1);
    errhqm2(l) = postpro_err_misclass(Whq2(:,l),bhq2(l),Xvpima2,Yvpima2);
    errhqm3(l) = postpro_err_misclass(Whq3(:,l),bhq2(l),Xvpima3,Yvpima3);    
    errhqh(l) = postpro_err_hinge(Whq1(:,l),bhq1(l),Xvpima1,Yvpima1);
    errhqhq1(l) = postpro_err_hingequad(Whq1(:,l),bhq1(l),Xvpima1,Yvpima1);
    errhqhq2(l) = postpro_err_hingequad(Whq2(:,l),bhq2(l),Xvpima2,Yvpima2);
    errhqhq3(l) = postpro_err_hingequad(Whq3(:,l),bhq3(l),Xvpima3,Yvpima3);
end

% plot
figure
hold on
title('inner level: hingequad','Interpreter','latex')
p1 = plot(lambda,100*errhqm1,'m');
plot(lambda,100*errhqm2,'m')
plot(lambda,100*errhqm3,'m')
p2 = plot(lambda,100*errhqh,'b');
p3 = plot(lambda,100*errhqhq1,'c');
plot(lambda,100*errhqhq2,'c')
plot(lambda,100*errhqhq3,'c')
legend([p1,p2,p3],{'Misclassification loss','Hingeloss','Hingequad'})

%% Heart
load('Validation Data/Heart.mat')
load('Training Data/Heart.mat')

% calculate w, b with hingequad
Xth1 = reshape(Xtheart1,[13,216]);
Yth1 = reshape(Ytheart1,[216,1]);
Wbhq = zeros(14,length(lambda));
for l = 1:length(lambda)
    Wbhq(:,l) = postpro_wb_class_hingequad_qp(Xth1,Yth1,lambda(l));
end
Whq = Wbhq(1:13,:);
bhq = Wbhq(14,:);

errhqm = zeros(1,length(lambda));
errhqh = zeros(1,length(lambda));
errhqhq = zeros(1,length(lambda)); 

% caculate the error for the different loss functions
for l = 1:length(lambda)
    errhqm(l) = postpro_err_misclass(Whq(:,l),bhq(l),Xvheart1,Yvheart1);
    errhqh(l) = postpro_err_hinge(Whq(:,l),bhq(l),Xvheart1,Yvheart1);
    errhqhq(l) = postpro_err_hingequad(Whq(:,l),bhq(l),Xvheart1,Yvheart1);
end

% plot
figure
hold on
title('inner level: hingequad','Interpreter','latex')
plot(lambda,100*errhqm,'m')
plot(lambda,100*errhqh,'b')
plot(lambda,100*errhqhq,'c')
legend('Misclassification loss','Hingeloss','Hingequad')

%% Ionosphere
load('Validation Data/Ionosphere.mat')
load('Training Data/Ionosphere.mat')

% calculate w, b with hingequad
Xti1 = reshape(Xtio1,[33,240]);
Yti1 = reshape(Ytio1,[240,1]);
Wbhq = zeros(34,length(lambda));
for l = 1:length(lambda)
    Wbhq(:,l) = postpro_wb_class_hingequad_qp(Xti1,Yti1,lambda(l));
end
Whq = Wbhq(1:33,:);
bhq = Wbhq(34,:);

errhqm = zeros(1,length(lambda));
errhqh = zeros(1,length(lambda));
errhqhq = zeros(1,length(lambda)); 

% caculate the error for the different loss functions
for l = 1:length(lambda)
    errhqm(l) = postpro_err_misclass(Whq(:,l),bhq(l),Xvio1,Yvio1);
    errhqh(l) = postpro_err_hinge(Whq(:,l),bhq(l),Xvio1,Yvio1);
    errhqhq(l) = postpro_err_hingequad(Whq(:,l),bhq(l),Xvio1,Yvio1);
end

% plot
figure
hold on
title('inner level: hingequad','Interpreter','latex')
plot(lambda,100*errhqm,'m')
plot(lambda,100*errhqh,'b')
plot(lambda,100*errhqhq,'c')
legend('Misclassification loss','Hingeloss','Hingequad')

%% Adult
load('Validation Data/Adult.mat')
load('Training Data/Adult.mat')

% calculate w, b with hingequad
Xta1 = reshape(Xtadult1,[14,700*3]);
Yta1 = reshape(Ytadult1,[700*3,1]);
Wbhq = zeros(15,length(lambda));
for l = 1:length(lambda)
    Wbhq(:,l) = postpro_wb_class_hingequad_qp(Xta1,Yta1,lambda(l));
end
Whq = Wbhq(1:14,:);
bhq = Wbhq(15,:);

errhqm = zeros(1,length(lambda));
errhqh = zeros(1,length(lambda));
errhqhq = zeros(1,length(lambda)); 

% caculate the error for the different loss functions
for l = 1:length(lambda)
    errhqm(l) = postpro_err_misclass(Whq(:,l),bhq(l),Xvadult1,Yvadult1);
    errhqh(l) = postpro_err_hinge(Whq(:,l),bhq(l),Xvadult1,Yvadult1);
    errhqhq(l) = postpro_err_hingequad(Whq(:,l),bhq(l),Xvadult1,Yvadult1);
end

% plot
figure
hold on
title('inner level: hingequad','Interpreter','latex')
plot(lambda,100*errhqm,'m')
plot(lambda,100*errhqh,'b')
plot(lambda,100*errhqhq,'c')
legend('Misclassification loss','Hingeloss','Hingequad')

%% Covtype1000
load('Validation Data/Covtype1000.mat')
load('Training Data/Covtype1000.mat')

% calculate w, b with hingequad
Xtct1 = reshape(Xtcovtype1,[10,600]);
Ytct1 = reshape(Ytcovtype1,[600,1]);
Wbhq = zeros(11,length(lambda));
for l = 1:length(lambda)
    Wbhq(:,l) = postpro_wb_class_hingequad_qp(Xtct1,Ytct1,lambda(l));
end
Whq = Wbhq(1:10,:);
bhq = Wbhq(11,:);

errhqm = zeros(1,length(lambda));
errhqh = zeros(1,length(lambda));
errhqhq = zeros(1,length(lambda)); 

% caculate the error for the different loss functions
for l = 1:length(lambda)
    errhqm(l) = postpro_err_misclass(Whq(:,l),bhq(l),Xvcovtype1,Yvcovtype1);
    errhqh(l) = postpro_err_hinge(Whq(:,l),bhq(l),Xvcovtype1,Yvcovtype1);
    errhqhq(l) = postpro_err_hingequad(Whq(:,l),bhq(l),Xvcovtype1,Yvcovtype1);
end

% plot
figure
hold on
title('inner level: hingequad','Interpreter','latex')
plot(lambda,100*errhqm,'m')
plot(lambda,100*errhqh,'b')
plot(lambda,100*errhqhq,'c')
legend('Misclassification loss','Hingeloss','Hingequad')

%% Wine Quality Red
load('Validation Data/Winequalityred.mat')
load('Training Data/Winequalityred.mat')

% calculate w, b with hingequad
Xtw1 = reshape(Xtwqr1,[11,600]);
Ytw1 = reshape(Ytwqr1,[600,1]);
Wbhq = zeros(12,length(lambda));
for l = 1:length(lambda)
    Wbhq(:,l) = postpro_wb_class_hingequad_qp(Xtw1,Ytw1,lambda(l));
end
Whq = Wbhq(1:11,:);
bhq = Wbhq(12,:);

errhqm = zeros(1,length(lambda));
errhqh = zeros(1,length(lambda));
errhqhq = zeros(1,length(lambda)); 

% caculate the error for the different loss functions
for l = 1:length(lambda)
    errhqm(l) = postpro_err_misclass(Whq(:,l),bhq(l),Xvwqr1,Yvwqr1);
    errhqh(l) = postpro_err_hinge(Whq(:,l),bhq(l),Xvwqr1,Yvwqr1);
    errhqhq(l) = postpro_err_hingequad(Whq(:,l),bhq(l),Xvwqr1,Yvwqr1);
end

% plot
figure
hold on
title('inner level: hingequad','Interpreter','latex')
plot(lambda,100*errhqm,'m')
plot(lambda,100*errhqh,'b')
plot(lambda,100*errhqhq,'c')
legend('Misclassification loss','Hingeloss','Hingequad')

%% Wine Quality Red 56
load('Validation Data/Winequalityred56.mat')
load('Training Data/Winequalityred56.mat')

% calculate w, b with hingequad
Xtw1 = reshape(Xtwqr561,[11,600]);
Ytw1 = reshape(Ytwqr561,[600,1]);
Wbhq = zeros(12,length(lambda));
for l = 1:length(lambda)
    Wbhq(:,l) = postpro_wb_class_hingequad_qp(Xtw1,Ytw1,lambda(l));
end
Whq = Wbhq(1:11,:);
bhq = Wbhq(12,:);

errhqm = zeros(1,length(lambda));
errhqh = zeros(1,length(lambda));
errhqhq = zeros(1,length(lambda)); 

% caculate the error for the different loss functions
for l = 1:length(lambda)
    errhqm(l) = postpro_err_misclass(Whq(:,l),bhq(l),Xvwqr561,Yvwqr561);
    errhqh(l) = postpro_err_hinge(Whq(:,l),bhq(l),Xvwqr561,Yvwqr561);
    errhqhq(l) = postpro_err_hingequad(Whq(:,l),bhq(l),Xvwqr561,Yvwqr561);
end

% plot
figure
hold on
title('inner level: hingequad','Interpreter','latex')
plot(lambda,100*errhqm,'m')
plot(lambda,100*errhqh,'b')
plot(lambda,100*errhqhq,'c')
legend('Misclassification loss','Hingeloss','Hingequad')
