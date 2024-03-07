% angular velocity plot
close all
DataState = B_State.Data;
%-x-axis plot
x = [];
i = 1;
% cla = {'y','--r', 'g','b','-.magenta','cyan','-.k'}; 
cla = {'y','--r', 'g','b','-.k','-.magenta'}; 
for j=4:6:size(DataState,2)
    x = [x,DataState(:,j)];
    i = i+1;
end
figure
subplot(3,1,1);
for i=1:5
    plot(Time,x(:,i),cla{i},'LineWidth',2)
    hold on
end
% plot(Time,x,cla)
ylabel('$\bf \dot{q}_i^{(1)}$','interpreter','latex');
%xlim([0 5]);
ylim([-0.2 0.5]);
% legend('spacecraft1','spacecraft2','spacecraft3','spacecraft4','spacecraft6');
legend('spa.0','spa.1','spa.2','spa.3','spa.4','Location','northoutside','Orientation','horizontal');

% y axis plot
y = [];
i = 1;
for j=5:6:size(DataState,2)
    y = [y,DataState(:,j)];
    i = i+1;
end
subplot(3,1,2);
for i=1:5
    plot(Time,y(:,i),cla{i},'LineWidth',2)
    hold on
end
ylabel('$\bf \dot{q}_i^{(2)}$','interpreter','latex');
%xlim([0 5]);
ylim([-0.2 0.6]);

% z axis plot
z = [];
i = 1;
for j=6:6:size(DataState,2)
    z = [z,DataState(:,j)];
    i = i+1;
end
subplot(3,1,3);
for i=1:5
    plot(Time,z(:,i),cla{i},'LineWidth',2)
    hold on
end
% ylabel(['X-axis quaternion errors (deg)'],'interpreter','latex');
ylabel('$\bf \dot{q}_i^{(3)}$','interpreter','latex');
%xlim([0 5]);
ylim([-0.2 0.3]);
xlabel('$\bf Time(s)$','interpreter','latex');

