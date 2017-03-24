% script: test of the 4 available sets for comparison with Kunapuli results
tic
% times how often the experiment is done
times = 20;

%different lambda values
lambda = [0.1 1 10 100];

% preallocate the different training and holdout sets
pima_trainX = zeros(8,240,20);
pima_trainY = zeros(240,20);
pima_holdoutX = zeros(8,528,20);
pima_holdoutY = zeros(528,20);

cancer_trainX = zeros(10,240,20);
cancer_trainY = zeros(240,20);
cancer_holdoutX = zeros(10,443,20);
cancer_holdoutY = zeros(443,20);

heart_trainX = zeros(13,216,20);
heart_trainY = zeros(216,20);
heart_holdoutX = zeros(13,81,20);
heart_holdoutY = zeros(81,20);

ionosphere_trainX = zeros(33,240,20);
ionosphere_trainY = zeros(240,20);
ionosphere_holdoutX = zeros(33,111,20);
ionosphere_holdoutY = zeros(111,20);

% preallocate the different errors
pima_EH = zeros(1,4,20);
pima_EHQ = zeros(1,4,20);
pima_EM = zeros(1,4,20);
pima_EMQ = zeros(1,4,20);

cancer_EH = zeros(1,4,20);
cancer_EHQ = zeros(1,4,20);
cancer_EM = zeros(1,4,20);
cancer_EMQ = zeros(1,4,20);

heart_EH = zeros(1,4,20);
heart_EHQ = zeros(1,4,20);
heart_EM = zeros(1,4,20);
heart_EMQ = zeros(1,4,20);

ionosphere_EH = zeros(1,4,20);
ionosphere_EHQ = zeros(1,4,20);
ionosphere_EM = zeros(1,4,20);
ionosphere_EMQ = zeros(1,4,20);

% preallocate the w and b for different lambdas
pima_WBH = zeros(9,4,20);
pima_WBHQ = zeros(9,4,20);

cancer_WBH = zeros(11,4,20);
cancer_WBHQ = zeros(11,4,20);

heart_WBH = zeros(14,4,20);
heart_WBHQ = zeros(14,4,20);

ionosphere_WBH = zeros(34,4,20);
ionosphere_WBHQ = zeros(34,4,20);

for t = 1:times
    % precondition the data 20 times to get an average later
    [pima_trainX(:,:,t),pima_trainY(:,t),pima_holdoutX(:,:,t),pima_holdoutY(:,t)] =...
        precond_data(pima_standard_pm1,1,1:240,0);

    [cancer_trainX(:,:,t),cancer_trainY(:,t),cancer_holdoutX(:,:,t),cancer_holdoutY(:,t)] =...
        precond_data(cancer_standard_pm1,1,1:240,0);
    
    [heart_trainX(:,:,t),heart_trainY(:,t),heart_holdoutX(:,:,t),heart_holdoutY(:,t)] =...
        precond_data(heart_standard_pm1,1,1:216,0);
    
    [ionosphere_trainX(:,:,t),ionosphere_trainY(:,t),ionosphere_holdoutX(:,:,t),ionosphere_holdoutY(:,t)] =...
        precond_data(ionosphere_standard_pm1,1,1:240,0);
    
    % for the different values of lambda find w and b and then calculate
    % the different errors on the holdout sets
    for l = 1:length(lambda)
        % calculate w, b for the different lambdas
        pima_WBH(:,l,t) = postpro_wb_class_hinge_qpas(pima_trainX(:,:,t),pima_trainY(:,t),lambda(l));
        pima_WBHQ(:,l,t) = postpro_wb_class_hingequad_qpas(pima_trainX(:,:,t),pima_trainY(:,t),lambda(l));
        
        cancer_WBH(:,l,t) = postpro_wb_class_hinge_qpas(cancer_trainX(:,:,t),cancer_trainY(:,t),lambda(l));
        cancer_WBHQ(:,l,t) = postpro_wb_class_hingequad_qpas(cancer_trainX(:,:,t),cancer_trainY(:,t),lambda(l));
        
        heart_WBH(:,l,t) = postpro_wb_class_hinge_qpas(heart_trainX(:,:,t),heart_trainY(:,t),lambda(l));
        heart_WBHQ(:,l,t) = postpro_wb_class_hingequad_qpas(heart_trainX(:,:,t),heart_trainY(:,t),lambda(l));
        
        ionosphere_WBH(:,l,t) = postpro_wb_class_hinge_qpas(ionosphere_trainX(:,:,t),ionosphere_trainY(:,t),lambda(l));
        ionosphere_WBHQ(:,l,t) = postpro_wb_class_hingequad_qpas(ionosphere_trainX(:,:,t),ionosphere_trainY(:,t),lambda(l));

        % calculate different errors
        pima_EH(1,l,t) = postpro_err_hinge(pima_WBH(1:8,l,t),pima_WBH(9,l,t),pima_holdoutX(:,:,t),pima_holdoutY(:,t));
        pima_EHQ(1,l,t) = postpro_err_hinge(pima_WBHQ(1:8,l,t),pima_WBHQ(9,l,t),pima_holdoutX(:,:,t),pima_holdoutY(:,t));
        pima_EM(1,l,t) = postpro_err_misclass(pima_WBH(1:8,l,t),pima_WBH(9,l,t),pima_holdoutX(:,:,t),pima_holdoutY(:,t));
        pima_EMQ(1,l,t) = postpro_err_misclass(pima_WBHQ(1:8,l,t),pima_WBHQ(9,l,t),pima_holdoutX(:,:,t),pima_holdoutY(:,t));

        cancer_EH(1,l,t) = postpro_err_hinge(cancer_WBH(1:10,l,t),cancer_WBH(11,l,t),cancer_holdoutX(:,:,t),cancer_holdoutY(:,t));
        cancer_EHQ(1,l,t) = postpro_err_hinge(cancer_WBHQ(1:10,l,t),cancer_WBHQ(11,l,t),cancer_holdoutX(:,:,t),cancer_holdoutY(:,t));
        cancer_EM(1,l,t) = postpro_err_misclass(cancer_WBH(1:10,l,t),cancer_WBH(11,l,t),cancer_holdoutX(:,:,t),cancer_holdoutY(:,t));
        cancer_EMQ(1,l,t) = postpro_err_misclass(cancer_WBHQ(1:10,l,t),cancer_WBHQ(11,l,t),cancer_holdoutX(:,:,t),cancer_holdoutY(:,t));

        heart_EH(1,l,t) = postpro_err_hinge(heart_WBH(1:13,l,t),heart_WBH(14,l,t),heart_holdoutX(:,:,t),heart_holdoutY(:,t));
        heart_EHQ(1,l,t) = postpro_err_hinge(heart_WBHQ(1:13,l,t),heart_WBHQ(14,l,t),heart_holdoutX(:,:,t),heart_holdoutY(:,t));
        heart_EM(1,l,t) = postpro_err_misclass(heart_WBH(1:13,l,t),heart_WBH(14,l,t),heart_holdoutX(:,:,t),heart_holdoutY(:,t));
        heart_EMQ(1,l,t) = postpro_err_misclass(heart_WBHQ(1:13,l,t),heart_WBHQ(14,l,t),heart_holdoutX(:,:,t),heart_holdoutY(:,t));

        ionosphere_EH(1,l,t) = postpro_err_hinge(ionosphere_WBH(1:33,l,t),ionosphere_WBH(34,l,t),ionosphere_holdoutX(:,:,t),ionosphere_holdoutY(:,t));
        ionosphere_EHQ(1,l,t) = postpro_err_hinge(ionosphere_WBHQ(1:33,l,t),ionosphere_WBHQ(34,l,t),ionosphere_holdoutX(:,:,t),ionosphere_holdoutY(:,t));
        ionosphere_EM(1,l,t) = postpro_err_misclass(ionosphere_WBH(1:33,l,t),ionosphere_WBH(34,l,t),ionosphere_holdoutX(:,:,t),ionosphere_holdoutY(:,t));
        ionosphere_EMQ(1,l,t) = postpro_err_misclass(ionosphere_WBHQ(1:33,l,t),ionosphere_WBHQ(34,l,t),ionosphere_holdoutX(:,:,t),ionosphere_holdoutY(:,t));
    end
