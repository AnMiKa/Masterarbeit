Xtbox1 = Xtbox(1:2,:,:);
Xtbox2 = Xtbox1 + 0.1*rand(2,200,4)-0.05;
Xtbox3 = Xtbox1 + 0.01*rand(2,200,4)-0.005;
% Xtbox4 = Xtbox1 + 0.2*rand(2,200,4)-0.1;

Xtbox2_std = standardize_data(reshape(Xtbox2,2,200*4),0,1);
Xtbox3_std = standardize_data(reshape(Xtbox3,2,200*4),0,1);
% Xtbox4_std = standardize_data(reshape(Xtbox4,2,200*3),0,1);

Xtbox2_std = reshape(Xtbox2_std,2,200,4);
Xtbox3_std = reshape(Xtbox3_std,2,200,4);
% Xtbox4_std = reshape(Xtbox4_std,2,200,4);

Xtbox2_b = zeros(3,200,4);
Xtbox2_b(:,:,1) = [Xtbox2_std(:,:,1);ones(1,200)];
Xtbox2_b(:,:,2) = [Xtbox2_std(:,:,2);ones(1,200)];
Xtbox2_b(:,:,3) = [Xtbox2_std(:,:,3);ones(1,200)];
Xtbox2_b(:,:,4) = [Xtbox2_std(:,:,4);ones(1,200)];

Xtbox3_b = zeros(3,200,4);
Xtbox3_b(:,:,1) = [Xtbox3_std(:,:,1);ones(1,200)];
Xtbox3_b(:,:,2) = [Xtbox3_std(:,:,2);ones(1,200)];
Xtbox3_b(:,:,3) = [Xtbox3_std(:,:,3);ones(1,200)];
Xtbox3_b(:,:,4) = [Xtbox3_std(:,:,4);ones(1,200)];

% Xtbox4_b = zeros(3,200,4);
% Xtbox4_b(:,:,1) = [Xtbox4_std(:,:,1);ones(1,200)];
% Xtbox4_b(:,:,2) = [Xtbox4_std(:,:,2);ones(1,200)];
% Xtbox4_b(:,:,4) = [Xtbox4_std(:,:,4);ones(1,200)];

Xtboxg = zeros(3,200,4,3);
Xtboxg(:,:,:,1) = Xtbox1;
Xtboxg(:,:,:,2) = Xtbox2_b;
Xtboxg(:,:,:,3) = Xtbox3_b;
% Xtboxg(:,:,:,4) = Xtbox4_b;

Ytboxg = zeros(200,4,3);
Ytboxg(:,:,1) = Ytbox;
Ytboxg(:,:,2) = Ytbox;
Ytboxg(:,:,3) = Ytbox;
% Ytboxg(:,:,4) = Ytbox;
