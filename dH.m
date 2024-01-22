% 航天器动力学模型相关参数 M/H矩阵倒导数实现

function y = dH(J,q,dq)

global I3;

dinvG = 16*(-2*(dq'*q+q'*dq)*G(q)'/(q+q'*q^3)+1/((1+q'*q)^2)*dG(q,dq)');
y = dinvG'*J*InvG(q)+InvG(q)'*J*dinvG;
