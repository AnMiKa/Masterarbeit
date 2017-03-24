%% Exercies 3.2.2

% %% train logistic regression on the first three training sets
% wl = zeros(3,3);
% wl(:,1) = logisticreg(train1.X, train1.y);
% wl(:,2) = logisticreg(train2.X, train2.y);
% wl(:,3) = logisticreg(train3.X, train3.y);
% 
% % train fisher discriminant on the first three training sets
% wf = zeros(3,3);
% wf(:,1) = fisherdiscriminant(train1.X, train1.y);
% wf(:,2) = fisherdiscriminant(train2.X, train2.y);
% wf(:,3) = fisherdiscriminant(train3.X, train3.y);
% 
% % train support vector machine on forst three training sets -> hinge and
% % hingequad
% ws = zeros(3,3);
% wsq = zeros(3,3);
 train1.Y = train1.y;
 train2.Y = train2.y;
 train3.Y = train3.y;
 i = train1.Y == 0;
 train1.Y(i) = -1;
 i = train2.Y == 0;
 train2.Y(i) = -1;
 i = train3.Y == 0;
% train3.Y(i) = -1;
% ws(:,1) = postpro_wb_class_hinge_qpas(train1.X,train1.Y,10);
% wsq(:,1) = postpro_wb_class_hingequad_qpas(train1.X,train1.Y,10);
% ws(:,2) = postpro_wb_class_hinge_qpas(train2.X,train2.Y,10);
% wsq(:,2) = postpro_wb_class_hingequad_qpas(train2.X,train2.Y,10);
% ws(:,3) = postpro_wb_class_hinge_qpas(train3.X,train3.Y,10);
% wsq(:,3) = postpro_wb_class_hingequad_qpas(train3.X,train3.Y,10);

%% test errors for each test set
el = zeros(1,3);
el(1) = errorrate(wl(:,1), test1);
el(2) = errorrate(wl(:,2), test2);
el(3) = errorrate(wl(:,3), test3);

ef = zeros(1,3);
ef(1) = errorrate(wf(:,1), test1);
ef(2) = errorrate(wf(:,2), test2);
ef(3) = errorrate(wf(:,3), test3);

es = zeros(1,3);
es(1) = errorrate(ws(:,1), test1);
es(2) = errorrate(ws(:,2), test2);
es(3) = errorrate(ws(:,3), test3);

esq = zeros(1,3);
esq(1) = errorrate(ws(:,1), test1);
esq(2) = errorrate(ws(:,2), test2);
esq(3) = errorrate(ws(:,3), test3);

%% my errors for each test set

 test1.Y = test1.y;
 test2.Y = test2.y;
 test3.Y = test3.y;
 i = test1.Y == 0;
 test1.Y(i) = -1;
 i = test2.Y == 0;
 test2.Y(i) = -1;
 i = test3.Y == 0;
test3.Y(i) = -1;

elh = zeros(1,3);
elh(1) = postpro_err_hinge(wl(2:3,1), -wl(1,1), test1.X, test1.Y);
elh(2) = postpro_err_hinge(wl(2:3,2), -wl(1,2), test2.X, test2.Y);
elh(3) = postpro_err_hinge(wl(2:3,3), -wl(1,3), test3.X, test3.Y);

elm = zeros(1,3);
elm(1) = postpro_err_misclass(wl(2:3,1), -wl(1,1), test1.X, test1.Y);
elm(2) = postpro_err_misclass(wl(2:3,2), -wl(1,2), test2.X, test2.Y);
elm(3) = postpro_err_misclass(wl(2:3,3), -wl(1,3), test3.X, test3.Y);

efh = zeros(1,3);
efh(1) = postpro_err_hinge(wf(2:3,1), -wf(1,1), test1.X, test1.Y);
efh(2) = postpro_err_hinge(wf(2:3,2), -wf(1,2), test2.X, test2.Y);
efh(3) = postpro_err_hinge(wf(2:3,3), -wf(1,3), test3.X, test3.Y);

efm = zeros(1,3);
efm(1) = postpro_err_misclass(wf(2:3,1), -wf(1,1), test1.X, test1.Y);
efm(2) = postpro_err_misclass(wf(2:3,2), -wf(1,2), test2.X, test2.Y);
efm(3) = postpro_err_misclass(wf(2:3,3), -wf(1,3), test3.X, test3.Y);

esh = zeros(1,3);
esh(1) = postpro_err_hinge(ws(2:3,1), -ws(1,1), test1.X, test1.Y);
esh(2) = postpro_err_hinge(ws(2:3,2), -ws(1,2), test2.X, test2.Y);
esh(3) = postpro_err_hinge(ws(2:3,3), -ws(1,3), test3.X, test3.Y);

esm = zeros(1,3);
esm(1) = postpro_err_misclass(ws(2:3,1), -ws(1,1), test1.X, test1.Y);
esm(2) = postpro_err_misclass(ws(2:3,2), -ws(1,2), test2.X, test2.Y);
esm(3) = postpro_err_misclass(ws(2:3,3), -ws(1,3), test3.X, test3.Y);

esqh = zeros(1,3);
esqh(1) = postpro_err_hinge(wsq(2:3,1), -wsq(1,1), test1.X, test1.Y);
esqh(2) = postpro_err_hinge(wsq(2:3,2), -wsq(1,2), test2.X, test2.Y);
esqh(3) = postpro_err_hinge(wsq(2:3,3), -wsq(1,3), test3.X, test3.Y);

esqm = zeros(1,3);
esqm(1) = postpro_err_misclass(wsq(2:3,1), -wsq(1,1), test1.X, test1.Y);
esqm(2) = postpro_err_misclass(wsq(2:3,2), -wsq(1,2), test2.X, test2.Y);
esqm(3) = postpro_err_misclass(wsq(2:3,3), -wsq(1,3), test3.X, test3.Y);

%% plot data and desision boundaries of logistic regression and Fisher
% discriminant
tests = [test1, test2, test3];
hold on
for i =  1:3
    boundary([wl(:,i), wf(:,i), ws(:,i), wsq(:,i)], tests(i));
    figure
end

hold off
