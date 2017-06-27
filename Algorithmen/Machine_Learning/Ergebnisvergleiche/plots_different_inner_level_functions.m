% Comparison inner level functions

load('Validation Data/Cancer.mat')
load('Training Data/Cancer.mat')

% lambda values
lambda = logspace(-15,3,100);

% calculate w, b with hingeloss
Xtc1 = reshape(Xtcancer1,[9,240]);
Ytc1 = reshape(Ytcancer1,[240,1]);
Wbh = zeros(10,length(lambda));
for l = 1:length(lambda)
    Wbh(:,l) = postpro_wb_class_hinge_qp(Xtc1,Ytc1,lambda(l));
end
Wh = Wbh(1:9,:);
bh = Wbh(10,:);

% calculate w, b with hingequad
Wbhq = zeros(10,length(lambda));
for l = 1:length(lambda)
    Wbhq(:,l) = postpro_wb_class_hingequad_qp(Xtc1,Ytc1,lambda(l));
end
Whq = Wbhq(1:9,:);
bhq = Wbhq(10,:);

errhm = zeros(1,length(lambda));
errhh = zeros(1,length(lambda));
errhhq = zeros(1,length(lambda));

errhqm = zeros(1,length(lambda));
errhqh = zeros(1,length(lambda));
errhqhq = zeros(1,length(lambda)); 
% caculate the error for the different loss functions
for l = 1:length(lambda)
    errhm(l) = postpro_err_misclass(Wh(:,l),bh(l),Xvcancer1,Yvcancer1);
    errhh(l) = postpro_err_hinge(Wh(:,l),bh(l),Xvcancer1,Yvcancer1);
    errhhq(l) = postpro_err_hingequad(Wh(:,l),bh(l),Xvcancer1,Yvcancer1);
    errhqm(l) = postpro_err_misclass(Whq(:,l),bhq(l),Xvcancer1,Yvcancer1);
    errhqh(l) = postpro_err_hinge(Whq(:,l),bhq(l),Xvcancer1,Yvcancer1);
    errhqhq(l) = postpro_err_hingequad(Whq(:,l),bhq(l),Xvcancer1,Yvcancer1);
end

% plots
figure
hold on
title('inner level: hingeloss','Interpreter','latex')
plot(lambda,errhm,'m')
plot(lambda,errhh,'b')
plot(lambda,errhhq,'c')
legend('Misclassification loss','Hingeloss','Hingequad')

figure
hold on
title('inner level: hingequad','Interpreter','latex')
plot(lambda,errhqm,'m')
plot(lambda,errhqh,'b')
plot(lambda,errhqhq,'c')
legend('Misclassification loss','Hingeloss','Hingequad')