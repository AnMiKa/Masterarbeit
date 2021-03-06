function [ Dv ] = Dv( v, S, U, R, UU, C, theta, step, i_C, rho )
%DV calvulates the product of the matrix D with another matrix or a vector
%   Algorithm to simplify and increase the readability of other algorithms

% input parameters
%   v                       column vector or matrix
%   S, U, R, UU, C, theta   parts for limited memory decomposition of D
%   step                    decides whether BFGS or SR1 update is used for D

% output parameters
%   Dv  column vector or matrix


[rows,columns] = size(v);
Dv = zeros(rows, columns);

if step == 1
    for i = 1:columns
        p1 = R\(S'*v(:,i));
        p2 = -R'\(C*p1+theta*UU*p1-theta*U'*v(:,i));
        Dv(:,i) = -theta*U*p1-S*p2-theta*v(:,i)+i_C*rho*v(:,i);
    end
else
    for i = 1:columns
        p = (theta*UU-R-R'+C)\(theta*U'*v(:,i)-S'*v(:,i));
        Dv(:,i) = theta*v(:,i)+(theta*U-S)*p+i_C*rho*v(:,i);
    end
end
clearvars -except Dv
end

