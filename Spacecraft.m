% Spacecraft 动力学模型

function [sys,x0,str,ts] = Spacecraft(t,x,u,flag,i,initialState)
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
function [sys,x0,str,ts]=mdlInitializeSizes(i,initialState)

sizes = simsizes;
sizes.NumContStates  = 6;   % 包括位姿，角速度
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 6;
sizes.NumInputs      = 3;   % 控制器输入
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   


sys = simsizes(sizes);
x0 = initialState;
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
global J;
% delta_J = diag([0.02*sin(t), 0.01*cos(t), 0.02*sin(0.5*t)]);
Ji = J(i);
d = [0.001*[2*sin(0.01*t)+3;3*cos(0.02*t)+4;3*sin(0.01*t)+2];...
     0.001*[4*cos(0.03*t)+1;cos(0.01*t)+2;2*sin(0.03*t)+3];...
     0.001*[3*cos(0.02*t)+2;2*sin(0.01*t)+4;4*sin(0.02*t)+1];...
     0.001*[3*sin(0.02*t)+1;4*sin(0.03*t)+3;cos(0.03*t)+2];];
di = d(i);

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
function sys=mdlOutputs(x)
qi = x(1:3);    % 姿态
wi = x(4:6);    % 角速度

dqi = Kinematic(qi,wi);
sys = [qi;dqi];
% end mdlOutputs
