% Spacecraft 动力学模型

function [sys,x0,str,ts,simStateCompliance] = Spacecraft(t,x,u,flag,i)
% i为航天器编号

switch flag
  case 0
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(i);

  case 1
    sys=mdlDerivatives(t,x,u,i);

  case 3
    sys=mdlOutputs(t,x,u);

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
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(i)

sizes = simsizes;
sizes.NumContStates  = 6;   % 包括位姿，角速度
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 6;
sizes.NumInputs      = 3;   % 控制器输入
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   

global initialState;
sys = simsizes(sizes);
x0 = initialState(i);
str = [];
ts = [0 0];
% end mdlInitializeSizes


%
%=============================================================================
% 状态空间模型/状态方程
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,x,u,i)

% 调用参数
global J delta_J outDisturbance;
Ji = J(i) + delta_J;
di = outDisturbance(i);

% 状态声明
qi = x(1:3); % 姿态
wi = x(4:6); % 角速度

% 状态方程
sys(1:3) = Kinematic(qi,wi);    % 运动学模型
sys(4:6) = Dynamic(Ji,wi,di,u); % 动力学模型
% end mdlDerivatives

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u)
qi = x(1:3);    % 姿态
wi = x(4:6);    % 角速度

dq = Kinematic(qi,wi);
sys = [q;dq];
% end mdlOutputs
