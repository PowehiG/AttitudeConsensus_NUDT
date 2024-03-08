% Control torque for each spacecraft
close all
B_DataState = B_ControlCmd;
N_DataState = N_ControlCmd;

%% BIT
%-x-axis plot
B_x = [];
i = 1;
% cla = {'--r', 'g','b','-.magenta','cyan','-.k'}; 
figure('Name','Ours:ControlTorque','Position',[488/3   342/3   560*1.5   420*1.5])

cla = {'--r', 'g','b','-.k'}; 
for j=1:3:size(B_DataState,2)
    B_x = [B_x,B_DataState(:,j)];
    i = i+1;
end
sub1 = subplot(3,1,1);
for i=1:4
    plot(Time,B_x(:,i),cla{i},'LineWidth',1.5)
    hold on
end
% plot(Time,x,cla)
ylabel('$\bf u_{i,1}$','interpreter','latex');
% xlim([0 5]);
ylim([-60 20]);
set(gca,'FontSize',12)
axes('position', [0.35 0.76 0.4 0.15]);
for i=1:4
    plot(Time,B_x(:,i),cla{i},'LineWidth',1.5)
    hold on
end
hold on
axis([4 8 -0.6 0.3]);
set(gca,'FontSize',11)

% y axis plot
B_y = [];
i = 1;
for j=2:3:size(B_DataState,2)
    B_y = [B_y,B_DataState(:,j)];
    i = i+1;
end
sub2 = subplot(3,1,2);
for i=1:4
    plot(Time,B_y(:,i),cla{i},'LineWidth',1.5)
    hold on
end
ylabel('$\bf u_{i,2}$','interpreter','latex');
% xlim([0 5]);
ylim([-60 20]);
set(gca,'FontSize',12)
axes('position', [0.35 0.46 0.4 0.15]);
for i=1:4
    plot(Time,B_y(:,i),cla{i},'LineWidth',1.5)
    hold on
end
hold on
axis([4 8 -0.5 0.25]);
set(gca,'FontSize',11)

% z axis plot
B_z = [];
i = 1;
for j=3:3:size(B_DataState,2)
    B_z = [B_z,B_DataState(:,j)];
    i = i+1;
end
sub3 = subplot(3,1,3);
for i=1:4
    plot(Time,B_z(:,i),cla{i},'LineWidth',1.5)
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
    plot(Time,B_z(:,i),cla{i},'LineWidth',1.5)
    hold on
end
hold on
axis([4 8 -0.5 0.25]);
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

%% NUDT
%-x-axis plot
N_x = [];
i = 1;
% cla = {'--r', 'g','b','-.magenta','cyan','-.k'}; 
figure('Name','NUDTs:ControlTorque','Position',[488/3   342/3   560*1.5   420*1.5])

cla = {'--r', 'g','b','-.k'}; 
for j=1:3:size(N_DataState,2)
    N_x = [N_x,N_DataState(:,j)];
    i = i+1;
end
sub1 = subplot(3,1,1);
for i=1:4
    plot(Time,N_x(:,i),cla{i},'LineWidth',1.5)
    hold on
end
% plot(Time,x,cla)
ylabel('$\bf u_{i,1}$','interpreter','latex');
% xlim([0 5]);
ylim([-20 20]);
set(gca,'FontSize',12)
axes('position', [0.35 0.76 0.4 0.15]);
for i=1:4
    plot(Time,N_x(:,i),cla{i},'LineWidth',1.5)
    hold on
end
hold on
axis([4 8 -0.2 0.6]);
set(gca,'FontSize',11)

% y axis plot
N_y = [];
i = 1;
for j=2:3:size(N_DataState,2)
    N_y = [N_y,N_DataState(:,j)];
    i = i+1;
end
sub2 = subplot(3,1,2);
for i=1:4
    plot(Time,N_y(:,i),cla{i},'LineWidth',1.5)
    hold on
end
ylabel('$\bf u_{i,2}$','interpreter','latex');
% xlim([0 5]);
ylim([-20 20]);
set(gca,'FontSize',12)
axes('position', [0.35 0.46 0.4 0.15]);
for i=1:4
    plot(Time,N_y(:,i),cla{i},'LineWidth',1.5)
    hold on
end
hold on
axis([4 8 -0.25 0.6]);
set(gca,'FontSize',11)

% z axis plot
N_z = [];
i = 1;
for j=3:3:size(N_DataState,2)
    N_z = [N_z,N_DataState(:,j)];
    i = i+1;
end
sub3 = subplot(3,1,3);
for i=1:4
    plot(Time,N_z(:,i),cla{i},'LineWidth',1.5)
    hold on
end
% ylabel(['X-axis quaternion errors (deg)'],'interpreter','latex');
ylabel('$\bf u_{i,3}$','interpreter','latex');
legend('i=1','i=2','i=3','i=4','Location','eastoutside','Orientation','vertical');
% xlim([0 5]);
ylim([-20 20]);
xlabel('$\bf Time(s)$','interpreter','latex');
set(gca,'FontSize',12)
axes('position', [0.35 0.16 0.4 0.15]);
for i=1:4
    plot(Time,N_z(:,i),cla{i},'LineWidth',1.5)
    hold on
end
hold on
axis([4 8 -0.2 0.7]);
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
