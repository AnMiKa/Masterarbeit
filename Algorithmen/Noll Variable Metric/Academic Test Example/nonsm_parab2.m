function [ f ] = nonsm_parab2( x, n )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

f = 0.5*x(1)^2+0.5*abs(x(1))+10*x(2)^2+10*abs(x(2));
end

