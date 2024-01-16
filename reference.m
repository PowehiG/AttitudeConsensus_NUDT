% 参考输入

function [sys,x0,str,ts] = reference(t,x,u,flag)
switch flag

  case 0
    [sys,x0,str,ts]=mdlInitializeSizes;

  case 3
    sys=mdlOutputs(t,x,u);

  case { 1, 2, 4, 9 }
    sys=[];

  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end
% end timestwo

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts,simStateCompliance] = mdlInitializeSizes()

sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 6;  
sizes.NumInputs      = 0;  
sizes.DirFeedthrough = 6;   % has direct feedthrough
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);
str = [];
x0  = [];
ts  = [0 0];

simStateCompliance = 'DefaultSimState';

% end mdlInitializeSizes

%
%=============================================================================
% mdlOutputs
% Return the output vector for the S-function
%=============================================================================
%
function sys = mdlOutputs(t,x,u)
qd = 0.2*[cos(0.2*t);sin(0.2*t);sqrt(3)];
dqd = 0.2*[-0.2*sin(0.2*t);0.2*cos(0.2*t);0];


sys = [qd;dqd];

% end mdlOutputs