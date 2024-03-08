% attitude plot
close all
B_DataState = B_State.Data;
N_DataState = N_State.Data;

%% BIT
figure('Name','Ours:Attitude')
%-x-axis plot
B_x = [];
i = 1;
% cla = {'y','--r', 'g','b','-.magenta','cyan','-.k'}; 
cla = {'y','--r', 'g','b','-.k','-.magenta'}; 
for j=1:6:size(B_DataState,2)
    B_x = [B_x,B_DataState(:,j)];
    i = i+1;
end
subplot(3,1,1);
for i=1:5
    plot(Time,B_x(:,i),cla{i},'LineWidth',2)
    hold on
end
% plot(Time,x,cla)
ylabel('$\bf q_i^{(1)}$','interpreter','latex');
% xlim([0 5]);
ylim([-0.2 0.2]);
% legend('spacecraft1','spacecraft2','spacecraft3','spacecraft4','spacecraft6');

% y axis plot
B_y = [];
i = 1;
legend('spa.0','spa.1','spa.2','spa.3','spa.4','Location','northoutside','Orientation','horizontal');

for j=2:6:size(B_DataState,2)
    B_y = [B_y,B_DataState(:,j)];
    i = i+1;
end
subplot(3,1,2);
for i=1:5
    plot(Time,B_y(:,i),cla{i},'LineWidth',2)
    hold on
end
ylabel('$\bf q_i^{(2)}$','interpreter','latex');
% xlim([0 5]);
% ylim([-1.5 2.5]);

% z axis plot
B_z = [];
i = 1;
for j=3:6:size(B_DataState,2)
    B_z = [B_z,B_DataState(:,j)];
    i = i+1;
end
subplot(3,1,3);
for i=1:5
    plot(Time,B_z(:,i),cla{i},'LineWidth',2)
    hold on
end
ylabel('$\bf q_i^{(3)}$','interpreter','latex');
% xlim([0 5]);
% ylim([-1.5 2]);
xlabel('$\bf Time(s)$','interpreter','latex');

%% NUDT
figure('Name','NUDTs:Attitude')
% x axis plot
N_x = [];
i = 1;
for j=1:6:size(N_DataState,2)
    N_x = [N_x,N_DataState(:,j)];
    i = i+1;
end
subplot(3,1,1);
for i=1:5
    plot(Time,N_x(:,i),cla{i},'LineWidth',2)
    hold on
end
% plot(Time,x,cla)
ylabel('$\bf q_i^{(1)}$','interpreter','latex');
% xlim([0 5]);
ylim([-0.2 0.2]);
% legend('spacecraft1','spacecraft2','spacecraft3','spacecraft4','spacecraft6');

% y axis plot
N_y = [];
i = 1;
legend('spa.0','spa.1','spa.2','spa.3','spa.4','Location','northoutside','Orientation','horizontal');

for j=2:6:size(N_DataState,2)
    N_y = [N_y,N_DataState(:,j)];
    i = i+1;
end
subplot(3,1,2);
for i=1:5
    plot(Time,N_y(:,i),cla{i},'LineWidth',2)
    hold on
end
ylabel('$\bf q_i^{(2)}$','interpreter','latex');
% xlim([0 5]);
% ylim([-1.5 2.5]);

% z axis plot
N_z = [];
i = 1;
for j=3:6:size(N_DataState,2)
    N_z = [N_z,N_DataState(:,j)];
    i = i+1;
end
subplot(3,1,3);
for i=1:5
    plot(Time,N_z(:,i),cla{i},'LineWidth',2)
    hold on
end
ylabel('$\bf q_i^{(3)}$','interpreter','latex');
% xlim([0 5]);
% ylim([-1.5 2]);
xlabel('$\bf Time(s)$','interpreter','latex');



