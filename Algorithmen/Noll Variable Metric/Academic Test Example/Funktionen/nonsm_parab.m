function [ f ] = nonsm_parab( x, n )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

if nargin == 1
    n = 0;
end

f = 0.5*x(1)^2+0.5*abs(x(1))+25*x(2)^2+25*abs(x(2));

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

