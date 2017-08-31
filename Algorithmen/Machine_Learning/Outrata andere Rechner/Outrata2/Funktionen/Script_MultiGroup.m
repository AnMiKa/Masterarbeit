% Script calculate minima MultiGroup
% with both bundle methods and fmincon

% starting values (for the different groups)
C2 = [5;0.5];
C3 = [5;0.5;0.05];
C4 = [5;0.5;0.05;1];

% all sets already loaded

%% Hare Algorithm
% Preallocation for C, fval, time, steps, null steps

CminH = zeros(4,8);
fvalH = zeros(8,1);
timeH = zeros(8,1);
stepsH = zeros(8,1);
nullstepsH = zeros(8,1);
eta_maxH = zeros(8,1);

[fvalH(1),CminH(:,1),stepsH(1),nullstepsH(1),timeH(1),eta_maxH(1)] =...
    bundle_bilevel_outr(C4,Xtcang_1,Ytcang_1,1000,1e-8);
[fvalH(2),CminH(1:2,2),stepsH(2),nullstepsH(2),timeH(2),eta_maxH(2)] =...
    bundle_bilevel_outr(C2,Xtcang_2,Ytcang_2,1000,1e-8);
[fvalH(3),CminH(1:2,3),stepsH(3),nullstepsH(3),timeH(3),eta_maxH(3)] =...
    bundle_bilevel_outr(C2,Xtcang_3,Ytcang_3,1000,1e-8);
[fvalH(4),CminH(1:3,4),stepsH(4),nullstepsH(4),timeH(4),eta_maxH(4)] =...
    bundle_bilevel_outr(C3,Xtcang_4,Ytcang_4,1000,1e-8);
[fvalH(5),CminH(:,5),stepsH(5),nullstepsH(5),timeH(5),eta_maxH(5)] =...
    bundle_bilevel_outr(C4,Xtiong_1,Ytiong_1,1000,1e-8);
[fvalH(6),CminH(1:2,6),stepsH(6),nullstepsH(6),timeH(6),eta_maxH(6)] =...
    bundle_bilevel_outr(C2,Xtiong_2,Ytiong_2,1000,1e-8);
[fvalH(7),CminH(1:3,7),stepsH(7),nullstepsH(7),timeH(7),eta_maxH(7)] =...
    bundle_bilevel_outr(C3,Xtsysg,Ytsysg,1000,1e-8);
[fvalH(8),CminH(1:3,8),stepsH(8),nullstepsH(8),timeH(8),eta_maxH(8)] =...
    bundle_bilevel_outr(C3,Xtboxg,Ytboxg,1000,1e-8);


%% Noll Algorithm
% Preallocation for C, fval, time, steps, null steps

CminN = zeros(4,8);
fvalN = zeros(8,1);
timeN = zeros(8,1);
stepsN = zeros(8,1);
nullstepsN = zeros(8,1);
eta_maxN = zeros(8,1);

[fvalN(1),CminN(:,1),stepsN(1),nullstepsN(1),timeN(1),eta_maxN(1)] =...
    bundle_bilevel_outr_noll(C4,Xtcang_1,Ytcang_1,1,1000,1e-8);
[fvalN(2),CminN(1:2,2),stepsN(2),nullstepsN(2),timeN(2),eta_maxN(2)] =...
    bundle_bilevel_outr_noll(C2,Xtcang_2,Ytcang_2,1,1000,1e-8);
[fvalN(3),CminN(1:2,3),stepsN(3),nullstepsH(3),timeN(3),eta_maxN(3)] =...
    bundle_bilevel_outr_noll(C2,Xtcang_3,Ytcang_3,1,1000,1e-8);
[fvalN(4),CminN(1:3,4),stepsN(4),nullstepsN(4),timeN(4),eta_maxN(4)] =...
    bundle_bilevel_outr_noll(C3,Xtcang_4,Ytcang_4,1,1000,1e-8);
[fvalN(5),CminN(:,5),stepsN(5),nullstepsN(5),timeN(5),eta_maxN(5)] =...
    bundle_bilevel_outr_noll(C4,Xtiong_1,Ytiong_1,1,1000,1e-8);
[fvalN(6),CminN(1:2,6),stepsN(6),nullstepsN(6),timeN(6),eta_maxN(6)] =...
    bundle_bilevel_outr_noll(C2,Xtiong_2,Ytiong_2,1,1000,1e-8);
[fvalN(7),CminN(1:3,7),stepsN(7),nullstepsN(7),timeN(7),eta_maxN(7)] =...
    bundle_bilevel_outr_noll(C3,Xtsysg,Ytsysg,1,1000,1e-8);
[fvalN(8),CminN(1:3,8),stepsN(8),nullstepsN(8),timeN(8),eta_maxN(8)] =...
    bundle_bilevel_outr_noll(C3,Xtboxg,Ytboxg,1,1000,1e-8);

%% nullachtfunfzehn
% 
% obj_fun1 = @(C) overall_obj(C,Xtcang_1,Ytcang_1);
% obj_fun2 = @(C) overall_obj(C,Xtcang_2,Ytcang_2);
% obj_fun3 = @(C) overall_obj(C,Xtcang_3,Ytcang_3);
% obj_fun4 = @(C) overall_obj(C,Xtcang_4,Ytcang_4);
% obj_fun5 = @(C) overall_obj(C,Xtiong_1,Ytiong_1);
% obj_fun6 = @(C) overall_obj(C,Xtiong_2,Ytiong_2);
% obj_fun7 = @(C) overall_obj(C,Xtsysg,Ytsysg);
% obj_fun8 = @(C) overall_obj(C,Xtboxg,Ytboxg);
% 
% 
% % fminsearch
% CminMS = zeros(4,8);
% fvalMS = zeros(8,1);
% timeMS = zeros(8,1);
% [CminMS(:,1),timeMS(1),fvalMS(1)] = nullachtfunfzehn_group(obj_fun1,C4);
% [CminMS(1:2,2),timeMS(2),fvalMS(2)] = nullachtfunfzehn_group(obj_fun2,C2);
% [CminMS(1:2,3),timeMS(3),fvalMS(3)] = nullachtfunfzehn_group(obj_fun3,C2);
% [CminMS(1:3,4),timeMS(4),fvalMS(4)] = nullachtfunfzehn_group(obj_fun4,C3);
% [CminMS(:,5),timeMS(5),fvalMS(5)] = nullachtfunfzehn_group(obj_fun5,C4);
% [CminMS(1:2,6),timeMS(6),fvalMS(6)] = nullachtfunfzehn_group(obj_fun6,C2);
% [CminMS(1:3,7),timeMS(7),fvalMS(7)] = nullachtfunfzehn_group(obj_fun7,C3);
% [CminMS(1:3,8),timeMS(8),fvalMS(8)] = nullachtfunfzehn_group(obj_fun8,C3);
% 
% 
