function [ g ] = grad_rosenbrock( x, n )


g = [-2*(1-x(1))-400*x(1)*(x(2)-x(1)^2); 200*(x(2)-x(1)^2)];

end

