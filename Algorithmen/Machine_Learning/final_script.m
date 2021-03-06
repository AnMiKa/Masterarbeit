% final script
% preallocate results

fpi_av = 0;
fca_av = 0;
fhe_av = 0;
fio_av = 0;

ftpi_av = 0;
ftca_av = 0;
fthe_av = 0;
ftio_av = 0;

xpi_av = 0;
xca_av = 0;
xhe_av = 0;
xio_av = 0;

tpi_av = 0;
tca_av = 0;
the_av = 0;
tio_av = 0;

% preallocat minimum and maximum deviation
minfpi = Inf;
maxfpi = 0;
minfca = Inf;
maxfca = 0;
minfhe = Inf;
maxfhe = 0;
minfio = Inf;
maxfio = 0;

minftpi = Inf;
maxftpi = 0;
minftca = Inf;
maxftca = 0;
minfthe = Inf;
maxfthe = 0;
minftio = Inf;
maxftio = 0;

minxpi = Inf;
maxxpi = 0;
minxca = Inf;
maxxca = 0;
minxhe = Inf;
maxxhe = 0;
minxio = Inf;
maxxio = 0;

mintpi = Inf;
maxtpi = 0;
mintca = Inf;
maxtca = 0;
minthe = Inf;
maxthe = 0;
mintio = Inf;
maxtio = 0;


% average over 20 trys
for i = 1:20
   
    % proconditioning data
    [pi_trainfoldX,pi_trainfoldY,pi_testfoldX,pi_testfoldY] = precond_data(pima_standard_pm1,3,1:240,0);
    [ca_trainfoldX,ca_trainfoldY,ca_testfoldX,ca_testfoldY] = precond_data(cancer_standard_pm1,3,1:240,0);
    [he_trainfoldX,he_trainfoldY,he_testfoldX,he_testfoldY] = precond_data(heart_standard_pm1,3,1:216,0);
    [io_trainfoldX,io_trainfoldY,io_testfoldX,io_testfoldY] = precond_data(ionosphere_standard_pm1,3,1:240,0);
    
    % find optimal lambda
    [fpi,xpi,dpi,tpi] = bundle_bilevel(10,pi_trainfoldX,pi_trainfoldY);
    [fca,xca,dca,tca] = bundle_bilevel(10,ca_trainfoldX,ca_trainfoldY);
    [fhe,xhe,dhe,the] = bundle_bilevel(10,he_trainfoldX,he_trainfoldY);
    [fio,xio,dio,tio] = bundle_bilevel(10,io_trainfoldX,io_trainfoldY);
    
    pi_trainX = reshape(pi_trainfoldX,[8,240]);    
    pi_trainY = reshape(pi_trainfoldY,[240,1]);    
    ca_trainX = reshape(ca_trainfoldX,[9,240]);    
    ca_trainY = reshape(ca_trainfoldY,[240,1]);    
    he_trainX = reshape(he_trainfoldX,[13,216]);    
    he_trainY = reshape(he_trainfoldY,[216,1]);    
    io_trainX = reshape(io_trainfoldX,[33,240]);    
    io_trainY = reshape(io_trainfoldY,[240,1]); 
    
    wbpi = postpro_wb_class_hingequad_qpas(pi_trainX,pi_trainY,3/2*xpi);
    wbca = postpro_wb_class_hingequad_qpas(ca_trainX,ca_trainY,3/2*xca);
    wbhe = postpro_wb_class_hingequad_qpas(he_trainX,he_trainY,3/2*xhe);
    wbio = postpro_wb_class_hingequad_qpas(io_trainX,io_trainY,3/2*xio);
    
    ftpi = postpro_err_misclass(wbpi(1:end-1),wbpi(end),pi_testfoldX,pi_testfoldY);
    ftca = postpro_err_misclass(wbca(1:end-1),wbca(end),ca_testfoldX,ca_testfoldY);
    fthe = postpro_err_misclass(wbhe(1:end-1),wbhe(end),he_testfoldX,he_testfoldY);
    ftio = postpro_err_misclass(wbio(1:end-1),wbio(end),io_testfoldX,io_testfoldY);
    
    % save results
    fpi_av = fpi+fpi_av;
    fca_av = fca+fca_av;
    fhe_av = fhe+fhe_av;
    fio_av = fio+fio_av;
    
    ftpi_av = ftpi+ftpi_av;
    ftca_av = ftca+ftca_av;
    fthe_av = fthe+fthe_av;
    ftio_av = ftio+ftio_av;

    xpi_av = 3/2*xpi+xpi_av;
    xca_av = 3/2*xca+xca_av;
    xhe_av = 3/2*xhe+xhe_av;
    xio_av = 3/2*xio+xio_av;

    tpi_av = tpi+tpi_av;
    tca_av = tca+tca_av;
    the_av = the+the_av;
    tio_av = tio+tio_av;
    
    % save minimal and maximal deviation
    minfpi = min(fpi,minfpi);
    maxfpi = max(fpi,maxfpi);
    minfca = min(fca,minfca);
    maxfca = max(fca,maxfca);
    minfhe = min(fhe,minfhe);
    maxfhe = max(fhe,maxfhe);
    minfio = min(fio,minfio);
    maxfio = max(fio,maxfio);
    
    minftpi = min(ftpi,minftpi);
    maxftpi = max(ftpi,maxftpi);
    minftca = min(ftca,minftca);
    maxftca = max(ftca,maxftca);
    minfthe = min(fthe,minfthe);
    maxfthe = max(fthe,maxfthe);
    minftio = min(ftio,minftio);
    maxftio = max(ftio,maxftio);
    
    minxpi = min(3/2*xpi,minxpi);
    maxxpi = max(3/2*xpi,maxxpi);
    minxca = min(3/2*xca,minxca);
    maxxca = max(3/2*xca,maxxca);
    minxhe = min(3/2*xhe,minxhe);
    maxxhe = max(3/2*xhe,maxxhe);
    minxio = min(3/2*xio,minxio);
    maxxio = max(3/2*xio,maxxio);
    
    mintpi = min(tpi,mintpi);
    maxtpi = max(tpi,maxtpi);
    mintca = min(tca,mintca);
    maxtca = max(tca,maxtca);
    minthe = min(the,minthe);
    maxthe = max(the,maxthe);
    mintio = min(tio,mintio);
    maxtio = max(tio,maxtio);
    
end

% calculate averages
fpi_av = 1/20*fpi_av;
fca_av = 1/20*fca_av;
fhe_av = 1/20*fhe_av;
fio_av = 1/20*fio_av;

ftpi_av = 1/20*ftpi_av;
ftca_av = 1/20*ftca_av;
fthe_av = 1/20*fthe_av;
ftio_av = 1/20*ftio_av;

xpi_av = 1/20*xpi_av;
xca_av = 1/20*xca_av;
xhe_av = 1/20*xhe_av;
xio_av = 1/20*xio_av;

tpi_av = 1/20*tpi_av;
tca_av = 1/20*tca_av;
the_av = 1/20*the_av;
tio_av = 1/20*tio_av;