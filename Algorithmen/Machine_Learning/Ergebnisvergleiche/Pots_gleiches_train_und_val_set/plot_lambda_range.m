% skript: find optimality intervall for lambda

% logarithmic scale
lambda = logspace(-15,4,1000);
%lambda = linspace(50,150,100);
% % pima
% [Xtp1,Ytp1, Xvp1, Yvp1] = precond_data(pima_standard_pm1,3,1:240,0);
% [Xtp2,Ytp2, Xvp2, Yvp2] = precond_data(pima_standard_pm1,3,1:240,0);
% [Xtp3,Ytp3, Xvp3, Yvp3] = precond_data(pima_standard_pm1,3,1:240,0);
% 
% errph1 = zeros(length(lambda),1);
% errph2 = zeros(length(lambda),1);
% errph3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errph1(l) = final_class_error_hingequad(lambda(l),Xvp1,Yvp1);
%     errph2(l) = final_class_error_hingequad(lambda(l),Xvp2,Yvp2);
%     errph3(l) = final_class_error_hingequad(lambda(l),Xvp3,Yvp3);
% 
%     %errph(l) = final_class_error_hingequad(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errph1,'b')
% plot(lambda,errph2,'c')
% plot(lambda,errph3,'m')
% 

% % wine red
% [Xtw1,Ytw1, Xvw1, Yvw1] = precond_data(winequalred_stand,3,1:600,0);
% [Xtw2,Ytw2, Xvw2, Yvw2] = precond_data(winequalred_stand,3,1:600,0);
% [Xtw3,Ytw3, Xvw3, Yvw3] = precond_data(winequalred_stand,3,1:600,0);
% 
% errwh1 = zeros(length(lambda),1);
% errwh2 = zeros(length(lambda),1);
% errwh3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errwh1(l) = final_class_error_hingequad(lambda(l),Xvw1,Yvw1);
%     errwh2(l) = final_class_error_hingequad(lambda(l),Xvw2,Yvw2);
%     errwh3(l) = final_class_error_hingequad(lambda(l),Xvw3,Yvw3);
% 
%     %errph(l) = final_class_error_hingequad(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errwh1,'b')
% plot(lambda,errwh2,'c')
% plot(lambda,errwh3,'m')

% % wine red 56
% [Xtw561,Ytw561, Xvw561, Yvw561] = precond_data(winequalred56_stand,3,1:600,0);
% [Xtw562,Ytw562, Xvw562, Yvw562] = precond_data(winequalred56_stand,3,1:600,0);
% [Xtw563,Ytw563, Xvw563, Yvw563] = precond_data(winequalred56_stand,3,1:600,0);
% 
% errw56h1 = zeros(length(lambda),1);
% errw56h2 = zeros(length(lambda),1);
% errw56h3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errw56h1(l) = final_class_error_hingequad(lambda(l),Xvw561,Yvw561);
%     errw56h2(l) = final_class_error_hingequad(lambda(l),Xvw562,Yvw562);
%     errw56h3(l) = final_class_error_hingequad(lambda(l),Xvw563,Yvw563);
% 
%     %errph(l) = final_class_error_hingequad(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errw56h1,'b')
% plot(lambda,errw56h2,'c')
% plot(lambda,errw56h3,'m')
 
% % covtype1000
% [Xtct1,Ytct1, Xvct1, Yvct1] = precond_data(covtype1000,3,1:600,0);
% [Xtct2,Ytct2, Xvct2, Yvct2] = precond_data(covtype1000,3,1:600,0);
% [Xtct3,Ytct3, Xvct3, Yvct3] = precond_data(covtype1000,3,1:600,0);
% 
% errcth1 = zeros(length(lambda),1);
% errcth2 = zeros(length(lambda),1);
% errcth3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errcth1(l) = final_class_error_hingequad(lambda(l),Xvct1,Yvct1);
%     errcth2(l) = final_class_error_hingequad(lambda(l),Xvct2,Yvct2);
%     errcth3(l) = final_class_error_hingequad(lambda(l),Xvct3,Yvct3);
% 
%     %errph(l) = final_class_error_hingequad(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errcth1,'b')
% plot(lambda,errcth2,'c')
% plot(lambda,errcth3,'m')

