% Sat函数

function y = Sat(x,r)

y = (x/r-1).*Sgn(-abs(x)+r) + 1;