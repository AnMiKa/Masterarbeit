function [ X, Y ] = precond_data( data, T )
% preconditioning of a data set to use it for
% T-fold cross validation in my bundle-bilevel-regression algorithm


% load the set 
data = importdata(data);
[rows, columns] = size(data);

% do a random permutation of the set:
i = randperm(rows);
data = data(i,:);

% crop the set, so that all partitions have equal size
J = floor(rows/T);
tmp = J*T;
data = data(1:tmp,:);

% divide into X and Y
X = data(:,1:columns-1);
Y = data(:,columns);

% stack into 3 dimensional array according to partitions
X = reshape(X',columns-1,J,T);
Y = reshape(Y,J,T);
end