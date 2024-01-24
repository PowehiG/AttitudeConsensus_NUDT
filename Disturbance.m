% 外部干扰输出

function [sys,x0,str,ts] = Disturbance(t,x,u,flag)
switch flag

  case 0
    [sys,x0,str,ts]=mdlInitializeSizes;

  case 3
    sys=mdlOutputs(t);

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
sizes.NumOutputs     = 4*3;  
sizes.NumInputs      = 0;  
sizes.DirFeedthrough = 1;   % has direct feedthrough
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
function sys = mdlOutputs(t)
d =  [0.001*[2*sin(0.01*t)+3;3*cos(0.02*t)+4;3*sin(0.01*t)+2];...
     0.001*[4*cos(0.03*t)+1;cos(0.01*t)+2;2*sin(0.03*t)+3];...
     0.001*[3*cos(0.02*t)+2;2*sin(0.01*t)+4;4*sin(0.02*t)+1];...
     0.001*[3*sin(0.02*t)+1;4*sin(0.03*t)+3;cos(0.03*t)+2]];
sys = d;

% end mdlOutputs