% 主函数

clear;

global I3;
I3 = eye(3);

%% 公共参数
% 航天器模型参数
% 航天器数量
global N;
N = 5;  % 包括虚拟leader
% 航天器转动惯量参数
global J;
J={[25.1,0.1,-0.1;   0.1,24.8,0.2;  -0.1,0.2,25],...
   [25.7,0.3,0.2;    0.3,24.2,0.1;  0.2,0.1,24.6],...
   [25.3,-0.2,0.3;   -0.2,25.8,0.2;  0.3,0.2,24.9],...
   [24.3,0.2,0.2;    0.2,25.5,-0.1;  0.2,-0.1,25.1]};

% J={[1.0,0.1,0.1;   0.1,0.1,0.1;  0.1,0.1,0.9],...
%    [1.5,0.2,0.3;   0.2,0.9,0.4;  0.3,0.4,2.0],...
%    [0.8,0.1,0.2;   0.1,0.7,0.3;  0.2,0.3,1.1],...
%    [1.2,0.3,0.7;   0.3,0.9,0.2;  0.7,0.2,1.4]};

% 航天器通信拓扑
global a b;
a = [0, 1, 0, 1;...
     1, 0, 1, 0;...
     0, 1, 0, 1;...
     1, 0, 1, 0];
%b = diag([1,0,1,0],0);
b = [1;0;0;1];

% 航天器外部干扰
global outDisturbance;
outDisturbance = [];

%% NDTU参数
% 滑模面参数
global l;
l = 0.5;

% 控制器参数
global r;
r = 1;

% 观测器常数
global Delta delta1 delta3 delta4;
Delta = 0.001;
delta1 = 1;
delta3 = 1;
delta4 = 0.1;

% 控制律参数
global beta0 c1 c2 c3 epsilon;
beta0 = 1;
c1 = 1;
c2 = 1;
c3 = 1;
epsilon = 1;

%% Latifu参数

global c k1 k2 r_l alpha epsilon_l l1 l2;
epsilon_l = 0.001;
c = 1;%外滑模面系数
alpha = 0.6;%外滑模面幂次
%内滑模面系数
k1 = 0.2;
k2 = 0.2;
r_l = 3/5;%内滑模面系数
l1 = (2-r_l)*epsilon_l^(r_l-1);
l2 = (2-r_l)*epsilon_l^(r_l-1);

global rou1 rou2 kappa chi;
rou1 = 1;
rou2 = 1;
kappa = 1;
chi = 1;

% global Kv Keta v E gamma_zeta gamma_thta alpha_1 Omega;
% Kv = 15;
% Keta = 15;
% v = 3/5;
% E = eye(9);
% gamma_thta = 1;
% gamma_zeta = 1;
% alpha_1 = 1;
% Omega = 0.001;


%% Simulink
mdl = 'NUDT';
load_system(mdl);
set_param(mdl,'SimulationMode','Normal');
cs = getActiveConfigSet(mdl);
mdl_cs = cs.copy;
set_param(mdl_cs,...
    'Solver','ode5',...
    'FixedStep','0.01',...                             
    'StopTime','50',...
    'SaveTime','off',...
    'SaveState','off',...
    'SaveOutput','off');
tic;
simOut = sim(mdl, mdl_cs);

% 输出传递
% Time = simOut.get('Time');
% State = simOut.get('State');
% %Error = simOut.get('Error');
% CtlCmd = simOut.get('CtlCmd');
% SM = simOut.get('SM');
% Sigma = simOut.get('Sigma');
% Est = simOut.get('Est');
% PI1_1 = simOut.get('ATEM');
% PI2_1 = simOut.get('ASEM');
elapstime = toc;

% %是否作图询问
% 
% ans1 = input('Do you want to draw the results obtained just now? [Y: 1 / N: 2]: ');
% if isempty(ans1)
%     disp('Wrong input!');
% elseif ans1 ==1
%         run('E:\BaiduNetdiskDownload\Latifu Research\Adaptive Work Chapter 4\DAFOSMC\Plot_ADFOFNTSMS\MainPlot');
% elseif ans1 == 2
%         disp('End!');
% else
%     disp('Wrong input!');
% end

