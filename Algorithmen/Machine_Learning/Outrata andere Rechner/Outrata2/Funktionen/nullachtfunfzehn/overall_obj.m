function [ err ] = overall_obj( C, X, Y )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% calculate wb for all folds
W = solve_ll_hingequad_outr(C,X,Y);

% calculate average error over all folds
err = ul_obj_class_hingequad(X,Y,W);

