% Control torque for each spacecraft
close all
DataState = B_ControlCmd;
%-x-axis plot
x = [];
i = 1;
% cla = {'--r', 'g','b','-.magenta','cyan','-.k'}; 
figure('Position',[488/3   342/3   560*1.5   420*1.5])

cla = {'--r', 'g','b','-.k'}; 
for j=1:3:size(DataState,2)
    x = [x,DataState(:,j)];
    i = i+1;
end
sub1 = subplot(3,1,1);
for i=1:4
    plot(Time,x(:,i),cla{i},'LineWidth',1.5)
    hold on
end
% plot(Time,x,cla)
ylabel('$\bf u_{i,1}$','interpreter','latex');
% xlim([0 5]);
ylim([-60 20]);
set(gca,'FontSize',12)
axes('position', [0.35 0.76 0.4 0.15]);
for i=1:4
    plot(Time,x(:,i),cla{i},'LineWidth',1.5)
    hold on
end
hold on
axis([4 8 -0.5 0.5]);
set(gca,'FontSize',11)

% y axis plot
y = [];
i = 1;
for j=2:3:size(DataState,2)
    y = [y,DataState(:,j)];
    i = i+1;
end
sub2 = subplot(3,1,2);
for i=1:4
    plot(Time,y(:,i),cla{i},'LineWidth',1.5)
    hold on
end
ylabel('$\bf u_{i,2}$','interpreter','latex');
% xlim([0 5]);
ylim([-60 20]);
set(gca,'FontSize',12)
axes('position', [0.35 0.46 0.4 0.15]);
for i=1:4
    plot(Time,y(:,i),cla{i},'LineWidth',1.5)
    hold on
end
hold on
axis([4 8 -0.35 0.35]);
set(gca,'FontSize',11)

% z axis plot
z = [];
i = 1;
for j=3:3:size(DataState,2)
    z = [z,DataState(:,j)];
    i = i+1;
end
sub3 = subplot(3,1,3);
for i=1:4
    plot(Time,z(:,i),cla{i},'LineWidth',1.5)
    hold on
end
% ylabel(['X-axis quaternion errors (deg)'],'interpreter','latex');
ylabel('$\bf u_{i,3}$','interpreter','latex');
legend('i=1','i=2','i=3','i=4','Location','eastoutside','Orientation','vertical');
% xlim([0 5]);
ylim([-60 20]);
xlabel('$\bf Time(s)$','interpreter','latex');
set(gca,'FontSize',12)
axes('position', [0.35 0.16 0.4 0.15]);
for i=1:4
    plot(Time,z(:,i),cla{i},'LineWidth',1.5)
    hold on
end
hold on
axis([4 8 -0.5 0.5]);
set(gca,'FontSize',11)

pos1 = get(sub1, 'Position'); % gives the position of current sub-plot
 pos2 = get(sub2, 'Position');
 pos3 = get(sub3, 'Position');
 new_pos1 = pos1 +[0 0 0.01 0.02];
 new_pos2 = pos2 +[0 0 0.01 0.02];
 new_pos3 = pos3 +[0 0 0.01 0.02];
 set(sub1, 'Position',new_pos1 ) % set new position of current sub - plot
 set(sub2, 'Position',new_pos2 )
 set(sub3, 'Position',new_pos3 )

