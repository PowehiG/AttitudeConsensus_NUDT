
while true
    choice = input('Enter choice 1:Attitude, 2:Attitude_dot, 3:Control: 4:InnerSMS, 5:OuterSMS:');
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
        otherwise
            break;
    end
end