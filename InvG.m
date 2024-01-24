% G(q)^(-1)函数实现

function y = InvG(q)

Gq = G(q);

y = 16/((1+q'*q)^2)*Gq';