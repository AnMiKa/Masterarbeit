%% Ungenaues Adjoint/Subproblem

%% Cmin
% figure('position',[10 10 400 320])
% hold on 
% box on
% 
% x = 1:5;
% 
% yyaxis left
% x1 = 1:0.01:1.85; y1 = CminMB6(1)*ones(86,1); plot(x1,y1,'-k')
% x2 = 2:0.01:2.85; y2 = CminMB6(2)*ones(86,1); plot(x2,y2,'-k')
% x3 = 3:0.01:3.85; y3 = CminMB6(3)*ones(86,1); plot(x3,y3,'-k')
% 
% p1 = stem(x(1:3),CminMB4(1:3), 'x:m','filled','LineWidth',1.2);
% p2 = stem(x(1:3)+0.15,CminH100(1:3,3), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2);
% p3 = stem(x(1:3)+0.15,CminN100(1:3,3), 'p:c','filled','LineWidth',1.2);
% stem(x(1:3)+0.3,CminH158(1:3), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(1:3)+0.3,CminN158(1:3), 'p:c','filled','LineWidth',1.2)
% stem(x(1:3)+0.45,CminH815(1:3), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(1:3)+0.45,CminN815(1:3), 'p:c','filled','LineWidth',1.2)
% stem(x(1:3)+0.6,CminH88(1:3), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(1:3)+0.6,CminN88(1:3), 'p:c','filled','LineWidth',1.2)
% set(gca,'ycolor','k')
% axis([0.85, 6, 0, 0.8])
% ylabel('$C_{min}$','Interpreter','latex')
% 
% yyaxis right
% x4 = 4:0.01:4.85; y4 = CminMB6(4)*ones(86,1); plot(x4,y4,'-k')
% x5 = 5:0.01:5.85; y5 = CminMB6(5)*ones(86,1); plot(x5,y5,'-k')
% stem(x(4:5),CminMB4(4:5), 'x:m','filled','LineWidth',1.2)
% stem(x(4:5)+0.15,CminH100(4:5,3), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(4:5)+0.15,CminN100(4:5,3), 'p:c','filled','LineWidth',1.2)
% stem(x(4:5)+0.3,CminH158(4:5), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(4:5)+0.3,CminN158(4:5), 'p:c','filled','LineWidth',1.2)
% stem(x(4:5)+0.45,CminH815(4:5), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(4:5)+0.45,CminN815(4:5), 'p:c','filled','LineWidth',1.2)
% stem(x(4:5)+0.6,CminH88(4:5), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(4:5)+0.6,CminN88(4:5), 'p:c','filled','LineWidth',1.2)
% set(gca,'ycolor','k')
% axis([0.85, 6, 0, 20])
% 
% legend([p1 p2 p3],{'fminbnd','Nonconv Inex Bundle','Variable Metric BFGS'},'Location','northwest');
% title('Solutions for dfferent types of inexactness ($10^{-8}$)','Interpreter','latex')
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

%% fval
figure('position',[10 10 400 320])
hold on 
box on

x = 1:5;

yyaxis left
x1 = 1:0.01:1.85; y1 = fvalMB6(1)*ones(86,1); plot(x1,y1,'-k')
x2 = 2:0.01:2.85; y2 = fvalMB6(2)*ones(86,1); plot(x2,y2,'-k')
x3 = 3:0.01:3.85; y3 = fvalMB6(3)*ones(86,1); plot(x3,y3,'-k')

