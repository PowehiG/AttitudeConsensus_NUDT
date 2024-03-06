%边界层函数导数：避免奇异

function y = Dlamda(ei,dei)

%参数声明
global  r_l l1 l2 epsilon_l;

%函数输出
y = zeros(3,1);

if abs(ei(1)) >epsilon_l 
    y(1) = r_l*abs(ei(1)).^(r_l-1).*dei(1);
else 
    y(1) = l1*dei(1) + 2*l2*abs(ei(1)).*dei(1);
end

if abs(ei(2)) >epsilon_l 
    y(2) = r_l*abs(ei(2)).^(r_l-1).*dei(2);
else 
    y(2) = l1*dei(2) + 2*l2*abs(ei(2)).*dei(2);
end

if abs(ei(3)) >epsilon_l
    y(3) = r_l*abs(ei(3)).^(r_l-1).*dei(3);
else 
    y(3) = l1*dei(3) + 2*l2*abs(ei(3)).*dei(3);
end

end