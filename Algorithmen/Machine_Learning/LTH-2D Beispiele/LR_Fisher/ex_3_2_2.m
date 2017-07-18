%% Exercies 3.2.2

%% train logistic regression on the first three training sets
wl = zeros(3,3);
wl(:,1) = logisticreg(train1.X, train1.y);
wl(:,2) = logisticreg(train2.X, train2.y);
wl(:,3) = logisticreg(train3.X, train3.y);

% train fisher discriminant on the first three training sets
wf = zeros(3,3);
wf(:,1) = fisherdiscriminant(train1.X, train1.y);
wf(:,2) = fisherdiscriminant(train2.X, train2.y);
wf(:,3)= fisherdiscriminant(train3.X, train3.y);

%% test errors for each test set
el = zeros(1,3);
el(1) = errorrate(wl(:,1), test1);
el(2) = errorrate(wl(:,2), test2);
el(3) = errorrate(wl(:,3), test3);

ef = zeros(1,3);
ef(1) = errorrate(wf(:,1), test1);
ef(2) = errorrate(wf(:,2), test2);
ef(3) = errorrate(wf(:,3), test3);

%% plot data and desision boundaries of logistic regression and Fisher
% discriminant
tests = [test1, test2, test3];
hold on
for i =  1:3
    figure
    boundary([wl(:,i), wf(:,i)], tests(i));
end

hold off
