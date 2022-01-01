function [Xl,wheelTravel] = parallel(X,resolution,rng)
% Perform parallel analysis of suspension kinematics. Returns coordinates
% corresponding to all displaced positions of both A-Arms, withing the
% vertical displacement of the upright upper joint indicated by 'rng'.
% wheelTravel returns vertical displacement of wheel center.
% The number of steps is determined based on 'resolution'.
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
%       12-Push Bellcrank X(34:36)
%       13-Bellcrank Bracket X(37:39)
%       14-Damper Bellcrank X([40 41 42])
%       15-Damper Bracket X([43 44 45])
% In such case, X must have 45 components.
%   'rng' is a real vector of lenght two
%   'resolution' is a real positive number that is not zero
switch nargin
    case 1
        if length(X) ~= 30 && length(X) ~= 45
            warning('enter a valid value of the arguments. Read function description for detailed information');
            return;
        end
        rng = [-35 35];
        resolution = 1;
    case 2
        if resolution <= 0 || (length(X) ~= 30 && length(X) ~= 45)
            warning('enter a valid value of the arguments. Read function description for detailed information');
            return;
        end
        rng = [-35 35];
    case 3
        if length(rng) ~= 2 || resolution <= 0 || (length(X) ~= 30 && length(X) ~= 45)
            warning('enter a valid value of the arguments. Read function description for detailed information');
            return;
        end
    otherwise
        warning('enter a valid number of arguments. Read function description for detailed information');
        return;
end
X = reshape(X,1,[]);
if length(X) == 30 %Only A-Arms present
    Analysis_Type = 1;
elseif length(X) == 45 %A-Arms + Suspension Mechanism
    Analysis_Type = 2;
end

% addpath('../geometric');

%define useful constant values
l=[norm(X([1 2 3])-X([13 14 15])) norm(X([4 5 6])-X([13 14 15])) norm(X([7 8 9])-X([16 17 18])) norm(X([10 11 12])-X([16 17 18]))]; %lenght of each A-Arm rod, and distance between upright links
uprightDimension = [norm(X([16 17 18])-X([13 14 15])) norm(X([22 23 24])-X([13 14 15])) norm(X([16 17 18])-X([22 23 24])) norm(X([25 26 27])-X([13 14 15])) norm(X([25 26 27])-X([16 17 18])) norm(X([25 26 27])-X([22 23 24]))];%Upright dimensions (distance between links, and between links and wheel center)
L_tieRod = norm(X([19 20 21])-X([22 23 24]));
wheelOrientation = [norm((X([25 26 27])+10*X([28 29 30]))-X([13 14 15])) norm((X([25 26 27])+10*X([28 29 30]))-X([16 17 18])) norm((X([25 26 27])+10*X([28 29 30]))-X([22 23 24]))];

if Analysis_Type == 2
    AarmPush_Bracket_Dimension = [norm(X([1 2 3])-X([31 32 33])) norm(X([4 5 6])-X([31 32 33])) norm(X([13 14 15])-X([31 32 33]))];
    Bellcrank_Dimension = [norm(X(34:36)- X(37:39)) norm(X(37:39)- X([40 41 42])) norm(X([40 41 42])- X(34:36)) vectsAngle(X(34:36)-X(37:39),X(40:42)-X(37:39))];
    Bellcrank_Plane = cross(X(40:42)- X(37:39),X(34:36)- X(37:39));
    L_push = norm(X([31 32 33])-X(34:36));
end


Xl = zeros(length(X), length(rng(1):resolution:rng(2))); %prealocate memory for this variable

disp = rng(1):resolution:rng(2);
if ~sum(disp==0) %If zero displacement is not in displacemente vector, include it
    i = sum(disp<0)+1;
    disp(i+1:end+1) = disp(i:end);
    disp(i) = 0;
