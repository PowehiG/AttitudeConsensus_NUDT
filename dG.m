% 航天器动力学模型相关参数 dG实现

function y = dG(q,dq)

global I3;
y = 0.5*((-q'*dq)*I3 + (q*dq')+(q*dq')'+ Cross(dq));
