% 航天器动力学方程

function  y = Dynamic(Ji,wi,di,ui)
% 输入说明: 
% Ji: 惯性矩阵
% wi: 角速度
% di: 干扰
% ui: 控制输入

I3 = eye(3,3);

% 初始化输出
y = zeros(3,1);

% 输出关系
y = I3/Ji*(-Cross(wi)*Ji*wi + di + ui);