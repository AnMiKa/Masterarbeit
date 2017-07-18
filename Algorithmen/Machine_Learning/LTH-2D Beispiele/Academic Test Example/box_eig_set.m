%%
% Generate random numbers
%rng default  % For reproducibility

%for different folds
folds = 4;

Xbox11 = [reshape(3*rand(10),1,100);reshape(rand(10),1,100)];
Xbox21 = [reshape(3*rand(10),1,100);reshape(rand(10),1,100)+1];

Xbox12 = [reshape(3*rand(10),1,100);reshape(rand(10),1,100)];
Xbox22 = [reshape(3*rand(10),1,100);reshape(rand(10),1,100)+0.98];

Xbox13 = [reshape(3*rand(10),1,100);reshape(rand(10),1,100)];
Xbox23 = [reshape(3*rand(10),1,100);reshape(rand(10),1,100)+0.4];

Xbox14 = [reshape(3*rand(10),1,100);reshape(rand(10),1,100)];
Xbox24 = [reshape(3*rand(10),1,100);reshape(rand(10),1,100)+0.7];

Xbox5 = zeros(2,200,4);
Xbox5(:,:,1) = [Xbox11,Xbox21];
Xbox5(:,:,2) = [Xbox12,Xbox22];
Xbox5(:,:,3) = [Xbox13,Xbox23];
Xbox5(:,:,4) = [Xbox14,Xbox24];

Ybox5 = [ones(100,4);-ones(100,4)];


% % plot single folds
% for i = 1:folds
%      figure
%      hold on
%      plot(Xbox3(1,1:100,i),Xbox3(2,101:200,i),'+m',Xbox3(1,101:200,i),Xbox3(2,1:100,i),'ob')
%      %plot(rtv1(1,100*i-99:i*100),rtX(2,100*i-99:i*100),'+m',rtv2(1,100*i-99:i*100),rtv2(2,100*i-99:i*100),'ob')
%      axis([-1,4,-1,4])
% end
