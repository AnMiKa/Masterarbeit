function [ data_standard ] = standardize_data( data, import )
%STANDARDIZE_DATA standardizes a data set to zero mean and unit standard
%deviation

% input arguments
% data      name of the data set to be imported or data set to be standardized
% import    0,1 binary varible to decide whether the data is imported or
%           directly taken as the 'data' input

% output arguments
% data_standard     standardized data

% load the set
% check if data has to be imported or is already there
if import
    data = importdata(data);
end
data_short = data(:,1:end-1);

% calculate the mean of every column (except label column)
mu = mean(data_short);

% calculate the standard deviation fo every column (except label column)
sigma = std(data_short);

% calculate standardized data
data_short = bsxfun(@rdivide,bsxfun(@minus,data_short,mu),sigma);
data_standard = [data_short data(:,end)];
end

