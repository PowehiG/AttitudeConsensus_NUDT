% 模块为微分估计器

function [sys,x0,str,ts] = SFdqd(t,x,u,flag,i)
% i为航天器编号

switch flag
    case 0
        [sys,x0,str,ts]=mdlInitializeSizes;

    case 1
        sys=mdlDerivatives(t,x,u,i);

    case 3
        sys=mdlOutputs(u,i);

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
sizes.NumContStates  = 0;   
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 24;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   


sys = simsizes(sizes);
x0 = [];
str = [];
ts = [0 0];
% end mdlInitializeSizes


function sys=mdlOutputs(u,i)
% 
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
% 协同参考轨迹
dqd = a * dq + b * dq0';
dqdi = dqd(i,:);
sys = dqdi;
% end mdlOutputs