%% Exercies 3.2.5

%% train models on training set train3
wl_3 = logisticreg(train3.X, train3.y);
wf_3 = fisherdiscriminant(train3.X, train3.y);

%% train models on training set train4
wl_4 = logisticreg(train4.X, train4.y);
wf_4 = fisherdiscriminant(train4.X, train4.y);

%% Compute the error rates
el_3_tr = errorrate(wl_3, train3);
el_3_te = errorrate(wl_3, test3);
el_4_tr = errorrate(wl_4, train4);
el_4_te = errorrate(wl_4, test4);

ef_3_tr = errorrate(wf_3, train3);
ef_3_te = errorrate(wf_3, test3);
ef_4_tr = errorrate(wf_4, train4);
ef_4_te = errorrate(wf_4, test4);

E = [el_3_tr, ef_3_tr; el_3_te, ef_3_te; el_4_tr, ef_4_tr; el_4_te, ef_4_te];
