
function [] = boundary(w,data)

styles = ['- ';'--';'-.';': '];
colors = ['k'; 'k'; 'g'; 'm'];

plotdata(data);
hold on;

myax = axis; 
axis manual;

m = 50; % grid points for contour
tx = myax(1) + (myax(2)-myax(1))*(0:m)'/m;

[n,d] = size(data.X);
[d_, ndec] = size(w);

for decision = 1:ndec
    ty = -w(1,decision)/w(3,decision) - tx*w(2,decision)/w(3,decision);
    plot(tx,ty, colors(decision,:), 'LineStyle',styles(decision,:));
end

% code added:
legend('Class 1','Class 2','logistic regression', 'Fisher discriminant', 'hinge loss', 'hingequad loss');
    
hold off;
