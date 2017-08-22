% script for plotting the upper level objective of the bilevel function

% Vector of C-values
C = linspace(1,25,1000);

% data set for which to plot
X = Xtsyb;
Y = Ytsyb;

%errf = zeros(1,length(C));
%subgr = zeros(1,length(C));
% calculate all errors for

for c = 964:length(C)
    [W,~,subgr(c)] = solve_ll_and_subgr(C(c),X,Y);
    %W = solve_ll_lambda(C(c),X,Y);
    errf(c) = ul_obj_class_hingequad(X,Y,W);
end

figure
hold on
% for l = 1:100:length(C)
%     x = linspace(C(1),C(end),50);
%     y = dfdC_num(l)*x+(errfl(l)-dfdC_num(l)*C(l));
%     plot(x,y,'b')
% end
plot(C,errf,'m')


