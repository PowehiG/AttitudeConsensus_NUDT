% 模块为分布式自适应

function [sys,x0,str,ts] = DistAdapt(t,x,u,flag,i,initialState)
% i为航天器编号

switch flag
    case 0
        [sys,x0,str,ts]=mdlInitializeSizes(i,initialState);

    case 1
        sys=mdlDerivatives(t,x,u,i);

    case 3
        sys=mdlOutputs(x);

    case {2,4,9}
        sys = [];
    
    otherwise
        error(['uhandled flag= ', num2str(flag)]) 

end
% end sfuntmpl


%=============================================================================
% 初始化函数
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes

sizes = simsizes;
sizes.NumContStates  = 1;   % 包括位姿，角速度
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 36;   % 控制器输入，干扰输入
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   


sys = simsizes(sizes);
x0 = 0.1;
str = [];
ts = [0 0];
% end mdlInitializeSizes


%
%=============================================================================
% 状态空间模型/状态方程
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(x,u,i)

% 调用参数
global b a;
global c k1 k2 alpha kappa chi;

global J;
% delta_J = diag([0.02*sin(t), 0.01*cos(t), 0.02*sin(0.5*t)]);
Ji = cell2mat(J(i));
% d = {0.001*[2*sin(0.01*t)+3;3*cos(0.02*t)+4;3*sin(0.01*t)+2],...
%      0.001*[4*cos(0.03*t)+1;cos(0.01*t)+2;2*sin(0.03*t)+3],...
%      0.001*[3*cos(0.02*t)+2;2*sin(0.01*t)+4;4*sin(0.02*t)+1],...
%      0.001*[3*sin(0.02*t)+1;4*sin(0.03*t)+3;cos(0.03*t)+2]};
% di = cell2mat(d(i));

% 输入说明
q0 = u(1:3);    % 期望轨迹
dq0 = u(4:6);   % 期望角速度

% 状态信息
% 自身状态
xi = u(6*i+1:6*i+6);   
qi = xi(1:3); % 姿态
wi = xi(4:6); % 角速度

% 其余航天器状态
% 分离姿态信息和姿态微分信息
q = zeros(N-1,3);
dq = zeros(N-1,3);
for j = 1:N-1
    q(j,:) = u(6*j+1:6*j+3);
    dq(j,:) = u(6*j+4:6*j+6);
end

% 微分估计
ddxi = u(31:36);
ddqi = ddxi(1:3);
ddqdi = ddx1(4:6);

% 协同参考轨迹
qd = a * q + b * q0';
dqd = a * dq + b * dq0';
qdi = qd(i,:);
dqdi = dqd(i,:);

sum_a = sum(a,2);   % a矩阵按行求和
sum_b = sum(b,2);   % b矩阵按行求和

% 协同误差
etai = (sum_a(i)+sum_b(i))*qi - qdi;
detai = (sum_a(i)+sum_b(i))*dqi - dqdi;
ddetai = ddqi - ddqdi;

% 内滑模面
sigmai = detai + k1*etai + k2*Lamda(etai);
dsigmai = ddetai + k1*detai + k2*Dlamda(etai,detai);
% 外层滑模面
si = dsigmai + c*Sig(sigmai,alpha);
%计算绝对1号姿态误差状态
sys = chi*(norm(si,1) - kappa*x);

% end mdlDerivatives

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(x)

sys =x;
% end mdlOutputs