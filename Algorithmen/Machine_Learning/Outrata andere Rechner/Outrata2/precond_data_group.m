% Preprocessing
function [ Xtrain, Ytrain] = precond_data_group( data, T, G, import )
%PRECOND_DATA preconditioning of a data set to use it for
%T-fold cross validation in the bundle-bilevel algorithm
%   The algorithm takes a data set, does a permutation of the set, parts it
%   and divides it into a trainings and a validation (hold out) partition.
%   Finally the trainings partition is divided and stacked in a way to use
%   it for T-fold cross validation.

% input arguments
% name      obgect  
% data      name of data set or data set
% T         number of folds
% G         number of groups
% import    0,1 binary varible to specify whether the data is to be impored
%           or already given in the 'data' input argument

% output arguments
%                  --> dimensions
% Xtrain    array  --> features x size of training set x number of folds x
%                       number of groups
% Ytrain    matrix --> size of training set x number of folds x number of
%                       groups

% load the set
% check if data has to be imported or is already there
if import
    data = importdata(data);
end
[feat, nd] = size(data);

% do a random permutation of the set
i = randperm(nd);
data = data(:,i);

% take only specified part of data set for training
% crop the set, so that all partitions have equal size
J = floor(nd/(T*G));
JG = J*G;

Xtrain = zeros(feat,J,T,G);
Ytrain = zeros(J,T,G);
tmp = zeros(feat,JG,T);

for t = 1:T
    tmp(:,:,t) = data(:,(t-1)*JG+1:JG*t);
end
for g = 1:G
    for t = 1:T
        Xtrain(:,:,t,g) = [tmp(1:end-1,(g-1)*J+1:J*g,t);ones(1,J)];
        Ytrain(:,t,g) = tmp(end,(g-1)*J+1:J*g,t)';
    end
end

end