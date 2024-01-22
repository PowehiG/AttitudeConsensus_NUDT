% 航天器动力学模型相关参数 M/H矩阵实现

function y = H(J, q)

invG = InvG(q);

y = invG'*J*invG;