function [ g ] = subgr_abs( x )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if x < 0;
    g = -1;
elseif x == 0;
    g = 0;
else
    g = 1;
end

end

