% Plotting Script Reseults

%% Auswertung 1

% %% Cmin
% % figure('position',[10 10 400 320])
% % hold on 
% % box on
% % 
% % 
% % x = 1:5;
% % % scaling 1
% % for i = 1:5 % strating value
% %     yyaxis left
% %     stem(x(1:3)+(i-1)*.15,CminH1(1:3,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% %     stem(x(1:3)+(i-1)*.15,CminN1(1:3,i), 'p:c','filled','LineWidth',1.2)
% %     stem(x(1:3)+(i-1)*.15,CminMS1(1:3,i), 'x:m','filled','LineWidth',1.2)
% %     set(gca,'ycolor','k')
% %     ylabel('$C_{min}$','Interpreter','latex')
% %     axis([0.85, 6, 0, 0.1])
% %     yyaxis right
% %     stem(x(4:5)+(i-1)*.15,CminH1(4:5,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% %     stem(x(4:5)+(i-1)*.15,CminN1(4:5,i), 'p:c','filled','LineWidth',1.2)
% %     stem(x(4:5)+(i-1)*.15,CminMS1(4:5,i), 'x:m','filled','LineWidth',1.2)
% %     set(gca,'ycolor','k')
% % end
% % 
% % legend('Nonconv Inex Bundle', 'Variable Metric BFGS', 'fminsearch', 'Location','northwest')
% % title('Scaling 1','Interpreter','latex')
% % xlabel('data set','Interpreter','latex')
% % xticks(1:6)
% % xticklabels({'can','ion','box','sys','syb'})
% % pbaspect([1 2/3 1])
% % ax = gca;
% % outerpos = ax.OuterPosition;
% % ti = ax.TightInset;
% % left = outerpos(1) + ti(1);
% % bottom = outerpos(2) + ti(2);
% % ax_width = outerpos(3) - ti(1) - ti(3);
% % ax_height = outerpos(4) - ti(2) - ti(4);
% % ax.Position = [left bottom ax_width ax_height];
% 
% figure('position',[10 10 400 320])
% hold on 
% box on
% 
% 
% x = 1:5;
% % scaling 100
% for i = 1:5 % strating value
%     yyaxis left
%     stem(x(1:3)+(i-1)*.15,CminH100(1:3,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
%     stem(x(1:3)+(i-1)*.15,CminN100(1:3,i), 'p:c','filled','LineWidth',1.2)
%     stem(x(1:3)+(i-1)*.15,CminMS(1:3,i), 'x:m','filled','LineWidth',1.2)
%     set(gca,'ycolor','k')
%     ylabel('$C_{min}$','Interpreter','latex')
%     axis([0.85, 6, 0, 0.1])
%     yyaxis right
%     stem(x(4:5)+(i-1)*.15,CminH100(4:5,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
%     stem(x(4:5)+(i-1)*.15,CminN100(4:5,i), 'p:c','filled','LineWidth',1.2)
%     stem(x(4:5)+(i-1)*.15,CminMS(4:5,i), 'x:m','filled','LineWidth',1.2)
%     set(gca,'ycolor','k')
% end
% 
% legend('Nonconv Inex Bundle', 'Variable Metric BFGS', 'fminsearch', 'Location','northwest')
% title('Scaling 100','Interpreter','latex')
% xlabel('data set','Interpreter','latex')
% xticks(1:6)
% xticklabels({'can','ion','box','sys','syb'})
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
% fval
figure('position',[10 10 400 320])
hold on 
box on


x = 1:5;
% scaling 1
for i = 1:5 % strating value
    yyaxis left
    stem(x(1:3)+(i-1)*.15,fvalH1(1:3,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
    stem(x(1:3)+(i-1)*.15,fvalN1(1:3,i), 'p:c','filled','LineWidth',1.2)
    stem(x(1:3)+(i-1)*.15,fvalMS1(1:3,i), 'x:m','filled','LineWidth',1.2)
    set(gca,'ycolor','k')
    axis([0.85, 6, 0, 1.2])
    ylabel('$f$ value','Interpreter','latex')
    yyaxis right
    stem(x(4:5)+(i-1)*.15,fvalH1(4:5,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
    stem(x(4:5)+(i-1)*.15,fvalN1(4:5,i), 'p:c','filled','LineWidth',1.2)
    stem(x(4:5)+(i-1)*.15,fvalMS1(4:5,i), 'x:m','filled','LineWidth',1.2)
    set(gca,'ycolor','k')
    axis([0.85, 6, 0, 0.02])
end

legend('Nonconv Inex Bundle', 'Variable Metric BFGS', 'fminsearch', 'Location','northwest')
title('Scaling 1','Interpreter','latex')
xlabel('data set','Interpreter','latex')
xticks(1:6)
xticklabels({'can','ion','box','sys','syb'})
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

figure('position',[10 10 400 320])
hold on 
box on

%%
x = 1:5;
% scaling 100
for i = 1:5 % strating value
    yyaxis left
    stem(x(1:3)+(i-1)*.15,fvalH100(1:3,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
    stem(x(1:3)+(i-1)*.15,fvalN100(1:3,i), 'p:c','filled','LineWidth',1.2)
    stem(x(1:3)+(i-1)*.15,fvalMS(1:3,i), 'x:m','filled','LineWidth',1.2)
    set(gca,'ycolor','k')
    axis([0.85, 6, 0, 120])
    ylabel('$f$ value','Interpreter','latex')
    yyaxis right
    stem(x(4:5)+(i-1)*.15,fvalH100(4:5,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
    stem(x(4:5)+(i-1)*.15,fvalN100(4:5,i), 'p:c','filled','LineWidth',1.2)
    stem(x(4:5)+(i-1)*.15,fvalMS(4:5,i), 'x:m','filled','LineWidth',1.2)
    set(gca,'ycolor','k')
    axis([0.85, 6, 0, 2])
end

legend('Nonconv Inex Bundle', 'Variable Metric BFGS', 'fminsearch', 'Location','northwest')
title('Scaling 100','Interpreter','latex')
xlabel('data set','Interpreter','latex')
xticks(1:6)
xticklabels({'can','ion','box','sys','syb'})
pbaspect([1 2/3 1])
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

%% time
% figure('position',[10 10 400 320])
% hold on 
% box on
% 
% 
% x = 1:5;
% % scaling 1
% for i = 1:5 % strating value
%     yyaxis left
%     stem(x(1:4)+(i-1)*.15,timeH1(1:4,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
%     stem(x(1:4)+(i-1)*.15,timeN1(1:4,i), 'p:c','filled','LineWidth',1.2)
%     stem(x(1:4)+(i-1)*.15,timeMS1(1:4,i), 'x:m','filled','LineWidth',1.2)
%     set(gca,'ycolor','k')
%     ylabel('time','Interpreter','latex')
%     axis([0.85, 6, 0, 50])
%     yyaxis right
%     stem(x(5)+(i-1)*.15,timeH1(5,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
%     stem(x(5)+(i-1)*.15,timeN1(5,i), 'p:c','filled','LineWidth',1.2)
%     stem(x(5)+(i-1)*.15,timeMS1(5,i), 'x:m','filled','LineWidth',1.2)
%     set(gca,'ycolor','k')
% end
% 
% legend('Nonconv Inex Bundle', 'Variable Metric BFGS', 'fminsearch', 'Location','northwest')
% title('Scaling 1','Interpreter','latex')
% xlabel('data set','Interpreter','latex')
% xticks(1:6)
% xticklabels({'can','ion','box','sys','syb'})
% pbaspect([1 2/3 1])
% ax = gca;
% outerpos = ax.OuterPosition;
% ti = ax.TightInset;
% left = outerpos(1) + ti(1);
% bottom = outerpos(2) + ti(2);
% ax_width = outerpos(3) - ti(1) - ti(3);
% ax_height = outerpos(4) - ti(2) - ti(4);
% ax.Position = [left bottom ax_width ax_height];
% figure('position',[10 10 400 320])
% hold on 
% box on
% 
% x = 1:5;
% % scaling 100
% for i = 1:5 % strating value
%     yyaxis left
%     stem(x(1:4)+(i-1)*.15,timeH100(1:4,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
%     stem(x(1:4)+(i-1)*.15,timeN100(1:4,i), 'p:c','filled','LineWidth',1.2)
%     stem(x(1:4)+(i-1)*.15,timeMS(1:4,i), 'x:m','filled','LineWidth',1.2)
%     set(gca,'ycolor','k')
%     axis([0.85, 6, 0, 500])
%     ylabel('time','Interpreter','latex')
%     yyaxis right
%     stem(x(5)+(i-1)*.15,timeH100(5,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
%     stem(x(5)+(i-1)*.15,timeN100(5,i), 'p:c','filled','LineWidth',1.2)
%     stem(x(5)+(i-1)*.15,timeMS(5,i), 'x:m','filled','LineWidth',1.2)
%     set(gca,'ycolor','k')
% end
% 
% legend('Nonconv Inex Bundle', 'Variable Metric BFGS', 'fminsearch', 'Location','northwest')
% title('Scaling 100','Interpreter','latex')
% xlabel('data set','Interpreter','latex')
% xticks(1:6)
% xticklabels({'can','ion','box','sys','syb'})
% pbaspect([1 2/3 1])
% ax = gca;
% outerpos = ax.OuterPosition;
% ti = ax.TightInset;
% left = outerpos(1) + ti(1);
% bottom = outerpos(2) + ti(2);
% ax_width = outerpos(3) - ti(1) - ti(3);
% ax_height = outerpos(4) - ti(2) - ti(4);
% ax.Position = [left bottom ax_width ax_height];


% %% k
% figure('position',[10 10 400 320])
% hold on 
% box on
% 
% x = 1:5;
% % scaling 1
% for i = 1:5 % strating value
%     yyaxis left
%     stem(x(1:4)+(i-1)*.15,stepsH100(1:4,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
%     stem(x(1:4)+(i-1)*.15,stepsN100(1:4,i), 'p:c','filled','LineWidth',1.2)
%     %stem(x(1:4)+(i-1)*.15,stepsMS(1:4,i), 'x:m','filled','LineWidth',1.2)
%     set(gca,'ycolor','k')
%     axis([0.85, 6, 0, 100])
%     ylabel('steps','Interpreter','latex')
%     yyaxis right
%     stem(x(5)+(i-1)*.15,stepsH100(5,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
%     stem(x(5)+(i-1)*.15,stepsN100(5,i), 'p:c','filled','LineWidth',1.2)
%     %stem(x(5)+(i-1)*.15,stepsMS(5,i), 'x:m','filled','LineWidth',1.2)
%     set(gca,'ycolor','k')
% end
% 
% legend('Nonconv Inex Bundle', 'Variable Metric BFGS', 'fminsearch', 'Location','northwest')
% title('Scaling 1','Interpreter','latex')
% xlabel('data set','Interpreter','latex')
% xticks(1:6)
% xticklabels({'can','ion','box','sys','syb'})
% pbaspect([1 2/3 1])
% ax = gca;
% outerpos = ax.OuterPosition;
% ti = ax.TightInset;
% left = outerpos(1) + ti(1);
% bottom = outerpos(2) + ti(2);
% ax_width = outerpos(3) - ti(1) - ti(3);
% ax_height = outerpos(4) - ti(2) - ti(4);
% ax.Position = [left bottom ax_width ax_height];
