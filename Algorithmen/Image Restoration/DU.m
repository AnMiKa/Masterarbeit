function [ Du ] = DU( u )
%DU discretized backward difference approximation of u
%   u is a 2-dimensional image
%   the directional derivatives in the two dimensions are approximated
[rows, columns] = size(u);

D1u = spdiags([-ones(rows),ones(rows)],[0, 1],rows,columns)*u;
D2u = spdiags([-ones(rows),ones(rows)],[0, 1],rows,columns)'*u;
Du = [D1u; D2u];


end

