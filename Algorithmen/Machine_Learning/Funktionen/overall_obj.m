function [ err ] = overall_obj( lambda )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

%[X,Y] = precond_data('heart_standard_pm1.mat',1,1,1);

load('Data/ready_to_use/Training Data/Cancer.mat')

% calculate wb for all folds
Wb = solve_ll_class_hingequad_qp(Xtcancer1,Ytcancer1,lambda);
W = Wb(1:end-1,:);
b = Wb(end,:);

% calculate average error over all folds
err = ul_obj_class_hinge(Xtcancer1,Ytcancer1,W,b);

