%模块的主要功能是计算控制律U

function [sys,x0,str,ts] = myController(t,x,u,flag,i)

%初始化参数设计
switch flag
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 1
        sys = mdlDerivatives(u,i);
    case 3
        sys = mdlOutputs(x,u,i);
    case {2,4,9}
        sys = [];
    otherwise
        error(['Unhandled flag = ',num2str(flag)]);
end

%初始化函数设置
function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 9;
sizes.NumInputs      = 37;%所有航天器状态及自适应控制
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0 = [0,0,0];
str = [];
ts = [0 0];

function sys = mdlDerivatives(u,i)
global b a;
global c k1 k2 alpha rou1 rou2;  

% 输入说明
q0 = u(1:3);    % 期望轨迹
dq0 = u(4:6);   % 期望角速度

% 状态信息
% 自身状态
xi = u(6*i+1:6*i+6);   
qi = xi(1:3); % 姿态
dqi = xi(4:6); % 角速度

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

% 
gamma_hati = u(37);

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

% 计算绝对姿态误差状态
sys = -rou1*si -rou2*sign(si)- gamma_hati*sign(si);


%控制器输出方程
function sys = mdlOutputs(x,u,i)
global b a;
global c k1 k2 alpha;  
global N;
global J;
Ji = cell2mat(J(i));


% 输入说明
q0 = u(1:3);    % 期望轨迹
dq0 = u(4:6);   % 期望角速度

% 状态信息
% 自身状态
xi = u(6*i+1:6*i+6);   
qi = xi(1:3); % 姿态
dqi = xi(4:6); % 角速度

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
Gi = G(qi);
Hi = H(Ji,qi);
Ci = C(Ji,qi,dqi);
Mi = Gi*inv(Ji);

ueqi = inv(Hi)*Ci*dqi + (ddqdi-k1*detai-k2*Dlamda(etai,detai)-c*Sig(sigmai,alpha));
uni = x;

% uout = G1'*(ueq1+un1);
uout = inv(Mi)*(ueqi+uni);

sys = [uout;si;sigmai];
