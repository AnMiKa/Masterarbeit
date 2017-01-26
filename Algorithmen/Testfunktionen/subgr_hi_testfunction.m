function [ sghi ] = subgr_hi_testfunction( x, i)
%subgr_h_i_testfunction creates a subgradient of the i'th h-function 
%   the following conditions need to hold:
%   i <= length(x)

% warning if i > length(x)?

unit = eye(length(x));
sghi = ones(length(x),1)+(2*i*x(i)-2)*unit(:,i);
end

