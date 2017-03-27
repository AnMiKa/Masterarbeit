%% logistic regression and fisher discriminant on Kunapuli data

es = zeros(1,4,20);
esh = zeros(1,4,20);
esm = zeros(1,4,20);
esq = zeros(1,4,20);
esqh = zeros(1,4,20);
esqm = zeros(1,4,20);

for l = 1:20
%% prepare the sets:
[pima_trainX,pima_trainY,pima_holdoutX,pima_holdoutY] =...
        precond_data(pima_standard_pm1,1,1:240,0);

[cancer_trainX,cancer_trainY,cancer_holdoutX,cancer_holdoutY] =...
        precond_data(cancer_standard_pm1,1,1:240,0);
    
[heart_trainX,heart_trainY,heart_holdoutX,heart_holdoutY] =...
        precond_data(heart_standard_pm1,1,1:216,0);
    
[ionosphere_trainX,ionosphere_trainY,ionosphere_holdoutX,ionosphere_holdoutY] =...
        precond_data(ionosphere_standard_pm1,1,1:240,0);
    
i = pima_trainY == -1;
pima_trainY(i) = 0;
i = cancer_trainY == -1;
cancer_trainY(i) = 0;
i = heart_trainY == -1;
heart_trainY(i) = 0;
i = ionosphere_trainY == -1;
ionosphere_trainY(i) = 0;
i = pima_holdoutY == -1;
pima_holdoutY(i) = 0;
i = cancer_holdoutY == -1;
cancer_holdoutY(i) = 0;
i = heart_holdoutY == -1;
heart_holdoutY(i) = 0;
i = ionosphere_holdoutY == -1;
ionosphere_holdoutY(i) = 0;
pima_trainX = pima_trainX';
pima_holdoutX = pima_holdoutX';
cancer_trainX = cancer_trainX';
cancer_holdoutX = cancer_holdoutX';
heart_trainX = heart_trainX';
heart_holdoutX = heart_holdoutX';
ionosphere_trainX = ionosphere_trainX';
ionosphere_holdoutX = ionosphere_holdoutX';


pimatrain = struct('X',pima_trainX,'y',pima_trainY);
pimaholdout = struct('X',pima_holdoutX,'y',pima_holdoutY);
cancertrain = struct('X',cancer_trainX,'y',cancer_trainY);
cancerholdout = struct('X',cancer_holdoutX,'y',cancer_holdoutY);
hearttrain = struct('X',heart_trainX,'y',heart_trainY);
heartholdout = struct('X',heart_holdoutX,'y',heart_holdoutY);
ionospheretrain = struct('X',ionosphere_trainX,'y',ionosphere_trainY);
ionosphereholdout = struct('X',ionosphere_holdoutX,'y',ionosphere_holdoutY);

%% train logistic regression on the first three training sets
% wlp = logisticreg(pimatrain.X, pimatrain.y);
% wlc = logisticreg(cancertrain.X, cancertrain.y);
% wlh = logisticreg(hearttrain.X, hearttrain.y);
% wli = logisticreg(ionospheretrain.X, ionospheretrain.y);

% train fisher discriminant on the first three training sets
% wfp = fisherdiscriminant(pimatrain.X, pimatrain.y);
% wfc = fisherdiscriminant(cancertrain.X, cancertrain.y);
% wfh = fisherdiscriminant(hearttrain.X, hearttrain.y);
% wfi = fisherdiscriminant(ionospheretrain.X, ionospheretrain.y);

