function [ K ] = neg_Lap( u )
%NEG_LAP creates central difference approximation for negative Laplace 
% operator for image u

[rows, columns] = size(u);
k = [ones(columns,1), [0; -4*ones(columns-2,1); 0], ones(columns,1)];
diags = [-1,0,1];
K = spdiags(k, diags, rows, columns);


end

