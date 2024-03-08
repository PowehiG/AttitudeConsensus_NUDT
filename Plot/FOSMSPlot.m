% Control torque for each spacecraft
close all
B_DataState = B_outerSMC;
N_DataState = N_SMC;

%% BIT
figure('Name','Ours:outerSMC')
%-x-axis plot
B_x = [];
i = 1;
% cla = {'--r', 'g','b','-.magenta','cyan','-.k'}; 
cla = {'--r', 'g','b','-.k'}; 
for j=1:3:size(B_DataState,2)
    B_x = [B_x,B_DataState(:,j)];
    i = i+1;
end
subplot(3,1,1);
for i=1:4
    plot(Time,B_x(:,i),cla{i},'LineWidth',1.8)
    hold on
end
% plot(Time,x,cla)
ylabel('$\bf s_i^{(1)}$','interpreter','latex');
% xlim([0 5]);
% ylim([-1.5 1.5]);
legend('spa.1','spa.2','spa.3','spa.4','Location','northoutside','Orientation','horizontal');

% y axis plot
B_y = [];
i = 1;
for j=2:3:size(B_DataState,2)
    B_y = [B_y,B_DataState(:,j)];
    i = i+1;
end
subplot(3,1,2);
for i=1:4
    plot(Time,B_y(:,i),cla{i},'LineWidth',1.8)
    hold on
end
ylabel('$\bf s_i^{(2)}$','interpreter','latex');
% xlim([0 5]);
% ylim([-1 1]);

% z axis plot
B_z = [];
i = 1;
for j=3:3:size(B_DataState,2)
    B_z = [B_z,B_DataState(:,j)];
    i = i+1;
end
subplot(3,1,3);
for i=1:4
    plot(Time,B_z(:,i),cla{i},'LineWidth',1.8)
    hold on
end
% ylabel(['X-axis quaternion errors (deg)'],'interpreter','latex');
ylabel('$\bf s_i^{(3)}$','interpreter','latex');
% xlim([0 5]);
% ylim([-1 1]);
xlabel('$\bf Time(s)$','interpreter','latex');

%% NUDT
figure('Name','NUDTs:innerSMC')
%-x-axis plot
N_x = [];
i = 1;
% cla = {'--r', 'g','b','-.magenta','cyan','-.k'}; 
cla = {'--r', 'g','b','-.k'}; 
for j=1:3:size(N_DataState,2)
    N_x = [N_x,N_DataState(:,j)];
    i = i+1;
end
subplot(3,1,1);
for i=1:4
    plot(Time,N_x(:,i),cla{i},'LineWidth',1.8)
    hold on
end
% plot(Time,x,cla)
ylabel('$\bf s_i^{(1)}$','interpreter','latex');
% xlim([0 5]);
% ylim([-1.5 1.5]);
legend('spa.1','spa.2','spa.3','spa.4','Location','northoutside','Orientation','horizontal');

% y axis plot
N_y = [];
i = 1;
for j=2:3:size(N_DataState,2)
    N_y = [N_y,N_DataState(:,j)];
    i = i+1;
end
subplot(3,1,2);
for i=1:4
    plot(Time,N_y(:,i),cla{i},'LineWidth',1.8)
    hold on
end
ylabel('$\bf s_i^{(2)}$','interpreter','latex');
% xlim([0 5]);
% ylim([-1 1]);

% z axis plot
N_z = [];
i = 1;
for j=3:3:size(N_DataState,2)
    N_z = [N_z,N_DataState(:,j)];
    i = i+1;
end
subplot(3,1,3);
for i=1:4
    plot(Time,N_z(:,i),cla{i},'LineWidth',1.8)
    hold on
end
% ylabel(['X-axis quaternion errors (deg)'],'interpreter','latex');
ylabel('$\bf s_i^{(3)}$','interpreter','latex');
% xlim([0 5]);
% ylim([-1 1]);
xlabel('$\bf Time(s)$','interpreter','latex');