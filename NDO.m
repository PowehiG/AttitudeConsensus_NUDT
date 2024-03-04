% Nonlinear disturbance observer
function [sys,x0,str,ts] = NDO(t,x,u,flag,i)

switch flag
  case 0
    [sys,x0,str,ts]=mdlInitializeSizes;

  case 1
    sys=mdlDerivatives(t,x,u,i);

  case 3
    sys=mdlOutputs(t,x,u,i);

  case {2,4,9}
    sys = [];

  otherwise
    error(['uhandled flag= ', num2str(flag)]);

end
% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes

sizes = simsizes;
sizes.NumContStates  = 1;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 30;   % 姿态，姿态微分，控制器输出力矩
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed
sys = simsizes(sizes);

x0  = 0;
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

% 输入定义
tau = u(1:3); %控制输入
q = u(4:6); % 姿态
dq= u(7:9); % 角速度
global r J;
Ji = cell2mat(J(i));
p = r * H(Ji,q) * dq;
tau_rou_hat = x + p;
sys = -r*(tau + tau_rou_hat - C(Ji,q,dq)*dq) - r*dH(Ji,q,dq)*dq;
% end mdlDerivatives

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u,i)
global r J;
Ji = cell2mat(J(i));
q = u(4:6); % 姿态
dq= u(7:9); % 角速度
p = r * H(Ji,q) * dq;
tau_rou_hat = x + p;
sys = tau_rou_hat;
% end mdlOutputs
