function [ y ] = chained_lq( x )
%Chained LQ
%   Source: "New limited memory bundle method for large scale nonsmooth
%   optimization" by M. Haarala, K. Miettinen and M. M. Mäkelä

[rows, columns] = size(x);
if rows ~= 1 && columns ~= 1
    error('Input value has to be a vector.')
elseif rows == 1
    x = x';
end
m1 = -x(1:end-1)-x(2:end);
m2 = m1+x(1:end-1).^2+x(2:end).^2-1;
y = sum(max([m1,m2],[],2));
end

