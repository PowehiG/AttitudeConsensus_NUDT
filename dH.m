% 航天器动力学模型相关参数 M/H矩阵倒导数实现

function y = dH(J,q,dq)

global I3;
Gq = G(q);
dGq = dG(q,dq);
m = (1+q'*q)^2;
%dinvG = 16*(-2*(q+q'*q)^(-3)*(dq'*q+q'*dq)*G(q)'+(1+q'*q)^(-2)*dG(q,dq)')
% dinvG = inv(dG(q,dq));

dinvG = 16*dGq'/ m - 32 * (dq'*q+ q'*dq)*Gq'/m^2;
y = dinvG'*J*InvG(q)+InvG(q)'*J*dinvG;
