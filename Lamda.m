%边界层函数：避免奇异

function y = Lamda(ei)

%参数声明
global r_l l1 l2 epsilon_l;

%函数输出
y = zeros(3,1);

if abs(ei(1)) >epsilon_l 
    y(1) = Sig(ei(1),r_l);
else 
    y(1) = l1*ei(1) + l2*Sig(ei(1),2);
end

if abs(ei(2)) >epsilon_l 
    y(2) = Sig(ei(2),r_l);
else 
    y(2) = l1*ei(2) + l2*Sig(ei(2),2);
end

if abs(ei(3)) >epsilon_l 
    y(3) = Sig(ei(3),r_l);
else 
    y(3) = l1*ei(3) + l2*Sig(ei(3),2);
end

end