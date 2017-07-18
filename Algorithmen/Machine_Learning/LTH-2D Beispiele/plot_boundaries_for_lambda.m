% train and plot for different lambda-values

data = data_as;

% train 
%lambda = linspace(0,100,500);
lambda = 0:20:500;

wbqp = zeros(3,length(lambda));
%wbqpas = zeros(3,500);

for l = 1:length(lambda)
    wbqp(:,l) = LTH_wb_class_hingequad_qp(data,lambda(l));
    %wbqpas(:,l) = LTH_wb_class_hingequad_qpas(data,lambda(l));
end

% plot the boundaries into the data-plot

% plot the data points
figure
plotdata_as(data);
hold on;

myax = axis; 
axis manual;

m = 50; % grid points for contour
tx = myax(1) + (myax(2)-myax(1))*(0:m)'/m;

%[n,d] = size(data.X);
[~, ndec] = size(wbqp);

ty = -wbqp(1,1)/wbqp(3,1) - tx*wbqp(2,1)/wbqp(3,1);
    plot(tx,ty,'g');

for decision = 2:ndec
    ty = -wbqp(1,decision)/wbqp(3,decision) - tx*wbqp(2,decision)/wbqp(3,decision);
    plot(tx,ty,'k');
end

legend('Class 1','Class 2');
    
hold off;