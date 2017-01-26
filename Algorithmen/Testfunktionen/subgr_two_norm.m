function [ g ] = subgr_two_norm( x )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

n = length(x);

if x ~= 0;
    g = x / norm(x);
else
    g = zeros(n, 1);
end

end