% % cancer
% [Xtc1,Ytc1, Xvc1, Yvc1] = precond_data(cancer_standard_pm1,3,1:240,0);
% [Xtc2,Ytc2, Xvc2, Yvc2] = precond_data(cancer_standard_pm1,3,1:240,0);
% [Xtc3,Ytc3, Xvc3, Yvc3] = precond_data(cancer_standard_pm1,3,1:240,0);
% 
% errch1 = zeros(length(lambda),1);
% errch2 = zeros(length(lambda),1);
% errch3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errch1(l) = final_class_error_hingequad(lambda(l),Xvc1,Yvc1);
%     errch2(l) = final_class_error_hingequad(lambda(l),Xvc2,Yvc2);
%     errch3(l) = final_class_error_hingequad(lambda(l),Xvc3,Yvc3);
% 
%     %errph(l) = final_class_error_hingequad(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errch1,'b')
% plot(lambda,errch2,'c')
% plot(lambda,errch3,'m')

% % ionosphere
% [Xti1,Yti1, Xvi1, Yvi1] = precond_data(ionosphere_standard_1stcolumn_pm1,3,1:240,0);
% [Xti2,Yti2, Xvi2, Yvi2] = precond_data(ionosphere_standard_1stcolumn_pm1,3,1:240,0);
% [Xti3,Yti3, Xvi3, Yvi3] = precond_data(ionosphere_standard_1stcolumn_pm1,3,1:240,0);
% 
% errih1 = zeros(length(lambda),1);
% errih2 = zeros(length(lambda),1);
% errih3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errih1(l) = final_class_error_hingequad(lambda(l),Xvi1,Yvi1);
%     errih2(l) = final_class_error_hingequad(lambda(l),Xvi2,Yvi2);
%     errih3(l) = final_class_error_hingequad(lambda(l),Xvi3,Yvi3);
% 
%     %errph(l) = final_class_error_hingequad(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errih1,'b')
% plot(lambda,errih2,'c')
% plot(lambda,errih3,'m')

% % heart
% [Xth1,Yth1, Xvh1, Yvh1] = precond_data(heart_standard_pm1,3,1:216,0);
% [Xth2,Yth2, Xvh2, Yvh2] = precond_data(heart_standard_pm1,3,1:216,0);
% [Xth3,Yth3, Xvh3, Yvh3] = precond_data(heart_standard_pm1,3,1:216,0);
% 
% errhh1 = zeros(length(lambda),1);
% errhh2 = zeros(length(lambda),1);
% errhh3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errhh1(l) = final_class_error_hingequad(lambda(l),Xvh1,Yvh1);
%     errhh2(l) = final_class_error_hingequad(lambda(l),Xvh2,Yvh2);
%     errhh3(l) = final_class_error_hingequad(lambda(l),Xvh3,Yvh3);
% 
%     %errph(l) = final_class_error_hingequad(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errhh1,'b')
% plot(lambda,errhh2,'c')
% plot(lambda,errhh3,'m')

