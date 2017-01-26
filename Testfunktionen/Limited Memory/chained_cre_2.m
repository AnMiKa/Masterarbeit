function [ y ] = chained_cre_2( x )
%Chained Crescent II
%   Source: "New limited memory bundle method for large scale nonsmooth
%   optimization" by M. Haarala, K. Miettinen and M. M. Mäkelä

[rows, columns] = size(x);
if rows ~= 1 && columns ~= 1
    error('Input value has to be a vector.')
elseif rows == 1
    x = x';
end
m1 = x(1:end-1).^2+(x(2:end)-1).^2+x(2:end)-1;
m2 = -x(1:end-1).^2-(x(2:end)-1).^2+x(2:end)+1;
y = sum(max(m1,m2));
end

