% Script: calculate optima for different starting points
% with both bundle methods and fminbd, fminsearch

% startin values
C = [1e-5, 0.01, 1, 20, 100];

% all sets already loaded

% Hare Algorithm
% Preallocation for C, fval, time, steps, null steps

CminH = zeros(5);
fvalH = zeros(5);
timeH = zeros(5);
stepsH = zeros(5);
nullstepsH = zeros(5);
eta_maxH = zeros(5);

for c = 1:length(C)
    [fvalH(1,c),CminH(1,c),stepsH(1,c),nullstepsH(1,c),timeH(1,c),eta_maxH(1,c)] =...
        bundle_bilevel_outr(C(c),Xtcan,Ytcan,10000,1e-10);
    [fvalH(2,c),CminH(2,c),stepsH(2,c),nullstepsH(2,c),timeH(2,c),eta_maxH(1,c)] =...
        bundle_bilevel_outr(C(c),Xtion,Ytion,10000,1e-10);
    [fvalH(3,c),CminH(3,c),stepsH(3,c),nullstepsH(3,c),timeH(3,c),eta_maxH(1,c)] =...
        bundle_bilevel_outr(C(c),Xtbox,Ytbox,10000,1e-10);
    [fvalH(4,c),CminH(4,c),stepsH(4,c),nullstepsH(4,c),timeH(4,c),eta_maxH(1,c)] =...
        bundle_bilevel_outr(C(c),Xtsys,Ytsys,10000,1e-10);
    [fvalH(5,c),CminH(5,c),stepsH(5,c),nullstepsH(5,c),timeH(5,c),eta_maxH(1,c)] =...
        bundle_bilevel_outr(C(c),Xtsyb,Ytsyb,10000,1e-10);
end

% Noll Algorithm
% Preallocation for C, fval, time, steps, null steps

CminN = zeros(5);
fvalN = zeros(5);
timeN = zeros(5);
stepsN = zeros(5);
nullstepsN = zeros(5);
eta_maxN = zeros(5);

for c = 1:length(C)
    [fvalN(1,c),CminN(1,c),stepsN(1,c),nullstepsN(1,c),timeN(1,c),eta_maxN(1,c)] =...
        bundle_bilevel_outr_noll(C(c),Xtcan,Ytcan,1,10000,1e-10);
    [fvalN(2,c),CminN(2,c),stepsN(2,c),nullstepsN(2,c),timeN(2,c),eta_maxN(1,c)] =...
        bundle_bilevel_outr_noll(C(c),Xtion,Ytion,1,10000,1e-10);
    [fvalN(3,c),CminN(3,c),stepsN(3,c),nullstepsN(3,c),timeN(3,c),eta_maxN(1,c)] =...
        bundle_bilevel_outr_noll(C(c),Xtbox,Ytbox,1,10000,1e-10);
    [fvalN(4,c),CminN(4,c),stepsN(4,c),nullstepsN(4,c),timeN(4,c),eta_maxN(1,c)] =...
        bundle_bilevel_outr_noll(C(c),Xtsys,Ytsys,1,10000,1e-10);
    [fvalN(5,c),CminN(5,c),stepsN(5,c),nullstepsN(5,c),timeN(5,c),eta_maxN(1,c)] =...
        bundle_bilevel_outr_noll(C(c),Xtsyb,Ytsyb,1,10000,1e-10);
end

%% nullachtfunfzeh-part
obj_fun1 = @(C) overall_obj(C,Xtcan,Ytcan);
obj_fun2 = @(C) overall_obj(C,Xtion,Ytion);
obj_fun3 = @(C) overall_obj(C,Xtbox,Ytbox);
obj_fun4 = @(C) overall_obj(C,Xtsys,Ytsys);
obj_fun5 = @(C) overall_obj(C,Xtsyb,Ytsyb);

options = optimset('Tolfun',1e-10,'TolX',1e-10);

% fminsearch
CminMS = zeros(5);
fvalMS = zeros(5);
timeMS = zeros(5);
for c = 1:length(C)
    [CminMS(1,c),timeMS(1,c),fvalMS(1,c)] = nullachtfunfzehn(obj_fun1,C(c));
    [CminMS(2,c),timeMS(2,c),fvalMS(2,c)] = nullachtfunfzehn(obj_fun2,C(c));
    [CminMS(3,c),timeMS(3,c),fvalMS(3,c)] = nullachtfunfzehn(obj_fun3,C(c));
    [CminMS(4,c),timeMS(4,c),fvalMS(4,c)] = nullachtfunfzehn(obj_fun4,C(c));
    [CminMS(5,c),timeMS(5,c),fvalMS(5,c)] = nullachtfunfzehn(obj_fun5,C(c));
end


% fminbound
CminMB = zeros(5,1);
fvalMB = zeros(5,1);
timeMB = zeros(5,1);
[CminMB(1),timeMB(1),fvalMB(1)] = nullachtfunfzehn(obj_fun1);
[CminMB(2),timeMB(2),fvalMB(2)] = nullachtfunfzehn(obj_fun2);
[CminMB(3),timeMB(3),fvalMB(3)] = nullachtfunfzehn(obj_fun3);
[CminMB(4),timeMB(4),fvalMB(4)] = nullachtfunfzehn(obj_fun4);
[CminMB(5),timeMB(5),fvalMB(5)] = nullachtfunfzehn(obj_fun5);
