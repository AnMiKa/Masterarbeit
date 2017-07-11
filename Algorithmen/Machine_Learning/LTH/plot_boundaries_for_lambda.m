% train and plot for different lambda-values

% train 
lambda = linspace(0,100,500);

wbqp = zeros(3,500);
wbqpas = zeros(3,500);

for l = 1:500
    wbqp(:,l) = LTH_wb_class_hingequad_qp(train1,lambda(l));
    wbqpas(:,l) = LTH_wb_class_hingequad_qpas(train1,lambda(l));
end