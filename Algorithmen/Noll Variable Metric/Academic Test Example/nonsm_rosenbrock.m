function [ f ] = nonsm_rosenbrock( x, n )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

f = abs(1-x(1))+100*abs(x(2)-abs(x(1)));

end

