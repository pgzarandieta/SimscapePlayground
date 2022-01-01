function [rollCenter] = rollCenter(X, X_R, tireRadius, Xaxis, Yaxis, Zaxis)
%%Calculate roll center coordinates for suspension defined by X and tireRadius. 
% Note that roll ceneter height ( rollCenter(3) ) does not have the same
% reference system as X nor X_R. Instead, it is the height respect to the
% ground plane calculated from the contact patch of each wheel
%
%   'X' is expected to contain the coordinates of one LEFT quarter suspension.
%   It must be a COLUMN vector with the following values, in order:
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
% steering. For example, should X be a 30 by 17 matrix, X(:,3) contains the
% coordinates of the suspension system in the position 3 of the respective
% displacement.
% The result is returned in a matrix of n-1 dimensions 

% addpath('../geometric');

switch nargin
    case 3
        Xaxis = [];
        Yaxis = [];
        Zaxis = [];
    case 4
        Yaxis = [];
        Zaxis = [];
    case 5
        Zaxis = [];
    case 6
    otherwise
        warning('Enter a valid number of arguments. Read function description for detailed information');
        return;
end
L = [max(1,length(Xaxis)) max(1,length(Yaxis)) max(1,length(Zaxis))];
rollCenter = zeros([3 L]);
for i = 1:L(1)
    for j = 1:L(2)
        for k = 1:L(3)
            contactPatch_L = X(25:27,i,j,k)' - tireRadius*intersect2planes(X(28:30,i,j,k),X(25:27,i,j,k),cross([0 0 1],X(28:30,i,j,k)),X(25:27,i,j,k));
            contactPatch_R = X_R(25:27,i,j,k)' - tireRadius*intersect2planes(X_R(28:30,i,j,k),X_R(25:27,i,j,k),cross([0 0 1],X_R(28:30,i,j,k)),X_R(25:27,i,j,k));
            frontViewIC_L = intersect3planes(cross(X(13:15,i,j,k)-X(1:3,i,j,k),X(13:15,i,j,k)-X(4:6,i,j,k)),X(13:15,i,j,k),cross(X(16:18,i,j,k)-X(7:9,i,j,k),X(16:18,i,j,k)-X(10:12,i,j,k)),X(16:18,i,j,k),[1 0 0],contactPatch_L);
            frontViewIC_R = intersect3planes(cross(X_R(13:15,i,j,k)-X_R(1:3,i,j,k),X_R(13:15,i,j,k)-X_R(4:6,i,j,k)),X_R(13:15,i,j,k),cross(X_R(16:18,i,j,k)-X_R(7:9,i,j,k),X_R(16:18,i,j,k)-X_R(10:12,i,j,k)),X_R(16:18,i,j,k),[1 0 0],contactPatch_R);
            sideViewIC_L =  intersect3planes(cross(X(13:15,i,j,k)-X(1:3,i,j,k),X(13:15,i,j,k)-X(4:6,i,j,k)),X(13:15,i,j,k),cross(X(16:18,i,j,k)-X(7:9,i,j,k),X(16:18,i,j,k)-X(10:12,i,j,k)),X(16:18,i,j,k),[0 1 0],contactPatch_L);
            sideViewIC_R = intersect3planes(cross(X_R(13:15,i,j,k)-X_R(1:3,i,j,k),X_R(13:15,i,j,k)-X_R(4:6,i,j,k)),X_R(13:15,i,j,k),cross(X_R(16:18,i,j,k)-X_R(7:9,i,j,k),X_R(16:18,i,j,k)-X_R(10:12,i,j,k)),X_R(16:18,i,j,k),[0 1 0],contactPatch_R);
            rollCenter(:,i,j,k) = intersect3planes(cross(frontViewIC_L-contactPatch_L,sideViewIC_L-contactPatch_L),contactPatch_L,cross(frontViewIC_R-contactPatch_R,sideViewIC_R-contactPatch_R),contactPatch_R,cross([0 0 1],contactPatch_L-contactPatch_R),contactPatch_R);
            RCground = intersectPlaneLine(contactPatch_L-contactPatch_R, rollCenter(:,i,j,k), contactPatch_L-contactPatch_R, contactPatch_L);
            if rollCenter(3,i,j,k)-RCground(3)>0
                rollCenter(3,i,j,k) = norm(rollCenter(:,i,j,k)' - RCground); %modificar el valor de la coordenada z para que se corresponda con la altura respecto al suelo
            else
                rollCenter(3,i,j,k) = -norm(rollCenter(:,i,j,k)' - RCground);
            end
        end
    end
end
end






























