function [ y ] = act_face( x )
%Number of active faces
%   Source: "New limited memory bundle method for large scale nonsmooth
%   optimization" by M. Haarala, K. Miettinen and M. M. Mäkelä

[rows, columns] = size(x);
if rows ~= 1 && columns ~= 1
    error('Input value has to be a vector.')
elseif rows == 1
    x = x';
end
g1 = log(abs(-sum(x))+1);
g2 = log(abs(x)+1);
y = max([g1,g2']);
end

