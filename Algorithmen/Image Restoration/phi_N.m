function [ phi_N ] = phi_N( u, im_noisy, mu )
%PHI_N discretized phi-function for image restoration

K = neg_Lap(u);
% calculate function value
phi_N = 1/2*(u-im_noisy)'*(u-im_noisy)+mu/2*u'*K*u;


end

