% plotting lambda vs. the error for the different data sets used


%% Cancer and Ionosphere

% lambda = 0:0.01:15;
% 
% [err_ca, norm_Wca] = lambda_range_plot(Xtcancer,Ytcancer,lambda);
% [err_io, norm_Wio] = lambda_range_plot(Xtionosphere,Ytionosphere,lambda);
% 
% % plot lambda vs. error
% figure('position',[0 0 400 300])
% hold on
% box on
% 
% yyaxis left
% plot(lambda,err_ca,'m');
% set(gca,'ycolor','m')
% ylabel('Hingeloss','Interpreter','latex','Color','k')
% 
% yyaxis right
% plot(lambda,err_io,'b');
% set(gca,'ycolor','b')
% 
% 
% % Add a legend
% legend('Cancer','Ionosphere')
% title('Hingeloss for different $\lambda$','Interpreter','latex')
% xlabel('$\lambda$','Interpreter','latex')
% %axis([0.85, 6, 0, 9.5])
% %xticks(1:6)
% %xticklabels([20,25,30,40,50])
% pbaspect([1 2/3 1])
% ax = gca;
% outerpos = ax.OuterPosition;
% ti = ax.TightInset; 
% left = outerpos(1) + ti(1);
% bottom = outerpos(2) + ti(2);
% ax_width = outerpos(3) - ti(1) - ti(3);
% ax_height = outerpos(4) - ti(2) - ti(4);
% ax.Position = [left bottom ax_width ax_height];
% 

%% syntheitc data (small, big, box)

lambda = 0:0.01:15;

[err_ss, norm_Wss] = lambda_range_plot(Xtsynsmall,Ytsynsmall,lambda);
[err_b5, norm_Wb5] = lambda_range_plot(Xtbox5,Ytbox5,lambda);

% plot lambda vs. error
figure('position',[0 0 400 300])
hold on
box on

yyaxis left
plot(lambda,err_ss,'m')
plot(0:0.1:15,err_big,'c')
set(gca,'ycolor','k')
ylabel('Hingeloss','Interpreter','latex','Color','k')

yyaxis right
plot(lambda,err_b5,'b')
set(gca,'ycolor','b')


% Add a legend
legend('syn small', 'syn big', 'syn box')
title('Hingeloss for different $\lambda$','Interpreter','latex')
xlabel('$\lambda$','Interpreter','latex')
%axis([0.85, 6, 0, 9.5])
%xticks(1:6)
%xticklabels([20,25,30,40,50])
set(gca,'ygrid','on')
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];