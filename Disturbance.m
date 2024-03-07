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
d =  [0.1*[sin(t);cos(t);sin(2*t)];...
      0.1*[sin(2*t);cos(2*t);sin(4*t)];...
      0.1*[sin(3*t);cos(3*t);sin(6*t)];...
      0.1*[sin(4*t);cos(4*t);sin(8*t)]];
sys = d;

% end mdlOutputs