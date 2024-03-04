%边界层函数导数：避免奇异

function y = Dlamda(ei,dei)

%参数声明
global  r l1 l2 epsilon

%函数输出
y = zeros(3,1);

if abs(ei(1)) >epsilon 
    y(1) = r*abs(ei(1)).^(r-1).*dei(1);
else 
    y(1) = l1*dei(1) + 2*l2*abs(ei(1)).*dei(1);
end

if abs(ei(2)) >epsilon 
    y(2) = r*abs(ei(2)).^(r-1).*dei(2);
else 
    y(2) = l1*dei(2) + 2*l2*abs(ei(2)).*dei(2);
end

if abs(ei(3)) >epsilon 
    y(3) = r*abs(ei(3)).^(r-1).*dei(3);
else 
    y(3) = l1*dei(3) + 2*l2*abs(ei(3)).*dei(3);
end

end