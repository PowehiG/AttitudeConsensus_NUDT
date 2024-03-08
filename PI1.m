% PI1性能指标计算
function [sys,x0,str,ts] = PI1(t,x,u,flag)

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

% 航天器1跟踪误差
x1 = u(1:leng1);
e1 = x1(1:3);

% 航天器2跟踪误差
x2 = u(leng1+1:leng2);
e2 = x2(1:3);

% 航天器3跟踪误差
x3 = u(leng2+1:leng3);
e3 = x3(1:3);

% 航天器4跟踪误差
x4 = u(leng3+1:leng4);
e4= x4(1:3);

% 性能计算
temp = norm(e1,2)^2 + norm(e2,2)^2 + norm(e3,2)^2 + norm(e4,2)^2;
sys = sqrt(temp);
