%边界层函数：避免奇异

function y = Lamda(ei)

%参数声明
global r l1 l2 epsilon

%函数输出
y = zeros(3,1);

if abs(ei(1)) >epsilon 
    y(1) = Sig(ei(1),r);
else 
    y(1) = l1*ei(1) + l2*Sig(ei(1),2);
end

if abs(ei(2)) >epsilon 
    y(2) = Sig(ei(2),r);
else 
    y(2) = l1*ei(2) + l2*Sig(ei(2),2);
end

if abs(ei(3)) >epsilon 
    y(3) = Sig(ei(3),r);
else 
    y(3) = l1*ei(3) + l2*Sig(ei(3),2);
end

end