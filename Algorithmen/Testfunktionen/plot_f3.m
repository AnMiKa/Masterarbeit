x = -1:0.02:1;
y = -1:0.02:1;
[X, Y] = meshgrid(x, y);
Z = zeros(length(x),length(y));
for m = 1:length(x)
    for n = 1:length(y)
        input = [x(m); y(n)];
        Z(m,n) = f3_testfunction(input);
    end
end
figure('Position',[10,10,230,230])
box on 
meshc(X,Y,Z)
colormap cool

title('$f_3$','Interpreter','latex')
xlabel('$x_1$','Interpreter','latex')
ylabel('$x_2$','Interpreter','latex')
pbaspect([1 1 2/3])

ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

