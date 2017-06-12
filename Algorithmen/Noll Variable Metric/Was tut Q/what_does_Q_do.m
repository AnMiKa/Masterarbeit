% 'What does Q do' script

%% Hare-Algorithm
% objective function: f4_testfunction
% starting value: x0 = 1.5
% f = bundle_nonconv_inex(1.5,@f4_testfunction,@subgr_f4_testfunction);
% results: k=15, i_null = 1, f= 1.5099e-07

% starting value
x0 = 1.5;
% preallocation for point sequence
seqx = zeros(1,15);
seqy = zeros(1,15);
% define x-range for plots
x_range = -2:0.01:3;
lx = length(x_range);
%% first plot
figure
hold on
% plot graph of objective
y1 = zeros(1,lx);
for i = 1:lx
    y1(i) = f4_testfunction(x_range(i));
end
plot(x_range,y1)
% plot starting value
seqx(1) = x0;
seqy(1) = f4_testfunction(x0);
plot(seqx(1),seqy(1),'*m')
% plot tangent at starting value
for i=1:lx
    y1(i) = f4_testfunction(x_hat)+g*(x_range(i)-x_hat);
end
plot(x_range,y1,'c')
% plot model function
for i=1:lx
y1(i) = f_hat+(x_range(i)-x_hat)*s-c+1/(2*t)*(x_range(i)-x_hat)^2;
end
plot(x_range,y1,'c')

%% other plots
figure
hold on
% plot graph of objective
y1 = zeros(1,lx);
for i = 1:lx
    y1(i) = f4_testfunction(x_range(i));
end
plot(x_range,y1)
% plot sequence values
seqx(2) = x(2);
seqy(2) = f4_testfunction(x(2));
plot(seqx(1:2),seqy(1:2),'*m')
% plot convexified objective
for i=1:lx
    y1(i) = f4_testfunction(x_range(i))+eta/2*(x_range(i)-x_hat)^2;
end
plot(x_range,y1,'b')
% plot model function
for i=1:lx
y1(i) = f_hat+max((x_range(i)-x_hat)*s-c')+1/(2*t)*(x_range(i)-x_hat)^2;
end
plot(x_range,y1,'c')

%% Noll Algorithm, BFGS scaled
% objective function: f4_testfunction
% starting value: x0 = 1.5
f = noll_variable_metric_nonconv_inex(1.5,@f4_testfunction,@subgr_f4_testfunction);
% results: k=16, i_null = 1, f= 7.9465e-07

% starting value
x0 = 1.5;
% preallocation for point sequence
seqx = zeros(1,15);
seqy = zeros(1,15);
% define x-range for plots
x_range = -2:0.01:3;
lx = length(x_range);
%% first plot
figure
hold on
% plot graph of objective
y1 = zeros(1,lx);
for i = 1:lx
    y1(i) = f4_testfunction(x_range(i));
end
plot(x_range,y1)
% plot starting value
seqx(1) = x0;
seqy(1) = f4_testfunction(x0);
plot(seqx(1),seqy(1),'*m')
% plot tangent at starting value
for i=1:lx
    y1(i) = f4_testfunction(x_hat)+g*(x_range(i)-x_hat);
end
plot(x_range,y1,'c')
% plot model function
for i=1:lx
y1(i) = f_hat+(x_range(i)-x_hat)*s-c+1/2*(Q+1/t)*(x_range(i)-x_hat)^2;
end
plot(x_range,y1,'c')

%% other plots
figure
hold on
% plot graph of objective
y1 = zeros(1,lx);
for i = 1:lx
    y1(i) = f4_testfunction(x_range(i));
end
plot(x_range,y1)
% plot sequence values
seqx(2) = x(2);
seqy(2) = f4_testfunction(x(2));
plot(seqx(2),seqy(2),'*k')
plot(seqx(2),seqy(2),'*m')
% plot convexified objective
for i=1:lx
    y1(i) = f4_testfunction(x_range(i))+(eta+Q)/2*(x_range(i)-x_hat)^2;
end
plot(x_range,y1,'b')
% plot (nonconvexified) second order model  
for i=1:lx
    y1(i) = f_hat+max(g*(x_range(i)-x_hat)-c')+Q/2*(x_range(i)-x_hat)^2;
end
plot(x_range,y1,'--b')
% plot model function
for i=1:lx
    y1(i) = f_hat+max((x_range(i)-x_hat)*s-c')+1/2*(Q+1/t)*(x_range(i)-x_hat)^2;
end
plot(x_range,y1,'c')
% plot nonconvexified model function
for i=1:lx
    y1(i) = f_hat+max((x_range(i)-x_hat)*g-c')+1/2*(Q+1/t)*(x_range(i)-x_hat)^2;
end
plot(x_range,y1,'--c')
% plot cutting plane model
for i=1:lx
    y1(i) = f_hat+max(g*(x_range(i)-x_hat)-e');
end
plot(x_range,y1,'g')
% plot convexified cutting plane model
for i=1:lx
    y1(i) = f_hat+max(s*(x_range(i)-x_hat)-c');
end
plot(x_range,y1,'--g')
