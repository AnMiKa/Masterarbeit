Xtcan1 = Xtcan(1:9,:,:);
Xtcan2 = Xtcan1 + 3*rand(9,80,3)-1.5;
% Xtcan3 = Xtcan1 + 0.01*rand(2,80,4)-0.005;
% Xtcan4 = Xtcan1 + 0.2*rand(2,80,4)-0.1;

Xtcan2_std = standardize_data(reshape(Xtcan2,9,80*3),0,1);
% Xtcan3_std = standardize_data(reshape(Xtcan3,2,80*4),0,1);
% Xtcan4_std = standardize_data(reshape(Xtcan4,2,80*3),0,1);

Xtcan2_std = reshape(Xtcan2_std,9,80,3);
% Xtcan3_std = reshape(Xtcan3_std,2,80,4);
% Xtcan4_std = reshape(Xtcan4_std,2,80,4);

Xtcan2_b = zeros(10,80,3);
Xtcan2_b(:,:,1) = [Xtcan2_std(:,:,1);ones(1,80)];
Xtcan2_b(:,:,2) = [Xtcan2_std(:,:,2);ones(1,80)];
Xtcan2_b(:,:,3) = [Xtcan2_std(:,:,3);ones(1,80)];
% Xtcan2_b(:,:,4) = [Xtcan2_std(:,:,4);ones(1,80)];

% Xtcan3_b = zeros(3,80,4);
% Xtcan3_b(:,:,1) = [Xtcan3_std(:,:,1);ones(1,80)];
% Xtcan3_b(:,:,2) = [Xtcan3_std(:,:,2);ones(1,80)];
% Xtcan3_b(:,:,3) = [Xtcan3_std(:,:,3);ones(1,80)];
% Xtcan3_b(:,:,4) = [Xtcan3_std(:,:,4);ones(1,80)];

% Xtcan4_b = zeros(3,80,4);
% Xtcan4_b(:,:,1) = [Xtcan4_std(:,:,1);ones(1,80)];
% Xtcan4_b(:,:,2) = [Xtcan4_std(:,:,2);ones(1,80)];
% Xtcan4_b(:,:,4) = [Xtcan4_std(:,:,4);ones(1,80)];

Xtcang3 = zeros(10,80,3,2);
Xtcang3(:,:,:,1) = Xtcan;
Xtcang3(:,:,:,2) = Xtcan2_b;
% Xtcang(:,:,:,3) = Xtcan3_b;
% Xtcang(:,:,:,4) = Xtcan4_b;

Ytcang3 = zeros(80,3,2);
Ytcang3(:,:,1) = Ytcan;
Ytcang3(:,:,2) = Ytcan;
% Ytcang(:,:,3) = Ytcan;
% Ytcang(:,:,4) = Ytcan;
