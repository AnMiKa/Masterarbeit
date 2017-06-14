function [ g ] = subgr_nonsm_parab2( x, n )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

g= [x(1)+0.5*sign(x(1)); 20*x(2)+10*sign(x(2))];

end

