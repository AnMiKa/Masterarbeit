function [ err ] = overall_obj( lambda )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

%[X,Y] = precond_data('heart_standard_pm1.mat',1,1,1);

load('Beispiele Masterarbeit/Datensätze/Trainingsdata/Box5.mat')

% calculate wb for all folds
Wb = solve_ll_class_hingequad_qp(Xtbox5,Ytbox5,lambda);
W = Wb(1:end-1,:);
b = Wb(end,:);

% calculate average error over all folds
err = ul_obj_class_hinge(Xtbox5,Ytbox5,W,b);