p1 = stem(x(1:3),fvalMB8(1:3), 'x:m','filled','LineWidth',1.2);
p2 = stem(x(1:3)+0.15,fvalH100(1:3,3), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2);
p3 = stem(x(1:3)+0.15,fvalN100(1:3,3), 'p:c','filled','LineWidth',1.2);
stem(x(1:3)+0.3,fvalH158(1:3), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
stem(x(1:3)+0.3,fvalN158(1:3), 'p:c','filled','LineWidth',1.2)
stem(x(1:3)+0.45,fvalH815(1:3), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
stem(x(1:3)+0.45,fvalN815(1:3), 'p:c','filled','LineWidth',1.2)
stem(x(1:3)+0.6,fvalH88(1:3), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
stem(x(1:3)+0.6,fvalN88(1:3), 'p:c','filled','LineWidth',1.2)
set(gca,'ycolor','k')
axis([0.85, 6, 0, 120])
ylabel('$f$ value','Interpreter','latex')

yyaxis right
x4 = 4:0.01:4.85; y4 = fvalMB6(4)*ones(86,1); plot(x4,y4,'-k')
x5 = 5:0.01:5.85; y5 = fvalMB6(5)*ones(86,1); plot(x5,y5,'-k')
stem(x(4:5),fvalMB8(4:5), 'x:m','filled','LineWidth',1.2)
stem(x(4:5)+0.15,fvalH100(4:5,3), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
stem(x(4:5)+0.15,fvalN100(4:5,3), 'p:c','filled','LineWidth',1.2)
stem(x(4:5)+0.3,fvalH158(4:5), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
stem(x(4:5)+0.3,fvalN158(4:5), 'p:c','filled','LineWidth',1.2)
stem(x(4:5)+0.45,fvalH815(4:5), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
stem(x(4:5)+0.45,fvalN815(4:5), 'p:c','filled','LineWidth',1.2)
stem(x(4:5)+0.6,fvalH88(4:5), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
stem(x(4:5)+0.6,fvalN88(4:5), 'p:c','filled','LineWidth',1.2)
axis([0.85, 6, 0, 1.8])
set(gca,'ycolor','k')

legend([p1 p2 p3],{'fminbnd','Nonconv Inex Bundle','Variable Metric BFGS'},'Location','northwest');
title('Solutions for dfferent types of inexactness ($10^{-8}$)','Interpreter','latex')
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
% 
% %% time
% figure('position',[10 10 400 320])
% hold on 
% box on
% 
% x = 1:5;
% 
% yyaxis left
% x1 = 1:0.01:1.85; y1 = timeMB6(1)*ones(86,1); plot(x1,y1,'-k')
% x2 = 2:0.01:2.85; y2 = timeMB6(2)*ones(86,1); plot(x2,y2,'-k')
% x3 = 3:0.01:3.85; y3 = timeMB6(3)*ones(86,1); plot(x3,y3,'-k')
% 
% p1 = stem(x(1:4),timeMB4(1:4), 'x:m','filled','LineWidth',1.2);
% p2 = stem(x(1:4)+0.15,timeH100(1:4,3), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2);
% p3 = stem(x(1:4)+0.15,timeN100(1:4,3), 'p:c','filled','LineWidth',1.2);
% stem(x(1:4)+0.3,timeH154(1:4), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(1:4)+0.3,timeN154(1:4), 'p:c','filled','LineWidth',1.2)
% stem(x(1:4)+0.45,timeH415(1:4), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(1:4)+0.45,timeN415(1:4), 'p:c','filled','LineWidth',1.2)
% stem(x(1:4)+0.6,timeH44(1:4), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(1:4)+0.6,timeN44(1:4), 'p:c','filled','LineWidth',1.2)
% x4 = 4:0.01:4.85; y4 = timeMB6(4)*ones(86,1); plot(x4,y4,'-k')
% set(gca,'ycolor','k')
% axis([0.85, 6, 0, 1000])
% ylabel('time','Interpreter','latex')
% 
% yyaxis right
% x5 = 5:0.01:5.85; y5 = timeMB6(5)*ones(86,1); plot(x5,y5,'-k')
% stem(x(5),timeMB4(5), 'x:m','filled','LineWidth',1.2)
% stem(x(5)+0.15,timeH100(5,3), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(5)+0.15,timeN100(5,3), 'p:c','filled','LineWidth',1.2)
% stem(x(5)+0.3,timeH154(5), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(5)+0.3,timeN154(5), 'p:c','filled','LineWidth',1.2)
% stem(x(5)+0.45,timeH415(5), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(5)+0.45,timeN415(5), 'p:c','filled','LineWidth',1.2)
% stem(x(5)+0.6,timeH44(5), 'LineStyle',':','Color','b','Marker','+','LineWidth',1.2)
% stem(x(5)+0.6,timeN44(5), 'p:c','filled','LineWidth',1.2)
% %axis([0.85, 6, 0, 2])
% set(gca,'ycolor','k')
% 
% legend([p1 p2 p3],{'fminbnd','Nonconv Inex Bundle','Variable Metric BFGS'},'Location','northwest');
% title('Solutions for dfferent types of inexactness ($10^{-4}$)','Interpreter','latex')
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