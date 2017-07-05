x = -1:0.02:1;
y = -1:0.02:1;
[X, Y] = meshgrid(x, y);
Z = zeros(length(x),length(y));
for m = 1:length(x)
    for n = 1:length(y)
        input = [x(m); y(n)];
        Z(m,n) = f2_testfunction(input);
    end
end
figure('Position',[10,10,215,215])
box on 
meshc(X,Y,Z)
colormap cool

title('$f_2$','Interpreter','latex')
xlabel('$x_1$','Interpreter','latex')
ylabel('$x_2$','Interpreter','latex')
zticks([5,10,15])
zticklabels([5,10,15])
pbaspect([1 1 2/3])

ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

