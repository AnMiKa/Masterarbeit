function [ g ] = subgr_parab_nonsm( x, n )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

g = sign(5*x(1)-x(2))*[5;-1] + [2*x(1);20*x(2)];

end

