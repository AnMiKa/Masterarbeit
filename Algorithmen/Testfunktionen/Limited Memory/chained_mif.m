function [ y ] = chained_mif( x )
%Chained Mifflin 2
%   Source: "New limited memory bundle method for large scale nonsmooth
%   optimization" by M. Haarala, K. Miettinen and M. M. Mäkelä

[rows, columns] = size(x);
if rows ~= 1 && columns ~= 1
    error('Input value has to be a vector.')
elseif rows == 1
    x = x';
end
s1 = -x(1:end-1)+2*(x(1:end-1).^2+x(2:end).^2-1)+1.75*abs(x(1:end-1).^2+x(2:end).^2-1);
y = sum(s1);
end

