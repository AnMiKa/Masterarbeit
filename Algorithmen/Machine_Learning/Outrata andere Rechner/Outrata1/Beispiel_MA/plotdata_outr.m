
function [] = plotdata_outr(X,Y)

% dimensions of X, Y
% X: feat x number of instances
% Y: number of instances x 1

I0 = find(Y==-1); 
I1 = find(Y==1); 
figure('position',[10 10 400 320])
h=plot(X(1,I0),X(2,I0),'m*'); hold on;
set(h,'MarkerSize',5);

h=plot(X(1,I1),X(2,I1),'b+'); %hold off;
set(h,'MarkerSize',5);
