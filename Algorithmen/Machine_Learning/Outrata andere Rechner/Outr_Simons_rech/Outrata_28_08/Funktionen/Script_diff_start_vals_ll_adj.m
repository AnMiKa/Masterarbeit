% Script: calculate optima for different starting points
% with both bundle methods and fminbd

% startin value
C = 1;

% all sets already loaded

%% Hare Algorithm
% Preallocation for C, fval, time, steps, null steps

CminH = zeros(5,1);
fvalH = zeros(5,1);
timeH = zeros(5,1);
stepsH = zeros(5,1);
nullstepsH = zeros(5,1);
eta_maxH = zeros(5,1);

[fvalH(1),CminH(1),stepsH(1),nullstepsH(1),timeH(1),eta_maxH(1)] =...
    bundle_bilevel_outr(C,Xtcan,Ytcan,2000,1e-6);
[fvalH(2),CminH(2),stepsH(2),nullstepsH(2),timeH(2),eta_maxH(2)] =...
    bundle_bilevel_outr(C,Xtion,Ytion,2000,1e-6);
[fvalH(3),CminH(3),stepsH(3),nullstepsH(3),timeH(3),eta_maxH(3)] =...
    bundle_bilevel_outr(C,Xtbox,Ytbox,2000,1e-6);
[fvalH(4),CminH(4),stepsH(4),nullstepsH(4),timeH(4),eta_maxH(4)] =...
    bundle_bilevel_outr(C,Xtsys,Ytsys,2000,1e-6);
[fvalH(5),CminH(5),stepsH(5),nullstepsH(5),timeH(5),eta_maxH(5)] =...
    bundle_bilevel_outr(C,Xtsyb,Ytsyb,1000,1e-6);

%% Noll Algorithm
% Preallocation for C, fval, time, steps, null steps

CminN = zeros(5,1);
fvalN = zeros(5,1);
timeN = zeros(5,1);
stepsN = zeros(5,1);
nullstepsN = zeros(5,1);
eta_maxN = zeros(5,1);

[fvalN(1),CminN(1),stepsN(1),nullstepsN(1),timeN(1),eta_maxN(1)] =...
    bundle_bilevel_outr_noll(C,Xtcan,Ytcan,1,1000,1e-6);
[fvalN(2),CminN(2),stepsN(2),nullstepsN(2),timeN(2),eta_maxN(2)] =...
    bundle_bilevel_outr_noll(C,Xtion,Ytion,1,1000,1e-6);
[fvalN(3),CminN(3),stepsN(3),nullstepsN(3),timeN(3),eta_maxN(3)] =...
    bundle_bilevel_outr_noll(C,Xtbox,Ytbox,1,1000,1e-6);
[fvalN(4),CminN(4),stepsN(4),nullstepsN(4),timeN(4),eta_maxN(4)] =...
    bundle_bilevel_outr_noll(C,Xtsys,Ytsys,1,1000,1e-6);
[fvalN(5),CminN(5),stepsN(5),nullstepsN(5),timeN(5),eta_maxN(5)] =...
    bundle_bilevel_outr_noll(C,Xtsyb,Ytsyb,1,1000,1e-6);

%% nullachtfunfzeh-part
% obj_fun1 = @(C) overall_obj(C,Xtcan,Ytcan);
% obj_fun2 = @(C) overall_obj(C,Xtion,Ytion);
% obj_fun3 = @(C) overall_obj(C,Xtbox,Ytbox);
% obj_fun4 = @(C) overall_obj(C,Xtsys,Ytsys);
% obj_fun5 = @(C) overall_obj(C,Xtsyb,Ytsyb);
% 
% options = optimset('Tolfun',1e-6,'TolX',1e-6);
% 
% % fminbound
% CminMB = zeros(5,1);
% fvalMB = zeros(5,1);
% timeMB = zeros(5,1);
% [CminMB(1),timeMB(1),fvalMB(1)] = nullachtfunfzehn(obj_fun1);
% [CminMB(2),timeMB(2),fvalMB(2)] = nullachtfunfzehn(obj_fun2);
% [CminMB(3),timeMB(3),fvalMB(3)] = nullachtfunfzehn(obj_fun3);
% [CminMB(4),timeMB(4),fvalMB(4)] = nullachtfunfzehn(obj_fun4);
% [CminMB(5),timeMB(5),fvalMB(5)] = nullachtfunfzehn(obj_fun5);
