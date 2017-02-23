function [ grad_Is ] = grad_Is( u, im_noisy, s )
%GRAD_IS gradient (or for s = 1 one subgradient) of the function I_s

% parameters
mu = 1e-10;     % 0 <= mu << g (=0 only in discrete case possible)
g = 0.002;      % g > 0   regularization parameter

[rows, columns] = size(u);
D1 = spdiags([-ones(rows),ones(rows)],[0, 1],rows,columns);
D = [D1; D1'];
Du = DU(u);
lambda_s = zeros(2*rows,columns);
for i = 1:rows*columns
    if abs(Du(i)) < 1e-15
        lambda_s(i) = 0;
    else
        lambda_s(i) = Du(i)./(abs(Du(i)).^(s-2));
    end
end
grad_Is = grad_phi_N(u,im_noisy,mu)+g*D'*lambda_s;

end

