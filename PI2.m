% PI2性能指标计算
function [sys,x0,str,ts] = PI2(t,x,u,flag)

%标志位初始化
switch flag
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 3
        sys = mdlOutputs(u);
    case{1,2,4,9}
        sys = [];
    otherwise
        error(['Uhandled falg = ',num2str(flag)]);
end

%初始化函数
function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 24;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0 = [];
str = [];
ts = [0 0];
 
%状态空间模型输出方程
function sys = mdlOutputs(u)
leng1 = 6;
leng2 = leng1 + 6;
leng3 = leng2 + 6;
leng4 = leng3 + 6;

% 航天器1状态
x1 = u(1:leng1);
q1 = x1(1:3);

% 航天器2状态
x2 = u(leng1+1:leng2);
q2 = x2(1:3);

% 航天器3状态
x3 = u(leng2+1:leng3);
q3 = x3(1:3);

% 航天器4状态
x4 = u(leng3+1:leng4);
q4= x4(1:3);

% 误差
e12 = q1 - q2;
e13 = q1 - q3;
e14 = q1 - q4;
e23 = q2 - q3;
e24 = q2 - q4;
e34 = q3 - q4;

% 性能计算
temp = norm(e12,2)^2 + norm(e13,2)^2 + norm(e14,2)^2 ...
     + norm(e23,2)^2 + norm(e24,2)^2 ...
     + norm(e34,2)^2;
sys = sqrt(temp);