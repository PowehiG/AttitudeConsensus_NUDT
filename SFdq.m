% 模块为微分估计器
% s-function连接说明：
    


function [sys,x0,str,ts] = SFdq(t,x,u,flag,i)
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
sizes.NumInputs      = 30;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   


sys = simsizes(sizes);
x0 = [];
str = [];
ts = [0 0];
% end mdlInitializeSizes


function sys=mdlOutputs(u,i)

% 状态信息
% 自身状态
xi = u(6*i+1:6*i+6);   
dqi = xi(4:6); % 姿态

sys = dqi;
% end mdlOutputs