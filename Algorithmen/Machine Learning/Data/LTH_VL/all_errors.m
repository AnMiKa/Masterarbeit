function [ rate, errh, errm] = all_errors( w, test_data )

%errorrate(w,test_data)
[n,~] = size(test_data.X);
y_test = ([ones(n,1) test_data.X]*w > 0);
k = find(y_test ~= test_data.y);
rate = length(k)/n;

%postpro_err_misclass( w, b, X, Y )
b = -w(1);
w = w(2:end);
X = test_data.X;
X = X';
Y = test_data.y;
i = Y == 0;
Y(i) = -1;
[~,J] = size(X);
i = -Y.*(X'*w-b) > 0;
errm = 1/J*sum(i);
i = find(i==1);

%postpro_err_hinge( w, b, X, Y )
j = max(ones(J,1)-Y.*(X'*w-b),0);
errh = 1/J*sum(j);
j = find(j>=1);

end

