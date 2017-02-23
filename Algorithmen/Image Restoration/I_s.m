function [ I ] = I_s( u, im_noisy, s )
%I_S s-forumlation of image restoration problem
%   frpm paper "Comparison of formulations and solution methods for image
%   restoration methods

% parameters
mu = 1e-10;     % 0 <= mu << g (=0 only in discrete case possible)
g = 0.002;      % g > 0   regularization parameter

Du = DU(u);

I = phi_N(u, im_noisy, mu)+g/s*sum(sum(abs(Du).^s));


end

