function [kpi] = kpi(X, Xaxis, Yaxis, Zaxis)
%%Calculate kpi angle for suspension defined by X and tireRadius
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
% steering. For example, should X be a 30 by 17 matrix, X(:,3) contains the
% coordinates of the suspension system in the position 3 of the respective
% displacement.
% The result is returned in a matrix of n-1 dimensions 

% addpath('../geometric');

switch nargin
    case 1
        Xaxis = [];
        Yaxis = [];
        Zaxis = [];
    case 2
        Yaxis = [];
        Zaxis = [];
    case 3
        Zaxis = [];
    case 4
    otherwise
        warning('Enter a valid number of arguments. Read function description for detailed information');
        return;
end
L = [max(1,length(Xaxis)) max(1,length(Yaxis)) max(1,length(Zaxis))];
kpi = zeros(L);
for i = 1:L(1)
    for j = 1:L(2)
        for k = 1:L(3)
            kpiAxis = X(13:15,i,j,k) - X(16:18,i,j,k);
            kpi(i,j,k) = -vectsAngle(projectVectPlane(kpiAxis,[1 0 0]),[0 0 1],'deg')*sign(kpiAxis(2)*X(26,i,j,k));
        end
    end
end
end


