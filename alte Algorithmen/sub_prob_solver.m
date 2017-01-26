function [ output_args ] = sub_prob_solver(s_k, c_k)

%   functions is called by the function prox_bundle_nonconv
%   solves subproblem (11) of the paper "A proximal bundle emthod for nonsmooth 
%   nonconvex functions with inexact information" by W. Hare, C. Sagastizábal
%   and M. Solodov, Springer Comput Optim Appl (2016)

%   Algorithm statet in "A method for solving certain quadratic programming problems
%   arising in nonsmooth optimization" by K. C. Kiwiel, IMA J. Numer.
%   Anal., 6 (1986)

%   Detailed explanation goes here

% input arguments
%       s_k     first k culumns of matrix s?
%       c_k     first k values of vector c?
%%

kmax = 50;      % maximal number of iterations

vec = zeros(1, length(c_k));
for i = 1:length(c_k);
    vec(i) = 1/2 .* norm(s_k(:, i))^2 + c_k;
end
[M, l] = min(vec);
J = [l];
p_l = s_k(:, l);
P = p_l;
a_l = c_k;
a_hat = a_l;
y = 1;
y_hat = y;
v = -(norm(p_l)^2 + a_l) 

%% beginning of the recursion 

for k = 1:kmax;
    P_hat =
    if v + p_l'
end

end

