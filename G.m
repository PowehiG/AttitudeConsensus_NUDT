%航天器动力学模型相关参数 G(q)函数实现

function y = G(q)

global I3;

y = 0.5*(0.5*(1-q'*q)*I3 + q*q' + Cross(q));