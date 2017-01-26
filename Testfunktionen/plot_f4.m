x = -1:0.02:1;
y = -1:0.02:1;
[X, Y] = meshgrid(x, y);
Z = zeros(length(x),length(y));
for m = 1:length(x)
    for n = 1:length(y)
        input = [x(m); y(n)];
        Z(m,n) = f4_testfunction(input);
    end
end
meshc(X,Y,Z)
colormap jet