% % pima
% [Xtp1,Ytp1, Xvp1, Yvp1] = precond_data(pima_standard_pm1,3,1:240,0);
% [Xtp2,Ytp2, Xvp2, Yvp2] = precond_data(pima_standard_pm1,3,1:240,0);
% [Xtp3,Ytp3, Xvp3, Yvp3] = precond_data(pima_standard_pm1,3,1:240,0);
% 
% errph1 = zeros(length(lambda),1);
% errph2 = zeros(length(lambda),1);
% errph3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errph1(l) = final_class_error_hingeloss(lambda(l),Xvp1,Yvp1);
%     errph2(l) = final_class_error_hingeloss(lambda(l),Xvp2,Yvp2);
%     errph3(l) = final_class_error_hingeloss(lambda(l),Xvp3,Yvp3);
% 
%     %errph(l) = final_class_error_hingeloss(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errph1,'b')
% plot(lambda,errph2,'c')
% plot(lambda,errph3,'m')
% 
% 
% % wine red
% [Xtw1,Ytw1, Xvw1, Yvw1] = precond_data(winequalred_stand,3,1:600,0);
% [Xtw2,Ytw2, Xvw2, Yvw2] = precond_data(winequalred_stand,3,1:600,0);
% [Xtw3,Ytw3, Xvw3, Yvw3] = precond_data(winequalred_stand,3,1:600,0);
% 
% errwh1 = zeros(length(lambda),1);
% errwh2 = zeros(length(lambda),1);
% errwh3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errwh1(l) = final_class_error_hingeloss(lambda(l),Xvw1,Yvw1);
%     errwh2(l) = final_class_error_hingeloss(lambda(l),Xvw2,Yvw2);
%     errwh3(l) = final_class_error_hingeloss(lambda(l),Xvw3,Yvw3);
% 
%     %errph(l) = final_class_error_hingeloss(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errwh1,'b')
% plot(lambda,errwh2,'c')
% plot(lambda,errwh3,'m')
% 
% % wine red 56
% [Xtw561,Ytw561, Xvw561, Yvw561] = precond_data(winequalred56_stand,3,1:600,0);
% [Xtw562,Ytw562, Xvw562, Yvw562] = precond_data(winequalred56_stand,3,1:600,0);
% [Xtw563,Ytw563, Xvw563, Yvw563] = precond_data(winequalred56_stand,3,1:600,0);
% 
% errw56h1 = zeros(length(lambda),1);
% errw56h2 = zeros(length(lambda),1);
% errw56h3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errw56h1(l) = final_class_error_hingeloss(lambda(l),Xvw561,Yvw561);
%     errw56h2(l) = final_class_error_hingeloss(lambda(l),Xvw562,Yvw562);
%     errw56h3(l) = final_class_error_hingeloss(lambda(l),Xvw563,Yvw563);
% 
%     %errph(l) = final_class_error_hingeloss(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errw56h1,'b')
% plot(lambda,errw56h2,'c')
% plot(lambda,errw56h3,'m')
%  
% % covtype1000
% [Xtct1,Ytct1, Xvct1, Yvct1] = precond_data(covtype1000,3,1:600,0);
% [Xtct2,Ytct2, Xvct2, Yvct2] = precond_data(covtype1000,3,1:600,0);
% [Xtct3,Ytct3, Xvct3, Yvct3] = precond_data(covtype1000,3,1:600,0);
% 
% errcth1 = zeros(length(lambda),1);
% errcth2 = zeros(length(lambda),1);
% errcth3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errcth1(l) = final_class_error_hingeloss(lambda(l),Xvct1,Yvct1);
%     errcth2(l) = final_class_error_hingeloss(lambda(l),Xvct2,Yvct2);
%     errcth3(l) = final_class_error_hingeloss(lambda(l),Xvct3,Yvct3);
% 
%     %errph(l) = final_class_error_hingeloss(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errcth1,'b')
% plot(lambda,errcth2,'c')
% plot(lambda,errcth3,'m')
% 
% % cancer
% [Xtc1,Ytc1, Xvc1, Yvc1] = precond_data(cancer_standard_pm1,3,1:240,0);
% [Xtc2,Ytc2, Xvc2, Yvc2] = precond_data(cancer_standard_pm1,3,1:240,0);
% [Xtc3,Ytc3, Xvc3, Yvc3] = precond_data(cancer_standard_pm1,3,1:240,0);
% 
% errch1 = zeros(length(lambda),1);
% errch2 = zeros(length(lambda),1);
% errch3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errch1(l) = final_class_error_hingeloss(lambda(l),Xvc1,Yvc1);
%     errch2(l) = final_class_error_hingeloss(lambda(l),Xvc2,Yvc2);
%     errch3(l) = final_class_error_hingeloss(lambda(l),Xvc3,Yvc3);
% 
%     %errph(l) = final_class_error_hingeloss(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errch1,'b')
% plot(lambda,errch2,'c')
% plot(lambda,errch3,'m')
% 
% % ionosphere
% [Xti1,Yti1, Xvi1, Yvi1] = precond_data(ionosphere_standard_1stcolumn_pm1,3,1:240,0);
% [Xti2,Yti2, Xvi2, Yvi2] = precond_data(ionosphere_standard_1stcolumn_pm1,3,1:240,0);
% [Xti3,Yti3, Xvi3, Yvi3] = precond_data(ionosphere_standard_1stcolumn_pm1,3,1:240,0);
% 
% errih1 = zeros(length(lambda),1);
% errih2 = zeros(length(lambda),1);
% errih3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errih1(l) = final_class_error_hingeloss(lambda(l),Xvi1,Yvi1);
%     errih2(l) = final_class_error_hingeloss(lambda(l),Xvi2,Yvi2);
%     errih3(l) = final_class_error_hingeloss(lambda(l),Xvi3,Yvi3);
% 
%     %errph(l) = final_class_error_hingeloss(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errih1,'b')
% plot(lambda,errih2,'c')
% plot(lambda,errih3,'m')
% 
% % heart
% [Xth1,Yth1, Xvh1, Yvh1] = precond_data(heart_standard_pm1,3,1:216,0);
% [Xth2,Yth2, Xvh2, Yvh2] = precond_data(heart_standard_pm1,3,1:216,0);
% [Xth3,Yth3, Xvh3, Yvh3] = precond_data(heart_standard_pm1,3,1:216,0);
% 
% errhh1 = zeros(length(lambda),1);
% errhh2 = zeros(length(lambda),1);
% errhh3 = zeros(length(lambda),1);
% 
% %errph = zeros(length(lambda),1);
% for l = 1:length(lambda)
%     errhh1(l) = final_class_error_hingeloss(lambda(l),Xvh1,Yvh1);
%     errhh2(l) = final_class_error_hingeloss(lambda(l),Xvh2,Yvh2);
%     errhh3(l) = final_class_error_hingeloss(lambda(l),Xvh3,Yvh3);
% 
%     %errph(l) = final_class_error_hingeloss(lambda(l),Xvp,Yvp);
% end
% 
% figure
% hold on 
% plot(lambda,errhh1,'b')
% plot(lambda,errhh2,'c')
% plot(lambda,errhh3,'m')