% train support vector machine on forst three training sets -> hinge and
% hingequad
pimatrain.Y = pimatrain.y;
cancertrain.Y = cancertrain.y;
hearttrain.Y = hearttrain.y;
ionospheretrain.Y = ionospheretrain.y;
i = pimatrain.Y == 0;
pimatrain.Y(i) = -1;
i = cancertrain.Y == 0;
cancertrain.Y(i) = -1;
i = hearttrain.Y == 0;
hearttrain.Y(i) = -1;
i = ionospheretrain.Y == 0;
ionospheretrain.Y(i) = -1;
wsp = postpro_wb_class_hinge_qpas(pimatrain.X,pimatrain.Y,10);
wsqp = postpro_wb_class_hingequad_qpas(pimatrain.X,pimatrain.Y,10);
wsc = postpro_wb_class_hinge_qpas(cancertrain.X,cancertrain.Y,10);
wsqc = postpro_wb_class_hingequad_qpas(cancertrain.X,cancertrain.Y,10);
wsh = postpro_wb_class_hinge_qpas(hearttrain.X,hearttrain.Y,10);
wsqh = postpro_wb_class_hingequad_qpas(hearttrain.X,hearttrain.Y,10);
wsi = postpro_wb_class_hinge_qpas(ionospheretrain.X,ionospheretrain.Y,10);
wsqi = postpro_wb_class_hingequad_qpas(ionospheretrain.X,ionospheretrain.Y,10);

%% holdout errors for each holdout set
% el = zeros(1,4,20);
% el(1,1,l) = errorrate(wlp, pimaholdout);
% el(1,2,l) = errorrate(wlc, cancerholdout);
% el(1,3,l) = errorrate(wlh, heartholdout);
% el(1,4,l) = errorrate(wli, ionosphereholdout);

ef = zeros(1,4,20);
% ef(1,1,l) = errorrate(wfp, pimaholdout);
% ef(1,2,l) = errorrate(wfc, cancerholdout);
% ef(1,3,l) = errorrate(wfh, heartholdout);
% ef(1,4,l) = errorrate(wfi, ionosphereholdout);

% es = zeros(1,4,20);
es(1,1,l) = errorrate(wsp, pimaholdout);
es(1,2,l) = errorrate(wsc, cancerholdout);
es(1,3,l) = errorrate(wsh, heartholdout);
es(1,4,l) = errorrate(wsi, ionosphereholdout);

% esq = zeros(1,4,20);
esq(1,1,l) = errorrate(wsqp, pimaholdout);
esq(1,2,l) = errorrate(wsqc, cancerholdout);
esq(1,3,l) = errorrate(wsqh, heartholdout);
esq(1,4,l) = errorrate(wsqi, ionosphereholdout);

%% my errors for each holdout set

pimaholdout.Y = pimaholdout.y;
cancerholdout.Y = cancerholdout.y;
heartholdout.Y = heartholdout.y;
ionosphereholdout.Y = ionosphereholdout.y;
i = pimaholdout.Y == 0;
pimaholdout.Y(i) = -1;
i = cancerholdout.Y == 0;
cancerholdout.Y(i) = -1;
i = heartholdout.Y == 0;
heartholdout.Y(i) = -1;
i = ionosphereholdout.Y == 0;
ionosphereholdout.Y(i) = -1;

% elh = zeros(1,4,20);
% elh(1,1,l) = postpro_err_hinge(wlp(2:end), -wlp(1,1,l), pimaholdout.X, pimaholdout.Y);
% elh(1,2,l) = postpro_err_hinge(wlc(2:end), -wlc(1,1,l), cancerholdout.X, cancerholdout.Y);
% elh(1,3,l) = postpro_err_hinge(wlh(2:end), -wlh(1,1,l), heartholdout.X, heartholdout.Y);
% elh(1,4,l) = postpro_err_hinge(wli(2:end), -wli(1,1,l), ionosphereholdout.X, ionosphereholdout.Y);

% elm = zeros(1,4,20);
% elm(1,1,l) = postpro_err_misclass(wlp(2:end), -wlp(1), pimaholdout.X, pimaholdout.Y);
% elm(1,2,l) = postpro_err_misclass(wlc(2:end), -wlc(1), cancerholdout.X, cancerholdout.Y);
% elm(1,3,l) = postpro_err_misclass(wlh(2:end), -wlh(1), heartholdout.X, heartholdout.Y);
% elm(1,4,l) = postpro_err_misclass(wli(2:end), -wli(1), ionosphereholdout.X, ionosphereholdout.Y);

