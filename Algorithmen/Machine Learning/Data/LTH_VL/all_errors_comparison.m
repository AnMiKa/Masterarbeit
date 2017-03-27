[el1, elh1, elm1] = all_errors(wl(:,1), test1);
[el2, elh2, elm2] = all_errors(wl(:,2), test2);
[el3, elh3, elm3] = all_errors(wl(:,3), test3);

[ef1, efh1, efm1] = all_errors(wf(:,1), test1);
[ef2, efh2, efm2] = all_errors(wf(:,2), test2);
[ef3, efh3, efm3] = all_errors(wf(:,3), test3);

[es1, esh1, esm1] = all_errors(ws(:,1), test1);
[es2, esh2, esm2] = all_errors(ws(:,2), test2);
[es3, esh3, esm3] = all_errors(ws(:,3), test3);

[esq1, esqh1, esqm1] = all_errors(wsq(:,1), test1);
[esq2, esqh2, esqm2] = all_errors(wsq(:,2), test2);
[esq3, esqh3, esqm3] = all_errors(wsq(:,3), test3);
