function [ grad_phi ] = grad_phi_N( u, im_noisy, mu )
%GRAD_PHI gradient of the discretized phi-function 

K = neg_Lap(u);
grad_phi = (u-im_noisy)+mu*K*u;

end

