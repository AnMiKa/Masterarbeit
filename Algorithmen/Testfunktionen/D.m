function [ D ] = D( theta, S, U, R, C, UU, step )
%D computes the limited memory approximation or the inverse of the metric
%  matrix

[m,n] = size(S);
if step == 1
    R_inv = inv(R);
    D = theta*eye(m)+[S theta*U]*[R_inv'*(C+theta*UU)*R_inv, -R_inv'; -R_inv, zeros(n)]*[S'; theta*U'];
else
    D = theta*eye(m)-(theta*U-S)/(theta*UU-R-R'+C)*(theta*U-S)';
end