end
i=0;%index
for wheelTravel = disp
    i=i+1;
    %Upper upright
    [intersection1,intersection2] = intersectPlane2Spheres(X([13 14 15])+[0 0 wheelTravel],[0 0 1],X([1 2 3]),l(1),X([4 5 6]),l(2));
    if intersection1(2) > intersection2(2)
        upperUpright = intersection1;
    else
        upperUpright = intersection2;
    end
    %Lower upright
    [intersection1,intersection2] = intersect3Spheres(X([7 8 9]),X([10 11 12]),upperUpright,l(3),l(4),uprightDimension(1));
    if intersection1(3) < intersection2(3)
        lowerUpright = intersection1;
    else
        lowerUpright = intersection2;
    end
    %Steering upright
    [intersection1,intersection2] = intersect3Spheres(X([19 20 21]),upperUpright,lowerUpright,L_tieRod,uprightDimension(2),uprightDimension(3));
    if X(22)>X(16) %If tie-rod is in front of kpi axis
        if intersection1(1) > intersection2(1) 
            steeringUpright = intersection1;
            if norm(intersection1-X(22:24)) > norm(intersection2-X(22:24))
                warning('Suspension travel calculations might be wrong due to multiple solutions that are similar (steeringUpright1A)');
            end
        else
            steeringUpright = intersection2;
            if norm(intersection2-X(22:24)) > norm(intersection1-X(22:24))
                warning('Suspension travel calculations might be wrong due to multiple solutions that are similar (steeringUpright1B)');
            end
        end
    else
        if intersection1(1) < intersection2(1)
            steeringUpright = intersection1;
            if norm(intersection1-X(22:24)) > norm(intersection2-X(22:24))
                warning('Suspension travel calculations might be wrong due to multiple solutions that are similar (steeringUpright2A)');
            end
        else
            steeringUpright = intersection2;
            if norm(intersection2-X(22:24)) > norm(intersection1-X(22:24))
                warning('Suspension travel calculations might be wrong due to multiple solutions that are similar (steeringUpright2B)');
            end
        end
    end
    %Wheel center
    [intersection1,intersection2] = intersect3Spheres(upperUpright,lowerUpright,steeringUpright,uprightDimension(4),uprightDimension(5),uprightDimension(6));
    if intersection1(2) > intersection2(2)
        wheelCenter = intersection1;
    else
        wheelCenter = intersection2;
    end
    %Wheel plane
    [intersection1,intersection2] = intersect3Spheres(upperUpright,lowerUpright,steeringUpright,wheelOrientation(1),wheelOrientation(2),wheelOrientation(3));
    if intersection1(2) > intersection2(2)
        wheelPlane = -(wheelCenter-intersection1)/norm(wheelCenter-intersection1);
    else
        wheelPlane = -(wheelCenter-intersection2)/norm(wheelCenter-intersection2);
    end
    Xl(1:30,i) = [X(1:12) upperUpright lowerUpright  X([19 20 21]) steeringUpright wheelCenter wheelPlane];
    
    if Analysis_Type == 2 %Análisis con A-Arms y Suspension Mechanism
        [A,B] = intersect3Spheres(X([1 2 3]), X([4 5 6]), upperUpright, AarmPush_Bracket_Dimension(1), AarmPush_Bracket_Dimension(2), AarmPush_Bracket_Dimension(3));
        if X(33)>X(15)
            if A(3)>B(3)
                Push_Aarm_Bracket = A;
            else
                Push_Aarm_Bracket = B;
            end
        else
            if A(3)<B(3)
                Push_Aarm_Bracket = A;
            else
                Push_Aarm_Bracket = B;
            end
        end
        [A,B] = intersectCircleSphere(X(37:39),Bellcrank_Dimension(1),Bellcrank_Plane,Push_Aarm_Bracket,L_push);
        if norm(A-X(34:36)) < norm(B-X(34:36))
            Push_Bellcrank = A;
        else
            Push_Bellcrank = B;
        end
        A = rotatePointFixedAxis(Bellcrank_Dimension(4), Bellcrank_Plane, X(37:39), Push_Bellcrank);
        Damper_Bellcrank = X(37:39) + (A-X(37:39))*Bellcrank_Dimension(2)/Bellcrank_Dimension(1);
        Xl(31:45,i) = [Push_Aarm_Bracket Push_Bellcrank X(37:39) Damper_Bellcrank X([43 44 45])];
    end
end
wheelTravel = Xl(27,:) - X(27);
%limit results to specified range
index = wheelTravel<rng(2)+resolution & wheelTravel>rng(1)-resolution;
wheelTravel = wheelTravel(index)';
Xl = Xl(:,index);
end

