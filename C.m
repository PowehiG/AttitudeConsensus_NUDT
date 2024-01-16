% 航天器动力学模型相关参数 C实现

function y = C(J, q, dq)

invG = InvG(q);
dGq = dG(q,dq);

y = -invG'*J*invG*dGq*invG - invG'*Cross(J*invG*dq)*invG;