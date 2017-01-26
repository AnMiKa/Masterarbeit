function [ xi, d, lambda, mu ] = sub_prob_active_set(xi0, d0, x_hat, f_hat, c, s, a, b)

%%
% Does not work. Deleting the values if J changes fails!!!
%%
%   functions is called by the function prox_bundle_nonconv
%   solves subproblem (11) of the paper "A proximal bundle emthod for nonsmooth 
%   nonconvex functions with inexact information" by W. Hare, C. Sagastizábal
%   and M. Solodov, Springer Comput Optim Appl (2016)

%   Algorithm statet in "Nichtlineare Optimierung" by M. Ulbrich and S.
%   Ulbrich, Birkhäuser, 2011

%   Detailed explanation goes here

% parameter:
%   A       index set approximating active inequality constraints

% input arguments
%   [xi0, d0]   feasible!!! starting point for subproblem
%   l           lenth of index set J
%   f_hat       current f_hat
%   c           current matrix c
%   s           current matrix s
        
% output arguments
%   [xi, d, lambda, mu] KKT-tuple of the subproblem

%%

n = length(d0);
A = zeros(1, l + 2 * n);
I = zeros(1, l + 2 * n);
i1 = 1;
i2 = 2;

xi = xi0;
d = d0;
lambda = zeros(l, 1);
mu = zeros(2 * n, 1);


%% initiate first indesx set A
for j = 1:l;
    if f_hat - c(:,J(j)) + s(:,J(j))' * d0 - xi0 > 0;
        I(i2) = j;
        i2 = i2 + 1;
    else A(i1) = j;
        i1 = i1 + 1;
    end
end

for j = 1:2 * n;
    if a(j,:) * (x_hat + d0) - b(j) > 0;
        I(i2) = j+l;
        i2 = i2 + 1;
    else A(i1) = j+l;
        i1 = i1 + 1;
    end
end

%% calculation of KKT-tuple
i = 1;
for j = 1:l+2 * n;
    if  ismember(j, A);
    else I(i) = j;
        i = i + 1;
    end 
end

[xi, d_hat, lambda, mu] = solve();



x = d_hat - d;

end