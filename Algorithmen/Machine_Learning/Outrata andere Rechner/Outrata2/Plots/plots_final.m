% Plots final Outrata / Machine Learning

% Cancer, Ionosphere, Box
figure('position',[10 10 400 320])
hold on 
box on
plot(C1,errf_can./100,'m')
plot(C1,errf_ion./100,'b')
plot(C1,errf_box./100,'c')


ylabel('Hingequadloss','Interpreter','latex','Color','k')
legend('Cancer','Ionosphere','SynBox')
title('Hingequadloss for different $C$-values','Interpreter','latex')
xlabel('$C$','Interpreter','latex')
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

% 2. Cancer, Ionosphere, Box
figure('position',[10 10 400 320])
hold on 
box on
C05 = C1(1:500);

plot(C05,errf_can(1:500)./100,'m')
plot(C05,errf_ion(1:500)./100,'b')
plot(C05,errf_box(1:500)./100,'c')


ylabel('Hingequadloss','Interpreter','latex','Color','k')
legend('Cancer','Ionosphere','SynBox')
title('Hingequadloss for different $C$-values','Interpreter','latex')
xlabel('$C$','Interpreter','latex')
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

% Synsmall, Synbig
figure('position',[10 10 400 320])
hold on
box on

yyaxis left
plot(C2,errf_sys./100,'m')
set(gca,'ycolor','m')
ylabel('Hingequadloss','Interpreter','latex','Color','k')

yyaxis right
plot(C2,errf_syb./100,'b')
set(gca,'ycolor','b')

legend('SynSmall','SynBig')
title('Hingequadloss for different $C$-values','Interpreter','latex')
xlabel('$C$','Interpreter','latex')
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
