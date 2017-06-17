function [ g ] = subgr_nonsm_parab( x, n )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

if  nargin == 1
    n = 0;
end

g= [x(1)+0.5*sign(x(1)); 50*x(2)+25*sign(x(2))];

v = 2*rand(length(x),1)-1;
v = v/norm(v);
switch n
    case 0
    case 1
        g = g + 0.01*v;
    case 2
        m = min(0.01,norm(x)/100);
        g = g + m*v;
    case 3
        g = g + 0.01*v;
    case 4
        m = min(0.01,norm(x)/100);
        g = g + m*v;        
end        

end