%% 
% %% 3 Repeats
% % pima
% Xtp = zeros(8,240,3);
% Ytp = zeros(240,3);
% [Xtp(:,:,1),Ytp(:,1),Xvp(:,:,1),Yvp(:,1)] = precond_data(pima_standard_pm1,1,1:240,0);
% [Xtp(:,:,2),Ytp(:,2),Xvp(:,:,2),Yvp(:,2)] = precond_data(pima_standard_pm1,1,1:240,0);
% [Xtp(:,:,3),Ytp(:,3),Xvp(:,:,3),Yvp(:,3)] = precond_data(pima_standard_pm1,1,1:240,0);
% 
% errpm = zeros(length(lambda),3);
% errph = zeros(length(lambda),3);
% errphq = zeros(length(lambda),3);
% 
% Wb = zeros(9,3);
% w = zeros(8,3);
% b = zeros(1,3);
% 
% for l = 1:length(lambda)
%     for t = 1:3
%         Wb(:,t) = postpro_wb_class_hingequad_qp(Xtp(:,:,t),Ytp(:,t),lambda(l));
%         w(:,t) = Wb(1:13,t);
%         b(t) = Wb(end,t);
%         errpm(l,t) =  postpro_err_misclass(w(:,t),b(t),Xvp(:,:,t),Yvp(:,t));
%         errph(l,t) =  postpro_err_hinge(w(:,t),b(t),Xvp(:,:,t),Yvp(:,t));
%         errphq(l,t) =  postpro_err_hingequad(w(:,t),b(t),Xvp(:,:,t),Yvp(:,t));
%     end
% end
% 
% errpm = sum(errpm,2)/3;
% errph = sum(errph,2)/3;
% errphq = sum(errphq,2)/3;
% 
% figure
% hold on 
% plot(lambda,errpm,'b')
% plot(lambda,errph,'c')
% plot(lambda,errphq,'m')
% legend('Misclassification Error','Hingeloss','Hingequad')
% 
% 
% % wine red
% Xtw = zeros(11,600,3);
% Ytw = zeros(600,3);
% [Xtw(:,:,1),Ytw(:,1)] = precond_data(winequalred_stand,1,1:600,0);
% [Xtw(:,:,2),Ytw(:,2)] = precond_data(winequalred_stand,1,1:600,0);
% [Xtw(:,:,3),Ytw(:,3)] = precond_data(winequalred_stand,1,1:600,0);
% 
% errwm = zeros(length(lambda),3);
% errwh = zeros(lenth(lambda),3);
% errwhq = zeros(length(lambda),3);
% 
% for l = 1:length(lambda)
%     for t = 1:3
%         errwm(l,t) = final_class_error(lambda(l),Xtw(:,:,t),Ytw(:,t));
%         errwh(l,t) = final_class_error_hingeloss(lambda(l),Xtw(:,:,t),Ytw(:,t));
%         errwhq(l,t) = final_class_error_hingequad(lambda(l),Xtw(:,:,t),Ytw(:,t));
%     end
% end
% 
% errwm = sum(errwm,2)/3;
% errwh = sum(errwh,2)/3;
% errwhq = sum(errwhq,2)/3;
% 
% figure
% hold on 
% plot(lambda,errwm,'b')
% plot(lambda,errwh,'c')
% plot(lambda,errwhq,'m')
% legend('Misclassification Error','Hingeloss','Hingequad')
% 
% 
% % wine red 56
% Xtw56 = zeros(11,600,3);
% Ytw56 = zeros(600,3);
% [Xtw56(:,:,1),Ytw56(:,1)] = precond_data(winequalred56_stand,1,1:600,0);
% [Xtw56(:,:,2),Ytw56(:,2)] = precond_data(winequalred56_stand,1,1:600,0);
% [Xtw56(:,:,3),Ytw56(:,3)] = precond_data(winequalred56_stand,1,1:600,0);
% 
% errw56m = zeros(length(lambda),3);
% errw56h = zeros(length(lambda),3);
% errw56hq = zeros(length(lambda),3);
% 
% for l = 1:length(lambda)
%     for t = 1:3
%         errw56m(l,t) = final_class_error(lambda(l),Xtw56(:,:,t),Ytw56(:,t));
%         errw56h(l,t) = final_class_error_hingeloss(lambda(l),Xtw56(:,:,t),Ytw56(:,t));
%         errw56hq(l,t) = final_class_error_hingequad(lambda(l),Xtw56(:,:,t),Ytw56(:,t));
%     end
% end
% 
% errw56m = sum(errw56m,2)/3;
% errw56h = sum(errw56h,2)/3;
% errw56hq = sum(errw56hq,2)/3;
% 
% figure
% hold on 
% plot(lambda,errw56m,'b')
% plot(lambda,errw56h,'c')
% plot(lambda,errw56hq,'m')
% legend('Misclassification Error','Hingeloss','Hingequad') 
% 
% 
% % covtype1000
% Xtct = zeros(10,600,3);
% Ytct = zeros(600,3);
% [Xtct(:,:,1),Ytct(:,1)] = precond_data(covtype1000,1,1:600,0);
% [Xtct(:,:,2),Ytct(:,2)] = precond_data(covtype1000,1,1:600,0);
% [Xtct(:,:,3),Ytct(:,3)] = precond_data(covtype1000,1,1:600,0);
% 
% errctm = zeros(length(lambda),3);
% errcth = zeros(length(lambda),3);
% errcthq = zeros(length(lambda),3);
% 
% for l = 1:length(lambda)
%     for t = 1:3
%         errctm(l,t) = final_class_error(lambda(l),Xtct(:,:,t),Ytct(:,t));
%         errcth(l,t) = final_class_error_hingeloss(lambda(l),Xtct(:,:,t),Ytct(:,t));
%         errcthq(l,t) = final_class_error_hingequad(lambda(l),Xtct(:,:,t),Ytct(:,t));
%     end
% end
% 
% errctm = sum(errctm,2)/3;
% errcth = sum(errcth,2)/3;
% errcthq = sum(errcthq,2)/3;
% 
% figure
% hold on 
% plot(lambda,errctm,'b')
% plot(lambda,errcth,'c')
% plot(lambda,errcthq,'m')
% legend('Misclassification Error','Hingeloss','Hingequad')
% 
% 
% % cancer
% Xtc = zeros(9,240,3);
% Ytc = zeros(240,3);
% [Xtc(:,:,1),Ytc(:,1)] = precond_data(cancer_standard_pm1,1,1:240,0);
% [Xtc(:,:,2),Ytc(:,2)] = precond_data(cancer_standard_pm1,1,1:240,0);
% [Xtc(:,:,3),Ytc(:,3)] = precond_data(cancer_standard_pm1,1,1:240,0);
% 
% errcm = zeros(length(lambda),3);
% errch = zeros(length(lambda),3);
% errchq = zeros(length(lambda),3);
% 
% for l = 1:length(lambda)
%     for t = 1:3
%         errcm(l,t) = final_class_error(lambda(l),Xtc(:,:,t),Ytc(:,t));
%         errch(l,t) = final_class_error_hingeloss(lambda(l),Xtc(:,:,t),Ytc(:,t));
%         errchq(l,t) = final_class_error_hingequad(lambda(l),Xtc(:,:,t),Ytc(:,t));
%     end
% end
% 
% errcm = sum(errcm,2)/3;
% errch = sum(errch,2)/3;
% errchq = sum(errchq,2)/3;
% 
% figure
% hold on 
% plot(lambda,errcm,'b')
% plot(lambda,errch,'c')
% plot(lambda,errchq,'m')
% legend('Misclassification Error','Hingeloss','Hingequad')
% 
% 
% % ionosphere
% Xti = zeros(33,240,3);
% Yti = zeros(240,3);
% [Xti(:,:,1),Yti(:,1)] = precond_data(ionosphere_standard_1stcolumn_pm1,1,1:240,0);
% [Xti(:,:,2),Yti(:,2)] = precond_data(ionosphere_standard_1stcolumn_pm1,1,1:240,0);
% [Xti(:,:,3),Yti(:,3)] = precond_data(ionosphere_standard_1stcolumn_pm1,1,1:240,0);
% 
% errim = zeros(length(lambda),3);
% errih = zeros(length(lambda),3);
% errihq = zeros(length(lambda),3);
% 
% for l = 1:length(lambda)
%     for t = 1:3
%         errim(l,t) = final_class_error(lambda(l),Xti(:,:,t),Yti(:,t));
%         errih(l,t) = final_class_error_hingeloss(lambda(l),Xti(:,:,t),Yti(:,t));
%         errihq(l,t) = final_class_error_hingequad(lambda(l),Xti(:,:,t),Yti(:,t));
%     end
% end
% 
% errim = sum(errim,2)/3;
% errih = sum(errih,2)/3;
% errihq = sum(errihq,2)/3;
% 
% figure
% hold on 
% plot(lambda,errim,'b')
% plot(lambda,errih,'c')
% plot(lambda,errihq,'m')
% legend('Misclassification Error','Hingeloss','Hingequad')
% 
% 
% % heart
% Xth = zeros(13,216,3);
% Yth = zeros(216,3);
% [Xth(:,:,1),Yth(:,1)] = precond_data(heart_standard_pm1,1,1:216,0);
% [Xth(:,:,2),Yth(:,2)] = precond_data(heart_standard_pm1,1,1:216,0);
% [Xth(:,:,3),Yth(:,3)] = precond_data(heart_standard_pm1,1,1:216,0);
% 
% errhm = zeros(length(lambda),3);
% errhh = zeros(length(lambda),3);
% errhhq = zeros(length(lambda),3);
% 
% for l = 1:length(lambda)
%     for t = 1:3
%         errhm(l,t) = final_class_error(lambda(l),Xth(:,:,t),Yth(:,t));
%         errhh(l,t) = final_class_error_hingeloss(lambda(l),Xth(:,:,t),Yth(:,t));
%         errhhq(l,t) = final_class_error_hingequad(lambda(l),Xth(:,:,t),Yth(:,t));
%     end
% end
% 
% errhm = sum(errhm,2)/3;
% errhh = sum(errhh,2)/3;
% errhhq = sum(errhhq,2)/3;
% 
% figure
% hold on 
% plot(lambda,errhm,'b')
% plot(lambda,errhh,'c')
% plot(lambda,errhhq,'m')
% legend('Misclassification Error','Hingeloss','Hingequad')

