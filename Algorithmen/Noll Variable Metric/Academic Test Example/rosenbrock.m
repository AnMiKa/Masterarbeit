function [ f ] = rosenbrock( x, n )
%Rosenbrock function
%   Detailed explanation goes here
%   Minimum at (1,1), f(1,1) = 0


f = (1-x(1))^2+100*(x(2)-x(1)^2)^2;

end

