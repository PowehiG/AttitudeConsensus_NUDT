% 航天器动力学模型相关参数 M/H矩阵倒导数实现

function y = dH(J,q,dq)

global I3;

y = 0;
