% 主函数

clear;

% 航天器模型参数
global J;
J=[[1.0,0.1,0.1;   0.1,0.1,0.1;  0.1,0.1,0.9],...
   [1.5,0.2,0.3;   0.2,0.9,0.4;  0.3,0.4,2.0],...
   [0.8,0.1,0.2;   0.1,0.7,0.3;  0.2,0.3,1.1],...
   [1.2,0.3,0.7;   0.3,0.9,0.2;  0.7,0.2,1.4]];

% 航天器通信拓扑
global a b;
a = [0.0,1.0,0.0,1.0;...
     1.0,0.0,1.0,0.0;...
     0.0,1.0,0.0,1.0;...
     1.0,0.0,1.0,0.0];
b = diag([1,0,0,1],0);

% 航天器初始状态
global initialState;
initialState = [ 0.2, -0.2,  0.3, 0, 0, 0;...
                -0.3,  0.2,  0.1, 0, 0, 0;...
                 0.1, -0.4,  0.2, 0, 0, 0;...
                -0.2, -0.1,  0.3, 0, 0, 0];

% 航天器外部干扰
global outDisturbance;
outDisturbance = [];

% 航天器内部参数变化
delta_J = diag([0.02*sin(t), 0.01*cos(t), 0.02*sin(0.5*t)]);

% 滑模面参数
global r;
r = 1;

% 控制律参数
global beta0, c1, c2, c3;

% % Simulink
% mdl = 'ADFOFNTSMC5';
% load_system(mdl);
% set_param(mdl,'SimulationMode','Normal');
% cs = getActiveConfigSet(mdl);
% mdl_cs = cs.copy;
% set_param(mdl_cs,...
%     'Solver','ode4',...
%     'FixedStep','0.01',...                             
%     'StopTime','15',...
%     'SaveTime','off',...
%     'SaveState','off',...
%     'SaveOutput','off');
% tic;
% simOut = sim(mdl, mdl_cs);

% 输出传递
Time = simOut.get('Time');
State = simOut.get('State');
%Error = simOut.get('Error');
CtlCmd = simOut.get('CtlCmd');
SM = simOut.get('SM');
Sigma = simOut.get('Sigma');
Est = simOut.get('Est');
PI1_1 = simOut.get('ATEM');
PI2_1 = simOut.get('ASEM');
elapstime = toc;

%是否作图询问

ans1 = input('Do you want to draw the results obtained just now? [Y: 1 / N: 2]: ');
if isempty(ans1)
    disp('Wrong input!');
elseif ans1 ==1
        run('E:\BaiduNetdiskDownload\Latifu Research\Adaptive Work Chapter 4\DAFOSMC\Plot_ADFOFNTSMS\MainPlot');
elseif ans1 == 2
        disp('End!');
else
    disp('Wrong input!');
end

