function [ y ] = gen_maxq( x )
%Generalization of MAXQ
%   Source: "New limited memory bundle method for large scale nonsmooth
%   optimization" by M. Haarala, K. Miettinen and M. M. Mäkelä

y = max(x.^2);

end

