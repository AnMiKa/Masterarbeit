function [ g ] = subgr_nonsm_rosenbrock2( x, n )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

g = [2*(1-x(1))*(-1)+100*sign(x(2)-x(1)^2)*((-2*x(1))); 100*sign(x(2)-x(1)^2)];

end