% efh = zeros(1,4,20);
% efh(1,1,l) = postpro_err_hinge(wfp(2:end), -wfp(1), pimaholdout.X, pimaholdout.Y);
% efh(1,2,l) = postpro_err_hinge(wfc(2:end), -wfc(1), cancerholdout.X, cancerholdout.Y);
% efh(1,3,l) = postpro_err_hinge(wfh(2:end), -wfh(1), heartholdout.X, heartholdout.Y);
% efh(1,4,l) = postpro_err_hinge(wfi(2:end), -wfi(1), ionosphereholdout.X, ionosphereholdout.Y);

% efm = zeros(1,4,20);
% efm(1,1,l) = postpro_err_misclass(wfp(2:end), -wfp(1), pimaholdout.X, pimaholdout.Y);
% efm(1,2,l) = postpro_err_misclass(wfc(2:end), -wfc(1), cancerholdout.X, cancerholdout.Y);
% efm(1,3,l) = postpro_err_misclass(wfh(2:end), -wfh(1), heartholdout.X, heartholdout.Y);
% efm(1,4,l) = postpro_err_misclass(wfi(2:end), -wfi(1), ionosphereholdout.X, ionosphereholdout.Y);

% esh = zeros(1,4,20);
esh(1,1,l) = postpro_err_hinge(wsp(2:end), -wsp(1), pimaholdout.X, pimaholdout.Y);
esh(1,2,l) = postpro_err_hinge(wsc(2:end), -wsc(1), cancerholdout.X, cancerholdout.Y);
esh(1,3,l) = postpro_err_hinge(wsh(2:end), -wsh(1), heartholdout.X, heartholdout.Y);
esh(1,4,l) = postpro_err_hinge(wsi(2:end), -wsi(1), ionosphereholdout.X, ionosphereholdout.Y);

% esm = zeros(1,4,20);
esm(1,1,l) = postpro_err_misclass(wsp(2:end), -wsp(1), pimaholdout.X, pimaholdout.Y);
esm(1,2,l) = postpro_err_misclass(wsc(2:end), -wsc(1), cancerholdout.X, cancerholdout.Y);
esm(1,3,l) = postpro_err_misclass(wsh(2:end), -wsh(1), heartholdout.X, heartholdout.Y);
esm(1,4,l) = postpro_err_misclass(wsi(2:end), -wsi(1), ionosphereholdout.X, ionosphereholdout.Y);

% esqh = zeros(1,4,20);
esqh(1,1,l) = postpro_err_hinge(wsqp(2:end), -wsqp(1), pimaholdout.X, pimaholdout.Y);
esqh(1,2,l) = postpro_err_hinge(wsqc(2:end), -wsqc(1), cancerholdout.X, cancerholdout.Y);
esqh(1,3,l) = postpro_err_hinge(wsqh(2:end), -wsqh(1), heartholdout.X, heartholdout.Y);
esqh(1,4,l) = postpro_err_hinge(wsqi(2:end), -wsqi(1), ionosphereholdout.X, ionosphereholdout.Y);

% esqm = zeros(1,4,20);
esqm(1,1,l) = postpro_err_misclass(wsqp(2:end), -wsqp(1), pimaholdout.X, pimaholdout.Y);
esqm(1,2,l) = postpro_err_misclass(wsqc(2:end), -wsqc(1), cancerholdout.X, cancerholdout.Y);
esqm(1,3,l) = postpro_err_misclass(wsqh(2:end), -wsqh(1), heartholdout.X, heartholdout.Y);
esqm(1,4,l) = postpro_err_misclass(wsqi(2:end), -wsqi(1), ionosphereholdout.X, ionosphereholdout.Y);

end

es = sum(es,3)./20;
esh = sum(esh,3)./20;
esm = sum(esm,3)./20;

esq = sum(esq,3)./20;
esqh = sum(esqh,3)./20;
esqm = sum(esqm,3)./20;