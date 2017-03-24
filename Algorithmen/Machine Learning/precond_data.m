% Preprocessing
function [ Xtrain, Ytrain, Xval, Yval ] = precond_data( data, T, trainpart, import )
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
% trainpart fraction of the set that is taken for training or index set
%           that specifies the instances that are in the trainingsset
% import    0,1 binary varible to specify whether the data is to be impored
%           or already given in the 'data' input argument

% output arguments
%                  --> dimensions
% Xtrain    array  --> features x size of training set x number of folds
% Ytrain    matrix --> size of training set x number of folds
% Xval      matrix --> features x size of validation set
% Ytrain    vector --> size of validation set

% load the set
% check if data has to be imported or is already there
if import
    data = importdata(data);
end
[rows, columns] = size(data);

% do a random permutation of the set
i = randperm(rows);
data = data(i,:);

% take only specified part of data set for training
if length(trainpart) == 1 % if a part (e.g. 1/3) of the set is specified to
                          % be the training set
    if (trainpart > 1) || (trainpart < 0)
        error('trainpart must be a number in (0,1] or an index set. \n')
    end
    rows = floor(rows*trainpart);
    % crop the set, so that all partitions have equal size
    J = floor(rows/T);
    JT = J*T;
    % divide into X and Y
    X = data(1:JT,1:columns-1);
    Y = data(1:JT,columns);
else % if a specific index set is given to specify the instances of the
     % trainings set
     if rem(length(trainpart),T) ~= 0
         error('The size of the training set must allow division into the specified %d folds.\n', T)
     end
    % divide into X and Y
    X = data(trainpart,1:columns-1);
    Y = data(trainpart,columns);
    J = length(trainpart)/T;
    JT = J*T;
end

% stack into 3 dimensional array according to partitions
Xtrain = reshape(X',columns-1,J,T);
Ytrain = reshape(Y,J,T);

% prepare rest as validation set
Xval = data(JT+1:end,1:columns-1)';
Yval = data(JT+1:end,columns);
end