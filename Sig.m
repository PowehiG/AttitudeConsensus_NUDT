% 运算符号Sig

function y = Sig(x,r)

y = sign(x).*(abs(x).^r);