end

% calculate average error over all 20 times as well as minimum and maximum
% error
pima_min = min([pima_EH;pima_EHQ;pima_EM;pima_EMQ],[],3);
pima_max = max([pima_EH;pima_EHQ;pima_EM;pima_EMQ],[],3);
pima_EH = sum(pima_EH,3)
pima_EHQ = sum(pima_EHQ,3)
pima_EM = sum(pima_EM,3)
pima_EMQ = sum(pima_EMQ,3)
pima_p = pima_max-[pima_EH;pima_EHQ;pima_EM;pima_EMQ];
pima_m = pima_min-[pima_EH;pima_EHQ;pima_EM;pima_EMQ];

cancer_min = min([cancer_EH;cancer_EHQ;cancer_EM;cancer_EMQ],[],3);
cancer_max = max([cancer_EH;cancer_EHQ;cancer_EM;cancer_EMQ],[],3);
cancer_EH = sum(cancer_EH,3)
cancer_EHQ = sum(cancer_EHQ,3)
cancer_EM = sum(cancer_EM,3)
cancer_EMQ = sum(cancer_EMQ,3)
cancer_p = cancer_max-[cancer_EH;cancer_EHQ;cancer_EM;cancer_EMQ];
cancer_m = cancer_min-[cancer_EH;cancer_EHQ;cancer_EM;cancer_EMQ];

heart_min = min([heart_EH;heart_EHQ;heart_EM;heart_EMQ],[],3);
heart_max = max([heart_EH;heart_EHQ;heart_EM;heart_EMQ],[],3);
heart_EH = sum(heart_EH,3)
heart_EHQ = sum(heart_EHQ,3)
heart_EM = sum(heart_EM,3)
heart_EMQ = sum(heart_EMQ,3)
heart_p = heart_max-[heart_EH;heart_EHQ;heart_EM;heart_EMQ];
heart_m = heart_min-[heart_EH;heart_EHQ;heart_EM;heart_EMQ];

ionosphere_min = min([ionosphere_EH;ionosphere_EHQ;ionosphere_EM;ionosphere_EMQ],[],3);
ionosphere_max = max([ionosphere_EH;ionosphere_EHQ;ionosphere_EM;ionosphere_EMQ],[],3);
ionosphere_EH = sum(ionosphere_EH,3)
ionosphere_EHQ = sum(ionosphere_EHQ,3)
ionosphere_EM = sum(ionosphere_EM,3)
ionosphere_EMQ = sum(ionosphere_EMQ,3)
ionosphere_p = ionosphere_max-[ionosphere_EH;ionosphere_EHQ;ionosphere_EM;ionosphere_EMQ];
ionosphere_m = ionosphere_min-[ionosphere_EH;ionosphere_EHQ;ionosphere_EM;ionosphere_EMQ];

toc