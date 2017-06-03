%% Exercies 3.2.4

%% train models on training set train1
wl_1 = logisticreg(train1.X, train1.y);
wf_1 = fisherdiscriminant(train1.X, train1.y);

%% train models on training set train1_2

wl_2 = logisticreg(train1_2.X, train1_2.y);
wf_2 = fisherdiscriminant(train1_2.X, train1_2.y);

%% Compute the error rates
el_1 = errorrate(wl_1, test1);
el_2 = errorrate(wl_2, test1);

ef_1 = errorrate(wf_1, test1);
ef_2 = errorrate(wf_2, test1);

E = [el_1, ef_1; el_2, ef_2];