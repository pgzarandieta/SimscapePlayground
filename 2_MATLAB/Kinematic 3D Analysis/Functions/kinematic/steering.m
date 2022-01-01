function [Xl,Xr,displacement] = steering(X,resolution,rng)
% Perform steering analysis of suspension kinematics. Returns coordinates
% corresponding to all rotated positions of both sides A-Arms, within the
% rack displacement range indicated by 'rng'
% The number of steps is determined based on 'resolution'.
%   'X' is expected to contain the coordinates of one LEFT quarter suspension.
%   It must be a row vector with the following values, in order:
%       1-Upper Front x,y,z = X([1 2 3])
%       2-Upper Rear x,y,z = X([4 5 6])
%       3-Lower Front x,y,z = X([7 8 9])
%       4-Lower Rear x,y,z = X([10 11 12])
%       5-Upper Upright x,y,z = X([13 14 15])
%       6-Lower Upright x,y,z = X([16 17 18])
%       7-Steering Rack x,y,z = X(19:21)
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
%   'rng' is a real number which indicated maximum roll angle
%   'resolution' is a real positive number that is not zero
switch nargin
    case 1
        if ~(length(X) == 30 || length(X) == 45)
            warning('enter a valid value of the arguments. Read function description for detailed information');
            return;
        end
        rng = [-36 36]; %Maximum rack displacement
        resolution = 1;
    case 2
        if resolution <= 0 || ~(length(X) == 30 || length(X) == 45)
            warning('enter a valid value of the arguments. Read function description for detailed information');
            return;
        end
        rng = [-36 36];
    case 3
        if resolution <= 0 || ~(length(X) == 30 || length(X) == 45)
            warning('enter a valid value of the arguments. Read function description for detailed information');
            return;
        end
    otherwise
        warning('enter a valid number of arguments. Read function description for detailed information');
        return;
end

% addpath('../geometric');

X = reshape(X,1,[]);

s = length(X);
sym = zeros(1,s);
for i = 3:3:s
    sym(i-2:i) = [1 -1 1];
end
X_R = X.*sym;


Xl = zeros(length(X), length(0:resolution:rng));
Xr = zeros(length(X), length(0:resolution:rng));

uprightDimension = [norm(X([16 17 18])-X([13 14 15])) norm(X([22 23 24])-X([13 14 15])) norm(X([16 17 18])-X([22 23 24])) norm(X([25 26 27])-X([13 14 15])) norm(X([25 26 27])-X([16 17 18])) norm(X([25 26 27])-X([22 23 24]))];%Upright dimensions (distance between links, and between links and wheel center)
L_tieRod = norm(X(19:21)-X([22 23 24]));
wheelOrientation = [norm((X([25 26 27])+10*X([28 29 30]))-X([13 14 15])) norm((X([25 26 27])+10*X([28 29 30]))-X([16 17 18])) norm((X([25 26 27])+10*X([28 29 30]))-X([22 23 24]))];
rackLength = norm(X(19:21) - X_R(19:21));
rackVect = (X(19:21) - X_R(19:21))/rackLength;
upperUpright_L = X([13 14 15]);
upperUpright_R = X_R([13 14 15]);
lowerUpright_L = X([16 17 18]);
lowerUpright_R = X_R([16 17 18]);

