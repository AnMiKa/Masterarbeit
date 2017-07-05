function [ f ] = parab( x,n )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if nargin == 1
    n = 0;
end

f = x'*[1 0; 0 50]*x;

switch n
    case 0
    case 1
        f = f + 0.02*rand(1)-0.01;
    case 2
        m = min(0.01,norm(x)/100);
        f = f + 2*m*rand(1)-m;
    case 3
    case 4
end

end

