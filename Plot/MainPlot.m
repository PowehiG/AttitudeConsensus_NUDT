
while true
    choice = input('Enter choice 1:Attitude, 2:Attitude_dot, \n 3:Control, 4:InnerSMS, 5:OuterSMS, 6: PIcompare :');
    switch choice
        case 1
            AttitudePlot;
        case 2
            AnglevelocityPlot;
        case 3
            ControlTorquePlot;
        case 4
            innerSMSPlot;
        case 5
            FOSMSPlot;
        case 6
            compare;
        otherwise
            break;
    end
end