%%
% %% 10 Repeats
% % pima
% Xtp = zeros(8,240,10);
% Ytp = zeros(240,10);
% for t = 1:10
%     [Xtp(:,:,t),Ytp(:,t)] = precond_data(pima_standard_pm1,1,1:240,0);
% end
% 
% errpm = zeros(length(lambda),10);
% errph = zeros(length(lambda),10);
% errphq = zeros(length(lambda),10);
% 
% Wb = zeros(9,10);
% w = zeros(8,10);
% b = zeros(1,10);
% 
% figure
% hold on 
% 
% for l = 1:length(lambda)
%     for t = 1:10
%         Wb(:,t) = postpro_wb_class_hingequad_qp(Xtp(:,:,t),Ytp(:,t),lambda(l));
%         w(:,t) = Wb(1:8,t);
%         b(t) = Wb(end,t);
%         errpm(l,t) = postpro_err_misclass(w(:,t),b(t),Xtp(:,:,t),Ytp(:,t));
%         errph(l,t) = postpro_err_hinge(w(:,t),b(t),Xtp(:,:,t),Ytp(:,t));
%         errphq(l,t) = postpro_err_hingequad(w(:,t),b(t),Xtp(:,:,t),Ytp(:,t));
%     end
% end
% 
% % for t = 1:10
% %     plot(lambda,errpm(:,t),'k')
% %     plot(lambda,errph(:,t),'r')
% %     plot(lambda,errphq(:,t),'g')
% % end
% 
% errpm = sum(errpm,2)/10;
% errph = sum(errph,2)/10;
% errphq = sum(errphq,2)/10;
% 
% p1 = plot(lambda,errpm,'b');
% p2 = plot(lambda,errph,'c');
% p3 = plot(lambda,errphq,'m');
% legend('Misclassification Error','Hingeloss','Hingequad')
% 
% 
% % wine red
% Xtw = zeros(11,600,10);
% Ytw = zeros(600,10);
% for t = 1:10
%     [Xtw(:,:,t),Ytw(:,t)] = precond_data(winequalred_stand,1,1:600,0);
% end
% 
% errwm = zeros(length(lambda),10);
% errwh = zeros(length(lambda),10);
% errwhq = zeros(length(lambda),10);
% 
% Wb = zeros(12,10);
% w = zeros(11,10);
% b = zeros(1,10);
% 
% figure
% hold on 
% 
% for l = 1:length(lambda)
%     for t = 1:10
%         Wb(:,t) = postpro_wb_class_hingequad_qp(Xtw(:,:,t),Ytw(:,t),lambda(l));
%         w(:,t) = Wb(1:11,t);
%         b(t) = Wb(end,t);
%         errwm(l,t) = postpro_err_misclass(w(:,t),b(t),Xtw(:,:,t),Ytw(:,t));
%         errwh(l,t) = postpro_err_hinge(w(:,t),b(t),Xtw(:,:,t),Ytw(:,t));
%         errwhq(l,t) = postpro_err_hingequad(w(:,t),b(t),Xtw(:,:,t),Ytw(:,t));
%     end
% end
% 
% errwm = sum(errwm,2)/10;
% errwh = sum(errwh,2)/10;
% errwhq = sum(errwhq,2)/10;
% 
% plot(lambda,errwm,'b')
% plot(lambda,errwh,'c')
% plot(lambda,errwhq,'m')
% legend('Misclassification Error','Hingeloss','Hingequad')
% 
% 
% % wine red 56
% Xtw56 = zeros(11,600,10);
% Ytw56 = zeros(600,10);
% for t = 1:10
%     [Xtw56(:,:,t),Ytw56(:,t)] = precond_data(winequalred56_stand,1,1:600,0);
% end
% 
% errw56m = zeros(length(lambda),10);
% errw56h = zeros(length(lambda),10);
% errw56hq = zeros(length(lambda),10);
% 
% Wb = zeros(12,10);
% w = zeros(11,10);
% b = zeros(1,10);
% 
% figure
% hold on 
% 
% for l = 1:length(lambda)
%     for t = 1:10
%         Wb(:,t) = postpro_wb_class_hingequad_qp(Xtw56(:,:,t),Ytw56(:,t),lambda(l));
%         w(:,t) = Wb(1:11,t);
%         b(t) = Wb(end,t);
%         errw56m(l,t) = postpro_err_misclass(w(:,t),b(t),Xtw56(:,:,t),Ytw56(:,t));
%         errw56h(l,t) = postpro_err_hinge(w(:,t),b(t),Xtw56(:,:,t),Ytw56(:,t));
%         errw56hq(l,t) = postpro_err_hingequad(w(:,t),b(t),Xtw56(:,:,t),Ytw56(:,t));
%     end
% end
% 
% errw56m = sum(errw56m,2)/10;
% errw56h = sum(errw56h,2)/10;
% errw56hq = sum(errw56hq,2)/10;
% 
% plot(lambda,errw56m,'b')
% plot(lambda,errw56h,'c')
% plot(lambda,errw56hq,'m')
% legend('Misclassification Error','Hingeloss','Hingequad') 
% 
% 
% % covtype1000
% Xtct = zeros(10,600,10);
% Ytct = zeros(600,10);
% for t = 1:10
%     [Xtct(:,:,t),Ytct(:,t)] = precond_data(covtype1000,1,1:600,0);
% end
% 
% errctm = zeros(length(lambda),10);
% errcth = zeros(length(lambda),10);
% errcthq = zeros(length(lambda),10);
% 
% Wb = zeros(11,10);
% w = zeros(10,10);
% b = zeros(1,10);
% 
% figure
% hold on 
% 
% for l = 1:length(lambda)
%     for t = 1:10
%         Wb(:,t) = postpro_wb_class_hingequad_qp(Xtct(:,:,t),Ytct(:,t),lambda(l));
%         w(:,t) = Wb(1:10,t);
%         b(t) = Wb(end,t);
%         errctm(l,t) = postpro_err_misclass(w(:,t),b(t),Xtct(:,:,t),Ytct(:,t));
%         errcth(l,t) = postpro_err_hinge(w(:,t),b(t),Xtct(:,:,t),Ytct(:,t));
%         errcthq(l,t) = postpro_err_hingequad(w(:,t),b(t),Xtct(:,:,t),Ytct(:,t));
%     end
% end
% 
% errctm = sum(errctm,2)/10;
% errcth = sum(errcth,2)/10;
% errcthq = sum(errcthq,2)/10;
% 
% plot(lambda,errctm,'b')
% plot(lambda,errcth,'c')
% plot(lambda,errcthq,'m')
% legend('Misclassification Error','Hingeloss','Hingequad')
% 
% 
% % cancer
% Xtc = zeros(9,240,10);
% Ytc = zeros(240,10);
% for t = 1:10
%     [Xtc(:,:,t),Ytc(:,t)] = precond_data(cancer_standard_pm1,1,1:240,0);
% end
% 
% errcm = zeros(length(lambda),10);
% errch = zeros(length(lambda),10);
% errchq = zeros(length(lambda),10);
% 
% Wb = zeros(10,10);
% w = zeros(9,10);
% b = zeros(1,10);
% 
% figure
% hold on 
% 
% for l = 1:length(lambda)
%     for t = 1:10
%         Wb(:,t) = postpro_wb_class_hingequad_qp(Xtc(:,:,t),Ytc(:,t),lambda(l));
%         w(:,t) = Wb(1:9,t);
%         b(t) = Wb(end,t);
%         errcm(l,t) = postpro_err_misclass(w(:,t),b(t),Xtc(:,:,t),Ytc(:,t));
%         errch(l,t) = postpro_err_hinge(w(:,t),b(t),Xtc(:,:,t),Ytc(:,t));
%         errchq(l,t) = postpro_err_hingequad(w(:,t),b(t),Xtc(:,:,t),Ytc(:,t));
%     end
% end
% 
% errcm = sum(errcm,2)/10;
% errch = sum(errch,2)/10;
% errchq = sum(errchq,2)/10;
% 
% plot(lambda,errcm,'b')
% plot(lambda,errch,'c')
% plot(lambda,errchq,'m')
% legend('Misclassification Error','Hingeloss','Hingequad')
% 
% 
% % ionosphere
% Xti = zeros(33,240,10);
% Yti = zeros(240,10);
% for t = 1:10
%     [Xti(:,:,t),Yti(:,t)] = precond_data(ionosphere_standard_1stcolumn_pm1,1,1:240,0);
% end
% 
% errim = zeros(length(lambda),10);
% errih = zeros(length(lambda),10);
% errihq = zeros(length(lambda),10);
% 
% Wb = zeros(34,10);
% w = zeros(33,10);
% b = zeros(1,10);
% 
% figure
% hold on 
% 
% for l = 1:length(lambda)
%     for t = 1:10
%         Wb(:,t) = postpro_wb_class_hingequad_qp(Xti(:,:,t),Yti(:,t),lambda(l));
%         w(:,t) = Wb(1:33,t);
%         b(t) = Wb(end,t);
%         errim(l,t) = postpro_err_misclass(w(:,t),b(t),Xti(:,:,t),Yti(:,t));
%         errih(l,t) = postpro_err_hinge(w(:,t),b(t),Xti(:,:,t),Yti(:,t));
%         errihq(l,t) = postpro_err_hingequad(w(:,t),b(t),Xti(:,:,t),Yti(:,t));
%     end
% end
% 
% errim = sum(errim,2)/10;
% errih = sum(errih,2)/10;
% errihq = sum(errihq,2)/10;
% 
% plot(lambda,errim,'b')
% plot(lambda,errih,'c')
% plot(lambda,errihq,'m')
% legend('Misclassification Error','Hingeloss','Hingequad')
% 
% 
% % heart
% Xth = zeros(13,216,10);
% Yth = zeros(216,10);
% for t = 1:10
%     [Xth(:,:,t),Yth(:,t)] = precond_data(heart_standard_pm1,1,1:216,0);
% end
% 
% errhm = zeros(length(lambda),10);
% errhh = zeros(length(lambda),10);
% errhhq = zeros(length(lambda),10);
% 
% Wb = zeros(14,10);
% w = zeros(13,10);
% b = zeros(1,10);
% 
% figure
% hold on 
% 
% for l = 1:length(lambda)
%     for t = 1:10
%         Wb(:,t) = postpro_wb_class_hingequad_qp(Xth(:,:,t),Yth(:,t),lambda(l));
%         w(:,t) = Wb(1:13,t);
%         b(t) = Wb(end,t);
%         errhm(l,t) = postpro_err_misclass(w(:,t),b(t),Xth(:,:,t),Yth(:,t));
%         errhh(l,t) = postpro_err_hinge(w(:,t),b(t),Xth(:,:,t),Yth(:,t));
%         errhhq(l,t) = postpro_err_hingequad(w(:,t),b(t),Xth(:,:,t),Yth(:,t));
%     end
% end
% 
% errhm = sum(errhm,2)/10;
% errhh = sum(errhh,2)/10;
% errhhq = sum(errhhq,2)/10;
% 
% plot(lambda,errhm,'b')
% plot(lambda,errhh,'c')
% plot(lambda,errhhq,'m')
% legend('Misclassification Error','Hingeloss','Hingequad')
% 