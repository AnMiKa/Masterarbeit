% % plot upper level objective function f (hinge loss) for different lambdas to
% % examine how f changes with lambda
% 
% create vector of lambda values
% 200 points from 1e-4 to 1e4 in logarithmic scale
lambda = logspace(-4,4,200);
l = length(lambda);
% 
% 
% fp_av = zeros(1,l);
% ep_av = zeros(1,l);
% mp_av = zeros(1,l);
% 
% fc_av = zeros(1,l);
% ec_av = zeros(1,l);
% mc_av = zeros(1,l);
% 
fh_av = zeros(1,l);
eh_av = zeros(1,l);
mh_av = zeros(1,l);
% 
% fi_av = zeros(1,l);
% ei_av = zeros(1,l);
% mi_av = zeros(1,l);
% 
for k = 1:20
%     %precondition data
%     [pima_trainX,pima_trainY,pima_holdoutX,pima_holdoutY] =...
%         precond_data(pima_standard_pm1,1,1:240,0);
%     [cancer_trainX,cancer_trainY,cancer_holdoutX,cancer_holdoutY] =...
%         precond_data(cancer_standard_pm1,1,1:240,0);
    [heart_trainX,heart_trainY,heart_holdoutX,heart_holdoutY] =...
        precond_data(heart_standard_pm1,1,1:216,0);
%     [ionosphere_trainX,ionosphere_trainY,ionosphere_holdoutX,ionosphere_holdoutY] =...
%         precond_data(ionosphere_standard_pm1,1,1:240,0);
% 
%     % preallocate data for all four data sets
%     Wp = zeros(8,l);
%     Bp = zeros(1,l);
%     fp = zeros(1,l);
%     mp = zeros(1,l);
%     ep = zeros(1,l);
% 
%     Wc = zeros(10,l);
%     Bc = zeros(1,l);
%     fc = zeros(1,l);
%     mc = zeros(1,l);
%     ec = zeros(1,l);
% 
    Wh = zeros(13,l);
    Bh = zeros(1,l);
    fh = zeros(1,l);
    mh = zeros(1,l);
    eh = zeros(1,l);
% 
%     Wi = zeros(33,l);
%     Bi = zeros(1,l);
%     fi = zeros(1,l);
%     mi = zeros(1,l);
%     ei = zeros(1,l);
% 
%     % calculate weight vector w and bias b for the given lambdas 
    for i = 1:l
%         % pima
%         Wbp = solve_ll_class_hingequad_qpas(pima_trainX,pima_trainY,lambda(i));
%         Wp(:,i) = Wbp(1:8);
%         Bp(i) = Wbp(9);
%         fp(i) = ul_obj_class_hinge(pima_holdoutX,pima_holdoutY,Wp(:,i),Bp(i));
%         ep(i) = postpro_err_hinge(Wp(:,i),Bp(i),pima_holdoutX,pima_holdoutY);
%         mp(i) = postpro_err_misclass(Wp(:,i),Bp(i),pima_holdoutX,pima_holdoutY);
% 
%         % cancer
%         Wbc = solve_ll_class_hingequad_qpas(cancer_trainX,cancer_trainY,lambda(i));
%         Wc(:,i) = Wbc(1:10);
%         Bc(i) = Wbc(11);
%         fc(i) = ul_obj_class_hinge(cancer_holdoutX,cancer_holdoutY,Wc(:,i),Bc(i));
%         ec(i) = postpro_err_hinge(Wc(:,i),Bc(i),cancer_holdoutX,cancer_holdoutY);
%         mc(i) = postpro_err_misclass(Wc(:,i),Bc(i),cancer_holdoutX,cancer_holdoutY);
% 
        % heart
        Wbh = solve_ll_class_hingequad_qpas(heart_trainX,heart_trainY,lambda(i));
        Wh(:,i) = Wbh(1:13);
        Bh(i) = Wbh(14);
        fh(i) = ul_obj_class_hinge(heart_holdoutX,heart_holdoutY,Wh(:,i),Bh(i));
        eh(i) = postpro_err_hinge(Wh(:,i),Bh(i),heart_holdoutX,heart_holdoutY);
        mh(i) = postpro_err_misclass(Wh(:,i),Bh(i),heart_holdoutX,heart_holdoutY);
% 
%         %ionosphere
%         Wbi = solve_ll_class_hingequad_qpas(ionosphere_trainX,ionosphere_trainY,lambda(i));
%         Wi(:,i) = Wbi(1:33);
%         Bi(i) = Wbi(34);
%         fi(i) = ul_obj_class_hinge(ionosphere_holdoutX,ionosphere_holdoutY,Wi(:,i),Bi(i));
%         ei(i) = postpro_err_hinge(Wi(:,i),Bi(i),ionosphere_holdoutX,ionosphere_holdoutY);
%         mi(i) = postpro_err_misclass(Wi(:,i),Bi(i),ionosphere_holdoutX,ionosphere_holdoutY);
    end
%     
%     fp_av = fp_av+fp;
%     mp_av = mp_av+mp;
%     ep_av = ep_av+ep;
%     
%     fc_av = fc_av+fc;
%     mc_av = mc_av+mc;
%     ec_av = ec_av+ec;
    
    fh_av = fh_av+fh;
    mh_av = mh_av+mh;
    eh_av = eh_av+eh;
%     
%     fi_av = fi_av+fi;
%     mi_av = mi_av+mi;
%     ei_av = ei_av+ei;
end
% 
% fp = fp_av./20;
% mp = mp_av./20;
% ep = ep_av./20;
% 
% fc = fc_av./20;
% mc = mc_av./20;
% ec = ec_av./20;
% 
fh = fh_av./20;
mh = mh_av./20;
eh = eh_av./20;
% 
% fi = fi_av./20;
% mi = mi_av./20;
% ei = ei_av./20;

% plot the function values
% pima
% plot(lambda,fp,'r',lambda,mp,'--r')
% loglog(lambda,fp,'--r')
% semilogx(lambda,fp,'')
% plot(lambda, mp, '--r')
% hold off
% 
% % cancer
% hold on
% figure
% plot(lambda,fc,'b')
% plot(lambda, mp, '--r')
% hold off
% 
% % heart
% hold on
% figure
% plot(lambda,fh,'g')
% plot(lambda, mp, '--r')
% hold off
% 
% % ionosphere
% hold on
% figure
% plot(lambda,fi,'k')
% plot(lambda, mp, '--r')
% hold off
%    
