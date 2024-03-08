% PI1 & PI2 绘图

close all
% figure('Position',[488/3   342/3   560*1.5   420*1])
cla = {'r','-.b'};
sub1 = subplot(2,1,1);
plot(Time,B_PI1,cla{1},'LineWidth',1.5);
hold on
plot(Time,N_PI1,cla{2},'LineWidth',1.5);
ylabel('$\mathbf{PI_1}$','interpreter','latex');
% xlabel('\bf Time(s)','interpreter','latex');
legend('Proposed','NDTUs');%,'Location','northoutside','Orientation','horizontal');
set(gca,'FontSize',11)
hold on
axes('position', [0.35 0.7 0.3 0.15]);
plot(Time,B_PI1,cla{1},'LineWidth',1.5);
hold on
plot(Time,N_PI1,cla{2},'LineWidth',1.5);
hold on
axis([8 14 0 0.02]);
set(gca,'FontSize',11)

sub2 = subplot(2,1,2);
plot(Time,B_PI2,cla{1},'LineWidth',1.5);
hold on
plot(Time,N_PI2,cla{2},'LineWidth',1.5);

ylabel('$\mathbf{PI_2}$','interpreter','latex');
xlabel('\bf Time(s)','interpreter','latex');
set(gca,'FontSize',11)
hold on
axes('position', [0.35 0.2 0.3 0.15]);
plot(Time,B_PI2,cla{1},'LineWidth',1.5);
hold on
plot(Time,N_PI2,cla{2},'LineWidth',1.5);
hold on
axis([8 14 0 0.02]);
set(gca,'FontSize',11)