function [ Xtrain, Ytrain, Xval, Yval ] = precond_data( data, T, trainpart, import )
% preconditioning of a data set to use it for
% T-fold cross validation in my bundle-bilevel-regression algorithm


% load the set
% check if data has to be imported or is already there
if import
    data = importdata(data);
end
[rows, columns] = size(data);

% do a random permutation of the set:
i = randperm(rows);
data = data(i,:);

% take only specified part of data set for training
rows = floor(rows*trainpart);

% crop the set, so that all partitions have equal size
J = floor(rows/T);
JT = J*T;

% divide into X and Y
X = data(1:JT,1:columns-1);
Y = data(1:JT,columns);

% stack into 3 dimensional array according to partitions
Xtrain = reshape(X',columns-1,J,T);
Ytrain = reshape(Y,J,T);

% prepare rest as validation set
Xval = data(JT+1:end,1:columns-1);
Yval = data(JT+1:end,columns);
end