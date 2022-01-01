function [] = kinematicsPlot(ax,X,tireRadius)
% Plot 3D representation of a quarter suspension
% 'X' is expected to contain the coordinates of one LEFT quarter suspension.
% It must be a row vector with the following values, in order:
%       1-Upper Front x,y,z = X([1 2 3])
%       2-Upper Rear x,y,z = X([4 5 6])
%       3-Lower Front x,y,z = X([7 8 9])
%       4-Lower Rear x,y,z = X([10 11 12])
%       5-Upper Upright x,y,z = X([13 14 15])
%       6-Lower Upright x,y,z = X([16 17 18])
%       7-Steering Rack x,y,z = X([19 20 21])
%       8-Steering Upright x,y,z = X([22 23 24])
%       9-Wheel Center x,y,z = X([25 26 27])
%       10-Wheel Plane x,y,z = X([28 29 30])
% Therefore, X must have 30 components in total.
% X may include the coordinates of the points of the suspension mechanism:
%       11-Push A-Arm Bracket X([31 32 33])
%       12-Push Bellcrank X([34 35 36])
%       13-Bellcrank Bracket X([37 38 39])
%       14-Damper Bellcrank X([40 41 42])
%       15-Damper Bracket X([43 44 45])
% In such case, X must have 45 components.

% addpath('./geometricFunctions');

if (length(X) ~= 30) && (length(X) ~= 45)
    warning(' must be a row vector of length 30. Check function description for detailed information');
    return;
end
if length(X) >= 30
    %Upper A-Arm
    plot3(ax,[X(1) X(13)],[X(2) X(14)],[X(3) X(15)],'color',[.4 .4 .5]);%Left
    plot3(ax,[X(4) X(13)],[X(5) X(14)],[X(6) X(15)],'color',[.4 .4 .5]);
    %Lower A-Arm
    plot3(ax,[X(7) X(16)],[X(8) X(17)],[X(9) X(18)],'color',[.4 .4 .5]);%Left
    plot3(ax,[X(10) X(16)],[X(11) X(17)],[X(12) X(18)],'color',[.4 .4 .5]);
    %Steering tie-rod
    plot3(ax,[X(19) X(22)],[X(20) X(23)],[X(21) X(24)],'color',[.4 .4 .5]);
    %Wheel
    plot3(ax,X(25), X(26), X(27),'o','color',[0 0 0]);
    plotCircle3D(ax,X([25 26 27]),X([28 29 30]),tireRadius);
    %     %Engine
    %     for i=0:5:243.44
    %     plotCircle3D(X([25 26 27])-X([28 29 30])./norm(X([28 29 30]))*i,X([28 29 30]),59,[1 0 0]);
    %     end
end
if length(X) >= 45
    %Push
    plot3(ax,[X(31) X(34)],[X(32) X(35)],[X(33) X(36)],'color',[.4 .4 .5]);
    %Bellcrank
    plot3(ax,[X(37) X(34)],[X(38) X(35)],[X(39) X(36)],'color',[.4 .4 .5]);
    plot3(ax,[X(37) X(40)],[X(38) X(41)],[X(39) X(42)],'color',[.4 .4 .5]);
    plot3(ax,[X(40) X(34)],[X(41) X(35)],[X(42) X(36)],'color',[.4 .4 .5]);
    %Damper
    plot3(ax,[X(40) X(43)],[X(41) X(44)],[X(42) X(45)],'color',[.4 .4 .5]);
end

