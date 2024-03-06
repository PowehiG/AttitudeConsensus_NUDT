% 控制器模块

function [sys,x0,str,ts] = Controller(t,x,u,flag,i)
switch flag
  case 0
    [sys,x0,str,ts]=mdlInitializeSizes(i);

  case 1
    sys=mdlDerivatives(t,x,u,i);

  case 3
    sys=mdlOutputs(x,u,i);

  case {2,4,9}
    sys = [];

  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes(i)

sizes = simsizes;
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 6;
sizes.NumInputs      = 5*6+3;  % 所有航天器状态及NDO输入
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed
sys = simsizes(sizes);
x0  = [0,0,0];
str = [];
ts  = [0 0];
% end mdlInitializeSizes

%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,x,u,i)

% 参数说明
global N;
global J;
Ji = cell2mat(J(i));
global l;   % 滑模面常数
global a b; % 通信矩阵
global c1 c2 c3 beta0;

% 期望姿态
q0 = u(1:3);
dq0 = u(4:6);

% 自身姿态
xi = u(6*i+1:6*i+6);
qi = xi(1:3);
dqi = xi(4:6);

% 分离姿态信息和姿态微分信息
q = zeros(N-1,3);
dq = zeros(N-1,3);
for j = 1:N-1
    q(j,:) = u(6*j+1:6*j+3);
    dq(j,:) = u(6*j+4:6*j+6);
end
% 协同参考轨迹
qd = a * q + b * q0';
dqd = a * dq + b * dq0';
qdi = qd(i,:)';
dqdi = dqd(i,:)';

sum_a = sum(a,2);   % a矩阵按行求和
sum_b = sum(b,2);   % b矩阵按行求和

% 协同误差
e1i = (sum_a(i)+sum_b(i))*qi - qdi;
e2i = (sum_a(i)+sum_b(i))*dqi - dqdi;

% 滑模面
si = l*e1i +e2i;

% 控制器内部状态更新
k_hat_dot = c1*norm(si,2)^2;
alpha1_hat_dot = c2*norm(si,2);
alpha2_hat_dot = c3*norm(inv(H(Ji,qi)),2)*norm(si,2);
sys = [k_hat_dot,alpha1_hat_dot,alpha2_hat_dot];
% end mdlDerivatives

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(x,u,i)

% 参数说明
global N;
global J;
Ji = cell2mat(J(i));
global l;   % 滑模面常数
global a b; % 通信矩阵
global beta0;
global Delta delta1  delta3 delta4 epsilon;

% 期望姿态
q0 = u(1:3);
dq0 = u(4:6);

% 自身姿态
xi = u(6*i+1:6*i+6);
qi = xi(1:3);
dqi = xi(4:6);

% 分离姿态信息和姿态微分信息
q = zeros(N-1,3);
dq = zeros(N-1,3);
for j = 1:N-1
    q(j,:) = u(6*j+1:6*j+3);
    dq(j,:) = u(6*j+4:6*j+6);
end

sum_a = sum(a,2);   % a矩阵按行求和
sum_b = sum(b,2);   % b矩阵按行求和

% 协同参考轨迹
qd = a * q + b*q0';
dqd = a * dq + b*dq0';
qdi = qd(i,:)';
dqdi = dqd(i,:)';
% 协同误差
e1i = (sum_a(i)+sum_b(i))*qi - qdi;
e2i = (sum_a(i)+sum_b(i))*dqi - dqdi;
% 滑模面
si = l*e1i +e2i;

% NDO输入
tau_rou_hat = u(N*6+1:N*6+3);

% 控制器参数计算
k_hat = x(1);
alpha1_hat = x(2);
alpha2_hat = x(3);
beta1_hat =  alpha1_hat*delta3 + alpha2_hat*Delta*norm(inv(H(Ji,qi)),2) + beta0;
beta2_hat =  alpha1_hat*delta3 + alpha2_hat*delta1*norm(inv(H(Ji,qi)),2) + beta0;

% 控制输出计算
tau_i = zeros(3,1);
if norm(tau_rou_hat,2) <= delta4
    tau_i = C(Ji,qi,dqi)*dqi-H(Ji,qi)/(sum_a(i)+sum_b(i))*(l*e2i+k_hat*si+beta1_hat*Sat(si,epsilon))-tau_rou_hat;
else
    tau_i = C(Ji,qi,dqi)*dqi-H(Ji,qi)/(sum_a(i)+sum_b(i))*(l*e2i+k_hat*si+beta2_hat*Sat(si,epsilon));
end
sys = [tau_i;si];
% end mdlOutputs

