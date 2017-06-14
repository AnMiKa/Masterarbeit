function [ f ] = nonsm_rosenbrock2( x, n )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

f = (1-x(1))^2+100*abs(x(2)-(x(1))^2);

end

