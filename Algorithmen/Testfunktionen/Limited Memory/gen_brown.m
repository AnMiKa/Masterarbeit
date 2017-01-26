function [ y ] = gen_brown( x )
%Nonsmooth generalization of Brown function 2
%   Source: "New limited memory bundle method for large scale nonsmooth
%   optimization" by M. Haarala, K. Miettinen and M. M. Mäkelä

[rows, columns] = size(x);
if rows ~= 1 && columns ~= 1
    error('Input value has to be a vector.')
elseif rows == 1
    x = x';
end
s1 = abs(x(1:end-1)).^(x(2:end).^2+1);
s2 = abs(x(2:end)).^(x(1:end-1).^2+1);
y = sum(s1+s2);
end

