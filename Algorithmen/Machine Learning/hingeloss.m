function [ theta ] = hingeloss( W, b, y, X )
%HINGELOSS calculates the hinge loss of a classification task

[Nt,T] = size(y);
[feat,~] = size(W);
res = 0;
for i = 1:T
    res = res+1/Nt*...    
    sum(max(ones(Nt,1)-y(:,i).*(X(:,(i-1)*feat+1:feat*i)*W(:,i)-b(i)*ones(Nt,1)),0));
end
    
theta = 1/T*res;


end

