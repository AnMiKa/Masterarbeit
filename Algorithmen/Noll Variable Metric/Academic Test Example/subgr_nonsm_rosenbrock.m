function [ g ] = subgr_nonsm_rosenbrock( x, n )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

g = [-sign(1-x(1)); 0]+sign(x(2)-abs(x(1)))*100*[-sign(x(1));1];

end

