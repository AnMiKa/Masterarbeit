function [ f ] = overall_obj( lambda )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

[X,Y] = precond_data('covtype1000.mat',1,1,1);

Wb = solve_ll_class_hingequad_qp(X,Y,lambda);
W = Wb(1:end-1,:);
b = Wb(end,:);
f = ul_obj_class_hinge( X, Y, W, b );

end

