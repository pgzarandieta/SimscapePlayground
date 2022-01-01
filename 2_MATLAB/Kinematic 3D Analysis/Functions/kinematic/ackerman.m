function [ackerman] = ackerman(X_L, X_R, wheelbase, track, Xaxis, Yaxis, Zaxis)
%%Ackerman - [ackerman] = ackerman(X_L, X_R, wheelbase, track, Xaxis, Yaxis, Zaxis)
% Calculate ackerman percentage of a given suspension system. The formula
% used for calculation is: ackerman(i) = (toe_L - toe_R)/(toe_L - atan(wheelbase/(wheelbase/tan(toe_L)+track)))*100;
% being:
%  -toe_L = left wheel steering angle
%  -toe_R = right wheel steering angle
%  -atan(wheelbase/(wheelbase/tan(toe_L)+track)) = ideal ackerman steering angle
% As can be deduced, the left wheel is being used as reference, regardless whether it
% is the inside or the outside wheel.
% This formula yields the following results:
%  ackerman > 100%  => ProAckerman
%  100% > ackerman > 0%  => 'Ackerman'
%  ackerman = 0% => Parallel steering
%  0% > ackerman => AntiAckerman
%
%   'X' is expected to contain the coordinates of one LEFT quarter suspension.
%   It must be a row vector with the following values, in order:
%       1-Upper Front x,y,z = X([1 2 3])
%       2-Upper Rear x,y,z = X([4 5 6])
%       3-Lower Front x,y,z = X([7 8 9])s
%       4-Lower Rear x,y,z = X([10 11 12])
%       5-Upper Upright x,y,z = X([13 14 15])
%       6-Lower Upright x,y,z = X([16 17 18])
%       7-Steering Rack x,y,z = X([19 20 21])
%       8-Steering Upright x,y,z = X([22 23 24])
%       9-Wheel Center x,y,z = X([25 26 27])
%       10-Wheel Plane x,y,z = X([28 29 30])
%   X may include the coordinates of the points of the suspension mechanism:
%       11-Push A-Arm Bracket X([31 32 33])
%       12-Push Bellcrank X([34 35 36])
%       13-Bellcrank Bracket X([37 38 39])
%       14-Damper Bellcrank X([40 41 42])
%       15-Damper Bracket X([43 44 45])
% In such case, X must have 45 components.
% X can be a matrix of, at most, 4 dimensions. The first index must
% refer to the coordinates, as already explained. The other indices may
% refer to different displacements of the suspension, i.e ride, roll or
% steering. For example, should X be a 30 by 17 matrix, X(:,5) contains the
% coordinates of the suspension system in the position 5 of the respective
% displacement, and X(5,:) contains the Y coordinate of the Upper Rear
% a-arm hardpoint of every position of the respective displacement.
% The result is returned in a matrix of n-1 dimensions 

% addpath('../geometric');
maxValue = 1000; %avoid infinite values near discontinuitys
switch nargin
    case 4
        Xaxis = [];
        Yaxis = [];
        Zaxis = [];
    case 5
        Yaxis = [];
        Zaxis = [];
    case 6
        Zaxis = [];
    case 7
    otherwise
        warning('Enter a valid number of arguments. Read function description for detailed information');
        return;
end
L = [max(1,length(Xaxis)) max(1,length(Yaxis)) max(1,length(Zaxis))]; %Size of displacements matrix
ackerman = zeros(L);
for i = 1:L(1)
    for j = 1:L(2)
        for k = 1:L(3)
            toe_L = -vectsAngle(projectVectPlane(X_L(28:30,i,j,k),[0 0 1]),[0 1 0],'rad')*sign(X_L(28,i,j,k));
            toe_R = vectsAngle(projectVectPlane(X_R(28:30,i,j,k),[0 0 1]),[0 -1 0],'rad')*sign(X_R(28,i,j,k));
            ack_R = atan(wheelbase/(wheelbase/tan(abs(toe_L))+track*sign(toe_L)))*sign(toe_L);
            ackerman(i,j,k) = (toe_L-toe_R)/(toe_L - ack_R)*100;
        end
    end
end
ackerman(ackerman>maxValue) = maxValue;
ackerman(ackerman<-maxValue) = -maxValue;
end