% 航天器运动学方程MRP形式

function y = Kinematic(qi, wi)
% 输入:
% 姿态与角速度
% 输出:
% 姿态变化率
I3 = eye(3,3);

y = 0.5*(0.5*(1-qi'*qi)*I3 + qi*qi' + Cross(qi))*wi;