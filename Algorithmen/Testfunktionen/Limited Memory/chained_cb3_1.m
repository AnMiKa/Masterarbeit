function [ y ] = chained_cb3_1( x )
%Chained CB3 I
%   Source: "New limited memory bundle method for large scale nonsmooth
%   optimization" by M. Haarala, K. Miettinen and M. M. Mäkelä

[rows, columns] = size(x);
if rows ~= 1 && columns ~= 1
    error('Input value has to be a vector.')
elseif rows == 1
    x = x';
end
m1 = x(1:end-1).^4+x(2:end).^2;
m2 = (2-x(1:end-1)).^2+(2-x(2:end)).^2;
m3 = 2*exp(-x(1:end-1)+x(2:end));
y = sum(max([m1,m2,m3],[],2));
end

