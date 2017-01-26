function [ y ] = rosenbrock( x )
%ROSENBROCK the rosenbrock function

[rows, columns] = size(x);

if rows*columns ~= 2
    error('x has to be a vector in R^2.')
elseif columns > 1
    x = x';
end

y = (1-x(1))^2+100*(x(2)-x(1)^2)^2;
end

