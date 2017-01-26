function [ y ] = grad_rosenbrock( x )
%GRAD_ROSENBROCK gradient of the rosenbrock function


[rows, columns] = size(x);

if rows*columns ~= 2
    error('x has to be a vector in R^2.')
elseif columns > 1
    x = x';
end

y = [-2*(1-x(1))-400*x(1)*(x(2)-x(1))^2; 200*(x(2)-x(1)^2)];

end

