% set up  random vectors of length 1, 2, 4, 8, 16 with values between -10
% and 10 as starting values
X0_1  = 20 * rand(1,5) - 10;
X0_2  = 20 * rand(2,5) - 10;
X0_4  = 20 * rand(4,5) - 10;
X0_8  = 20 * rand(8,5) - 10;
X0_16 = 20 * rand(16,5) - 10;

% tests are optimizing the norm-function
fun = @norm;
subgr_fun = @subgr_norm;

%% check minimization results

Res = zeros(5,4*length(X0_1));
i_table = zeros(20,4*length(X0_1));
for i = 1:length(X0_1)
    for j = 1:4;
       [f,~,ie,ig,ia, iam] = bundle_conv_test(X0_1(i),fun,subgr_fun,j);
       Res(1,4*i+j-4) = f;
       i_table(1:4,4*i+j-4) = [ie,ig,ia,iam]'; 
       
       [f,~,ie,ig,ia, iam] = bundle_conv_test(X0_2(:,i),fun,subgr_fun,j); 
       Res(2,4*i+j-4) = f;
       i_table(5:8,4*i+j-4) = [ie,ig,ia,iam]';
       
       [f,~,ie,ig,ia, iam] = bundle_conv_test(X0_4(:,i),fun,subgr_fun,j);
       Res(3,4*i+j-4) = f;
       i_table(9:12,4*i+j-4) = [ie,ig,ia, iam]';
     
       [f,~,ie,ig,ia, iam] = bundle_conv_test(X0_8(:,i),fun,subgr_fun,j);
       Res(4,4*i+j-4) = f;
       i_table(13:16,4*i+j-4) = [ie,ig,ia, iam]';

       [f,~,ie,ig,ia, iam] = bundle_conv_test(X0_16(:,i),fun,subgr_fun,j);
       Res(5,4*i+j-4) = f;
       i_table(17:20,4*i+j-4) = [ie,ig,ia, iam]';

    end
end
% for i = 1:length(X0_1); 
%     [f,~,ie,ig,ia, iam] = bundle_conv_test(X0_1(i),fun,subgr_fun);
%     Res(1,i) = f;
%     i_table(1:4,i) = [ie,ig,ia,iam]';
%     
%     %[f,~,ie,ig,ia, iam] = bundle_conv_sparse_test(X0_1(i),fun,subgr_fun);
%     %Res(2,i) = f;
%     %i_table(5:8,i) = [ie,ig,ia,iam]';
%     
%     [f,~,ie,ig,ia, iam] = bundle_conv_test(X0_2(:,i),fun,subgr_fun); 
%     Res(3,i) = f;
%     i_table(9:12,i) = [ie,ig,ia,iam]';
%     
%     %[f,~,ie,ig,ia, iam] = bundle_conv_sparse_test(X0_2(:,i),fun,subgr_fun);
%     %Res(4,i) = f;
%     %i_table(13:16,i) = [ie,ig,ia, iam]';
%     
%     [f,~,ie,ig,ia, iam] = bundle_conv_test(X0_4(:,i),fun,subgr_fun);
%     Res(5,i) = f;
%     i_table(17:20,i) = [ie,ig,ia, iam]';
%     
%     %[f,~,ie,ig,ia, iam] = bundle_conv_sparse_test(X0_4(:,i),fun,subgr_fun);
%     %Res(6,i) = f;
%     %i_table(21:24,i) = [ie,ig,ia, iam]';
%     
%     [f,~,ie,ig,ia, iam] = bundle_conv_test(X0_8(:,i),fun,subgr_fun);
%     Res(7,i) = f;
%     i_table(25:28,i) = [ie,ig,ia, iam]';
%    
%     %[f,~,ie,ig,ia, iam] = bundle_conv_sparse_test(X0_8(:,i),fun,subgr_fun);
%     %Res(8,i) = f;
%     %i_table(29:32,i) = [ie,ig,ia, iam]';
%    
%     [f,~,ie,ig,ia, iam] = bundle_conv_test(X0_16(:,i),fun,subgr_fun);
%     Res(9,i) = f;
%     i_table(33:36,i) = [ie,ig,ia, iam]';
%     
%     %[f,x,ie,ig,ia, iam] = bundle_conv_sparse_test(X0_16(:,i),fun,subgr_fun);
%     %Res(10,i) = f;
%     %i_table(37:40,i) = [ie,ig,ia, iam]';
%     
% end

i_max = max(i_table, [], 2);