i = 0;
for displacement = rng(1):resolution:rng(2)
    i = i + 1;
    Xl(1:18, i) = X(1:18);
    Xr(1:18, i) = X_R(1:18);
    if length(X) == 45
        Xl(31:45, i) = X(31:45);
        Xr(31:45, i) = X_R(31:45);
    end
    
    Xl(19:21,i) = X(19:21) + displacement*rackVect; %Steering rack
    Xr(19:21,i) = X_R(19:21) + displacement*rackVect;
    
    %Steering upright
    [intersection1,intersection2] = intersect3Spheres_old(Xl(19:21,i),upperUpright_L,lowerUpright_L,L_tieRod,uprightDimension(2),uprightDimension(3));
    if X(22)>X(16) %If tie-rod is in front of kpi axis
        if intersection1(1) > intersection2(1)
            steeringUpright_L = intersection1;
            if norm(intersection1-X(22:24)) > norm(intersection2-X(22:24))
                warning('Suspension displacement calculations for STEERING might be wrong due to multiple solutions that are similar');
            end
        else
            steeringUpright_L = intersection2;
            if norm(intersection2-X(22:24)) > norm(intersection1-X(22:24))
                warning('Suspension displacement calculations for STEERING might be wrong due to multiple solutions that are similar');
            end
        end
    else
        if intersection1(1) < intersection2(1)
            steeringUpright_L = intersection1;
            if norm(intersection1-X(22:24)) > norm(intersection2-X(22:24))
                warning('Suspension displacement calculations for STEERING might be wrong due to multiple solutions that are similar');
            end
        else
            steeringUpright_L = intersection2;
            if norm(intersection2-X(22:24)) > norm(intersection1-X(22:24))
                warning('Suspension displacement calculations for STEERING might be wrong due to multiple solutions that are similar');
            end
        end
    end
    [intersection1,intersection2] = intersect3Spheres_old(Xr(19:21,i),upperUpright_R,lowerUpright_R,L_tieRod,uprightDimension(2),uprightDimension(3));
    if X_R(22)>X_R(16) %If tie-rod is in front of kpi axis
        if intersection1(1) > intersection2(1)
            steeringUpright_R = intersection1;
            if norm(intersection1-X_R(22:24)) > norm(intersection2-X_R(22:24))
                warning('Suspension displacement calculations for STEERING might be wrong due to multiple solutions that are similar');
            end
        else
            steeringUpright_R = intersection2;
            if norm(intersection2-X_R(22:24)) > norm(intersection1-X_R(22:24))
                warning('Suspension displacement calculations for STEERING might be wrong due to multiple solutions that are similar');
            end
        end
    else
        if intersection1(1) < intersection2(1)
            steeringUpright_R = intersection1;
            if norm(intersection1-X_R(22:24)) > norm(intersection2-X_R(22:24))
                warning('Suspension displacement calculations for STEERING might be wrong due to multiple solutions that are similar');
            end
        else
            steeringUpright_R = intersection2;
            if norm(intersection2-X_R(22:24)) > norm(intersection1-X_R(22:24))
                warning('Suspension displacement calculations for STEERING might be wrong due to multiple solutions that are similar');
            end
        end
    end
    %Wheel center
    [intersection1,intersection2] = intersect3Spheres(upperUpright_L,lowerUpright_L,steeringUpright_L,uprightDimension(4),uprightDimension(5),uprightDimension(6));
    if intersection1(2) > intersection2(2)
        wheelCenter_L = intersection1;
    else
        wheelCenter_L = intersection2;
    end
    [intersection1,intersection2] = intersect3Spheres(upperUpright_R,lowerUpright_R,steeringUpright_R,uprightDimension(4),uprightDimension(5),uprightDimension(6));
    if intersection1(2) < intersection2(2)
        wheelCenter_R = intersection1;
    else
        wheelCenter_R = intersection2;
    end
    %Wheel plane
    [intersection1,intersection2] = intersect3Spheres(upperUpright_L,lowerUpright_L,steeringUpright_L,wheelOrientation(1),wheelOrientation(2),wheelOrientation(3));
    if intersection1(2) > intersection2(2)
        wheelPlane_L = -(wheelCenter_L-intersection1)/norm(wheelCenter_L-intersection1);
    else
        wheelPlane_L = -(wheelCenter_L-intersection2)/norm(wheelCenter_L-intersection2);
    end
    [intersection1,intersection2] = intersect3Spheres(upperUpright_R,lowerUpright_R,steeringUpright_R,wheelOrientation(1),wheelOrientation(2),wheelOrientation(3));
    if intersection1(2) < intersection2(2)
        wheelPlane_R = -(wheelCenter_R-intersection1)/norm(wheelCenter_R-intersection1);
    else
        wheelPlane_R = -(wheelCenter_R-intersection2)/norm(wheelCenter_R-intersection2);
    end
    Xl(22:30,i) = [steeringUpright_L wheelCenter_L wheelPlane_L];
    Xr(22:30,i) = [steeringUpright_R wheelCenter_R wheelPlane_R];
end
displacement = rng(1):resolution:rng(2);
displacement = displacement';
