% Copyright 2015 The MathWorks, Inc.


%%
% Generate random numbers from a multivariate normal distribution with
% parameters |mu = [2,3]| and |sigma = [1,1.5;1.5,3]|.
% test set
mu1 = [2,3];
mu2 = [-1,9];
sigma = [1.5,1.5;1.5,3];
%rng default  % For reproducibility
%for different folds
folds = 3;
J = 5000;
rtX = zeros(2,2*J,folds);

for i = 1:folds
    rtX(:,1:J,i) = mvnrnd(mu1,sigma,J)';
    rtX(:,J+1:end,i) = mvnrnd(mu2,sigma,J)';
end
% rtv1 = mvnrnd(mu1,sigma,300)';
% rtv2 = mvnrnd(mu2,sigma,300)';
% for i = 1:folds
%     rtX(:,1:100,i) = rtv1(:,100*i-99:100*i);
%     rtX(:,101:200,i) = rtv2(:,100*i-99:100*i);
% end
rtY = [ones(J,3);-ones(J,3)];

% validation set
rv1 = mvnrnd(mu1,sigma,2*J);
rv2 = mvnrnd(mu2,sigma,2*J);
rvX = [rv1;rv2];
rvY = [ones(2*J,1);-ones(2*J,1)];

%%
% % Plot the random numbers
% % trainings set
% rtv1 = reshape(rtX(:,1:J,:),2,folds*J);
% rtv2 = reshape(rtX(:,J+1:end,:),2,folds*J);
% figure
% hold on
% plot(rtv1(1,:),rtv1(2,:),'+m',rtv2(1,:),rtv2(2,:),'ob')
% %axis([-4,8,-2,12])
% 
% %validation set
% figure
% plot(rv1(:,1),rv1(:,2),'+m',rv2(:,1),rv2(:,2),'ob')
% %axis([-4,8,-2,12])

% plot single folds
for i = 1:folds
    figure
    hold on
    plot(rtX(1,1:J,i),rtX(2,1:J,i),'+m',rtX(1,J+1:2*J,i),rtX(2,J+1:2*J,i),'ob')
    %plot(rtv1(1,100*i-99:i*100),rtX(2,100*i-99:i*100),'+m',rtv2(1,100*i-99:i*100),rtv2(2,100*i-99:i*100),'ob')
    %axis([-4,8,-2,12])
end