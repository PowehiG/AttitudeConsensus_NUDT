% Control torque for each spacecraft
close all
DataState = outerSMC;
%-x-axis plot
x = [];
i = 1;
% cla = {'--r', 'g','b','-.magenta','cyan','-.k'}; 
cla = {'--r', 'g','b','-.k'}; 
for j=1:3:size(DataState,2)
    x = [x,DataState(:,j)];
    i = i+1;
end
subplot(3,1,1);
for i=1:4
    plot(Time,x(:,i),cla{i},'LineWidth',1.8)
    hold on
end
% plot(Time,x,cla)
ylabel('$\bf s_i^{(1)}$','interpreter','latex');
% xlim([0 5]);
% ylim([-1.5 1.5]);
legend('spa.1','spa.2','spa.3','spa.4','Location','northoutside','Orientation','horizontal');

% y axis plot
y = [];
i = 1;
for j=2:3:size(DataState,2)
    y = [y,DataState(:,j)];
    i = i+1;
end
subplot(3,1,2);
for i=1:4
    plot(Time,y(:,i),cla{i},'LineWidth',1.8)
    hold on
end
ylabel('$\bf s_i^{(2)}$','interpreter','latex');
% xlim([0 5]);
% ylim([-1 1]);

% z axis plot
z = [];
i = 1;
for j=3:3:size(DataState,2)
    z = [z,DataState(:,j)];
    i = i+1;
end
subplot(3,1,3);
for i=1:4
    plot(Time,z(:,i),cla{i},'LineWidth',1.8)
    hold on
end
% ylabel(['X-axis quaternion errors (deg)'],'interpreter','latex');
ylabel('$\bf s_i^{(3)}$','interpreter','latex');
% xlim([0 5]);
% ylim([-1 1]);
xlabel('$\bf Time(s)$','interpreter','latex');