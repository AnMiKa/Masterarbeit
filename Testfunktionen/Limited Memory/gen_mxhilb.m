function [ y ] = gen_mxhilb( x )
%Generalization of MXHILB
%   Source: "New limited memory bundle method for large scale nonsmooth
%   optimization" by M. Haarala, K. Miettinen and M. M. Mäkelä

[rows, columns] = size(x);
if rows ~= 1 && columns ~= 1
    error('Input value has to be a vector.')
elseif rows == 1
    x = x';
end
l = length(x);
X = repmat(x,1,l);
h = 1:l;
denom = repmat(h,l,1)+repmat(h'-1,1,l);
X_div = X./denom;
y = max(sum(X_div,2));

end

