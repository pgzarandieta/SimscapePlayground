function [Xl,Xr,rollAngle,wheelTravel] = roll(X, tireRadius,resolution,rng,tol)
% Perform roll analysis of suspension kinematics. Returns coordinates
% corresponding to all rotated positions of both A-Arms, withing the
% body roll indicated by 'rng'
% The number of steps is determined based on 'resolution'.
%   'X' is expected to contain the coordinates of one LEFT quarter suspension.
%   It must be a row vector with the following values, in order:
%       1-Upper Front x,y,z = X(1:3)
%       2-Upper Rear x,y,z = X(4:6)
%       3-Lower Front x,y,z = X(7:9)s
%       4-Lower Rear x,y,z = X(10:12)
%       5-Upper Upright x,y,z = X(13:15)
%       6-Lower Upright x,y,z = X(16:18)
%       7-Steering Rack x,y,z = X(19:21)
%       8-Steering Upright x,y,z = X(22:24)
%       9-Wheel Center x,y,z = X(25:27)
%       10-Wheel Plane x,y,z = X(28:30)
%   X may include the coordinates of the points of the suspension mechanism:
%       11-Push A-Arm Bracket X(31:33)
%       12-Push Bellcrank X(34:36)
%       13-Bellcrank Bracket X(37:39)
%       14-Damper Bellcrank X(40:42)
%       15-Damper Bracket X(43:45)
% In such case, X must have 45 components.
%   'rng' is a real number which indicates maximum roll angle
%   'resolution' is a real positive number (zero is not positive)
switch nargin
    case 2
        if ~(length(X) == 30 || length(X) == 45)
            warning('enter a valid value of the arguments. Read function description for detailed information');
            return;
        end
        rng = 2.5;
        resolution = 0.1;
        tol = 0.1;
    case 3
        if resolution <= 0 || ~(length(X) == 30 || length(X) == 45)
            warning('enter a valid value of the arguments. Read function description for detailed information');
            return;
        end
        rng = 2.5;
        tol = 0.1;
    case 4
        if rng <= 0 || resolution <= 0 || ~(length(X) == 30 || length(X) == 45)
            warning('enter a valid value of the arguments. Read function description for detailed information');
            return;
        end
        tol = 0.1;
    case 5
        if (tol <= 0 || tol >1) || rng <= 0 || resolution <= 0 || ~(length(X) == 30 || length(X) == 45)
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

%Calculate useful parameters
GroundPlaneZ = (X(25:27) - tireRadius*intersect2planes(X(28:30),X(25:27),cross([0 0 1],X(28:30)),X(25:27)))*[0 0 1]'; %Coordenada z del suelo (se calcula igual que la huella de contacto)
l=[norm(X(1:3)-X(13:15)) norm(X(4:6)-X(13:15)) norm(X(7:9)-X(16:18)) norm(X(10:12)-X(16:18))]; %lenght of each A-Arm rod, and distance between upright links
uprightDimension = [norm(X(16:18)-X(13:15)) norm(X(22:24)-X(13:15)) norm(X(16:18)-X(22:24)) norm(X(25:27)-X(13:15)) norm(X(25:27)-X(16:18)) norm(X(25:27)-X(22:24))];%Upright dimensions (distance between links, and between links and wheel center)
L_tieRod = norm(X(19:21)-X(22:24));
wheelOrientation = [norm((X(25:27)+X(28:30))-X(13:15)) norm((X(25:27)+X(28:30))-X(16:18)) norm((X(25:27)+X(28:30))-X(22:24))];
if length(X) == 45
    AarmPush_Bracket_Dimension = [norm(X(1:3)-X(31:33)) norm(X(4:6)-X(31:33)) norm(X(13:15)-X(31:33))];
    Bellcrank_Dimension = [norm(X(34:36)- X(37:39)) norm(X(37:39)- X(40:42)) norm(X(40:42)- X(34:36)) vectsAngle(X(34:36)-X(37:39),X(40:42)-X(37:39))];
    Bellcrank_Plane_L = cross(X(40:42)- X(37:39),X(34:36)- X(37:39));
    Bellcrank_Plane_R = cross(X_R(40:42)- X_R(37:39),X_R(34:36)- X_R(37:39));
    L_push = norm(X(31:33)-X(34:36));
end

%Calculate roll Axis for the first time
contactPatch_L = X(25:27) - tireRadius*intersect2planes(X(28:30),X(25:27),cross([0 0 1],X(28:30)),X(25:27));
contactPatch_R = X_R(25:27) - tireRadius*intersect2planes(X_R(28:30),X_R(25:27),cross([0 0 1],X_R(28:30)),X_R(25:27));
frontViewIC_L = intersect3planes(cross(X(13:15)-X(1:3),X(13:15)-X(4:6)),X(13:15),cross(X(16:18)-X(7:9),X(16:18)-X(10:12)),X(16:18),[1 0 0],contactPatch_L);
frontViewIC_R = intersect3planes(cross(X_R(13:15)-X_R(1:3),X_R(13:15)-X_R(4:6)),X_R(13:15),cross(X_R(16:18)-X_R(7:9),X_R(16:18)-X_R(10:12)),X_R(16:18),[1 0 0],contactPatch_R);
sideViewIC_L = intersect3planes(cross(X(13:15)-X(1:3),X(13:15)-X(4:6)),X(13:15),cross(X(16:18)-X(7:9),X(16:18)-X(10:12)),X(16:18),[0 1 0],contactPatch_L);
sideViewIC_R = intersect3planes(cross(X_R(13:15)-X_R(1:3),X_R(13:15)-X_R(4:6)),X_R(13:15),cross(X_R(16:18)-X_R(7:9),X_R(16:18)-X_R(10:12)),X_R(16:18),[0 1 0],contactPatch_R);

[rollAxis, rollAxisPoint] = intersect2planes(cross(frontViewIC_L-contactPatch_L,sideViewIC_L-contactPatch_L),contactPatch_L,cross(frontViewIC_R-contactPatch_R,sideViewIC_R-contactPatch_R),contactPatch_R);
if rollAxis(1) > 0
        rollAxis = -rollAxis; %ensure that roll occurs always in the same direction
end
    
%Vector fixed to chassis is used as reference to calculate roll angle
refVector = cross(X(1:3)-X(4:6), X(1:3)-X_R(1:3));

% First differential rotations around roll axis. Only points fixed to the chassis are rotate. Also, the upper upright point is rotated as it is used for reference
i = 1;
rollAngle(1) = 0;

Xl(i,:) = zeros(1,length(X));
Xl(i,1:3) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X(1:3));% A-arms
Xl(i,4:6) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X(4:6));
Xl(i,7:9) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X(7:9));
Xl(i,10:12) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X(10:12));
Xl(i,19:21) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X(19:21));% Steering Rack
Xl(i,13:15) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X(13:15));% Upper upright for reference
Xr(i,:) = zeros(1,length(X));
Xr(i,1:3) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X_R(1:3));
Xr(i,4:6) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X_R(4:6));
Xr(i,7:9) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X_R(7:9));
Xr(i,10:12) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X_R(10:12));
Xr(i,19:21) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X_R(19:21));
Xr(i,13:15) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X_R(13:15));
if length(X) == 45
    Xl(i,37:39) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X(i,37:39));
    Xl(i,43:45) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X(i,43:45));
    Xr(i,37:39) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X_R(i,37:39));
    Xr(i,43:45) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X_R(i,43:45));
    bellcrankPlane_l(i,1:3) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X(i,37:39)+Bellcrank_Plane_L) - Xl(i,37:39);
    bellcrankPlane_r(i,1:3) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, X_R(i,37:39)+Bellcrank_Plane_R) - Xr(i,37:39);
end

dispRange = linspace(pi/180*resolution*norm(contactPatch_L(2))*0.5, pi/180*resolution*norm(contactPatch_L(2))*1.5, round(2/tol));
% dispRange = -3:0.2:3;
while abs(rollAngle(max(1,i-1)) - rng) > resolution
    Xfl = zeros(length(dispRange),length(X)); %prealocate memory for this variable
    Xfr = zeros(length(dispRange),length(X_R)); %prealocate memory for this variable
    j=0;%index
    wheelTravel_contactPatch_L = zeros(1,length(dispRange));
    wheelTravel_contactPatch_R = zeros(1,length(dispRange));
    
    for displacement = dispRange
        j=j+1;
        %Upper upright
        [intersection1,intersection2] = intersectPlane2Spheres(Xl(i,13:15)+[0 0 -displacement],[0 0 1],Xl(i,1:3),l(1),Xl(i,4:6),l(2));
        if intersection1(2) > intersection2(2)
            upperUpright_L = intersection1;
        else
            upperUpright_L = intersection2;
        end
        [intersection1,intersection2] = intersectPlane2Spheres(Xr(i,13:15)+[0 0 displacement],[0 0 1],Xr(i,1:3),l(1),Xr(i,4:6),l(2));
        if intersection1(2) < intersection2(2)
            upperUpright_R = intersection1;
        else
            upperUpright_R = intersection2;
        end
        %Lower upright
        [intersection1,intersection2] = intersect3Spheres(Xl(i,7:9),Xl(i,10:12),upperUpright_L,l(3),l(4),uprightDimension(1));
        if intersection1(3) < intersection2(3)
            lowerUpright_L = intersection1;
        else
            lowerUpright_L = intersection2;
        end
        [intersection1,intersection2] = intersect3Spheres(Xr(i,7:9),Xr(i,10:12),upperUpright_R,l(3),l(4),uprightDimension(1));
        if intersection1(3) < intersection2(3)
            lowerUpright_R = intersection1;
        else
            lowerUpright_R = intersection2;
        end
        %Steering upright
        [intersection1,intersection2] = intersect3Spheres_old(Xl(i,19:21),upperUpright_L,lowerUpright_L,L_tieRod,uprightDimension(2),uprightDimension(3));
        if X(22)>X(16) %If tie-rod is in front of kpi axis
            if intersection1(1) > intersection2(1)
                steeringUpright_L = intersection1;
                if norm(intersection1-X(22:24)) > norm(intersection2-X(22:24))
                    warning('Suspension displacement calculations in ROLL might be wrong due to multiple solutions that are similar');
                end
            else
                steeringUpright_L = intersection2;
                if norm(intersection2-X(22:24)) > norm(intersection1-X(22:24))
                    warning('Suspension displacement calculations in ROLL might be wrong due to multiple solutions that are similar');
                end
            end
        else
            if intersection1(1) < intersection2(1)
                steeringUpright_L = intersection1;
                if norm(intersection1-X(22:24)) > norm(intersection2-X(22:24))
                    warning('Suspension displacement calculations in ROLL might be wrong due to multiple solutions that are similar');
                end
            else
                steeringUpright_L = intersection2;
                if norm(intersection2-X(22:24)) > norm(intersection1-X(22:24))
                    warning('Suspension displacement calculations in ROLL might be wrong due to multiple solutions that are similar');
                end
            end
        end
        [intersection1,intersection2] = intersect3Spheres_old(Xr(i,19:21),upperUpright_R,lowerUpright_R,L_tieRod,uprightDimension(2),uprightDimension(3));
        if X_R(22)>X_R(16) %If tie-rod is in front of kpi axis
            if intersection1(1) > intersection2(1)
                steeringUpright_R = intersection1;
                if norm(intersection1-X_R(22:24)) > norm(intersection2-X_R(22:24))
                    warning('Suspension displacement calculations in ROLL might be wrong due to multiple solutions that are similar');
                end
            else
                steeringUpright_R = intersection2;
                if norm(intersection2-X_R(22:24)) > norm(intersection1-X_R(22:24))
                    warning('Suspension displacement calculations in ROLL might be wrong due to multiple solutions that are similar');
                end
            end
        else
            if intersection1(1) < intersection2(1)
                steeringUpright_R = intersection1;
                if norm(intersection1-X_R(22:24)) > norm(intersection2-X_R(22:24))
                    warning('Suspension displacement calculations in ROLL might be wrong due to multiple solutions that are similar');
                end
            else
                steeringUpright_R = intersection2;
                if norm(intersection2-X_R(22:24)) > norm(intersection1-X_R(22:24))
                    warning('Suspension displacement calculations in ROLL might be wrong due to multiple solutions that are similar');
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
        
        Xfl(j,1:30) = [Xl(i,1:12) upperUpright_L lowerUpright_L  Xl(i,19:21) steeringUpright_L wheelCenter_L wheelPlane_L];
        wheelTravel_contactPatch_L(j) = (Xfl(j,25:27) - tireRadius*intersect2planes(Xfl(j,28:30),Xfl(j,25:27),cross([0 0 1],Xfl(j,28:30)),Xfl(j,25:27))) * [0 0 1]';
        Xfr(j,1:30) = [Xr(i,1:12) upperUpright_R lowerUpright_R  Xr(i,19:21) steeringUpright_R wheelCenter_R wheelPlane_R];
        wheelTravel_contactPatch_R(j) = (Xfr(j,25:27) - tireRadius*intersect2planes(Xfr(j,28:30),Xfr(j,25:27),cross([0 0 1],Xfr(j,28:30)),Xfr(j,25:27))) * [0 0 1]';
    end
    [~, Index] = min(abs(wheelTravel_contactPatch_L - GroundPlaneZ));
    Xl(i,1:30) = Xfl(Index,1:30);
    wheelTravel_l(i) = -dispRange(Index);
    [~, Index] = min(abs(wheelTravel_contactPatch_R - GroundPlaneZ));
    Xr(i,1:30) = Xfr(Index,1:30);
    wheelTravel_r(i) = dispRange(Index);
    if length(X) == 45 %Análisis con A-Arms y Suspension Mechanism
        % Push Bracket
        [A,B] = intersect3Spheres(Xl(i, 1:3), Xl(i, 4:6), upperUpright_L, AarmPush_Bracket_Dimension(1), AarmPush_Bracket_Dimension(2), AarmPush_Bracket_Dimension(3));
        if X(33)>X(15)
            if A(3)>B(3)
                Push_Aarm_Bracket_L = A;
            else
                Push_Aarm_Bracket_L = B;
            end
        else
            if A(3)<B(3)
                Push_Aarm_Bracket_L = A;
            else
                Push_Aarm_Bracket_L = B;
            end
        end
        [A,B] = intersect3Spheres(Xr(i, 1:3), Xr(i, 4:6), upperUpright_R, AarmPush_Bracket_Dimension(1), AarmPush_Bracket_Dimension(2), AarmPush_Bracket_Dimension(3));
        if X(33)>X(15)
            if A(3)>B(3)
                Push_Aarm_Bracket_R = A;
            else
                Push_Aarm_Bracket_R = B;
            end
        else
            if A(3)<B(3)
                Push_Aarm_Bracket_R = A;
            else
                Push_Aarm_Bracket_R = B;
            end
        end
        % Bellcrank Push
        [A,B] = intersectCircleSphere(Xl(i, 37:39),Bellcrank_Dimension(1),bellcrankPlane_l(i,1:3),Push_Aarm_Bracket_L,L_push);
        if norm(A-X(34:36)) < norm(B-X(34:36))
            Push_Bellcrank_L = A;
        else
            Push_Bellcrank_L = B;
        end
        [A,B] = intersectCircleSphere(Xr(i, 37:39),Bellcrank_Dimension(1),bellcrankPlane_r(i,1:3),Push_Aarm_Bracket_R,L_push);
        if norm(A-X_R(34:36)) < norm(B-X_R(34:36))
            Push_Bellcrank_R = A;
        else
            Push_Bellcrank_R = B;
        end
        % Bellcrank Damper
        A = rotatePointFixedAxis(Bellcrank_Dimension(4), bellcrankPlane_l(i,1:3), Xl(i, 37:39), Push_Bellcrank_L);
        Damper_Bellcrank_L = Xl(i, 37:39) + (A-Xl(i, 37:39))*Bellcrank_Dimension(2)/Bellcrank_Dimension(1);
        A = rotatePointFixedAxis(Bellcrank_Dimension(4), bellcrankPlane_r(i,1:3), Xr(i, 37:39), Push_Bellcrank_R);
        Damper_Bellcrank_R = Xr(i, 37:39) + (A-Xr(i, 37:39))*Bellcrank_Dimension(2)/Bellcrank_Dimension(1);
        % Assign values
        Xl(i,31:45) = [Push_Aarm_Bracket_L Push_Bellcrank_L Xl(i, 37:39) Damper_Bellcrank_L Xl(i, 43:45)];
        Xr(i,31:45) = [Push_Aarm_Bracket_R Push_Bellcrank_R Xr(i, 37:39) Damper_Bellcrank_R Xr(i, 43:45)];
    end
    
    rollAngle(i) = vectsAngle(refVector,cross(Xl(i,1:3)-Xl(i,4:6), Xl(i,1:3)-Xr(i,1:3)));
    
    
    %Recalculate roll axis
    contactPatch_L = Xl(i, 25:27) - tireRadius*intersect2planes(Xl(i, 28:30),Xl(i, 25:27),cross([0 0 1],Xl(i, 28:30)),Xl(i, 25:27));
    contactPatch_R = Xr(i, 25:27) - tireRadius*intersect2planes(Xr(i, 28:30),Xr(i, 25:27),cross([0 0 1],Xr(i, 28:30)),Xr(i, 25:27));
    frontViewIC_L = intersect3planes(cross(Xl(i, 13:15)-Xl(i, 1:3),Xl(i, 13:15)-Xl(i, 4:6)),Xl(i, 13:15),cross(Xl(i, 16:18)-Xl(i, 7:9),Xl(i, 16:18)-Xl(i, 10:12)),Xl(i, 16:18),[1 0 0],contactPatch_L);
    frontViewIC_R = intersect3planes(cross(Xr(i, 13:15)-Xr(i, 1:3),Xr(i, 13:15)-Xr(i, 4:6)),Xr(i, 13:15),cross(Xr(i, 16:18)-Xr(i, 7:9),Xr(i, 16:18)-Xr(i, 10:12)),Xr(i, 16:18),[1 0 0],contactPatch_R);
    sideViewIC_L = intersect3planes(cross(Xl(i, 13:15)-Xl(i, 1:3),Xl(i, 13:15)-Xl(i, 4:6)),Xl(i, 13:15),cross(Xl(i, 16:18)-Xl(i, 7:9),Xl(i, 16:18)-Xl(i, 10:12)),Xl(i, 16:18),[0 1 0],contactPatch_L);
    sideViewIC_R = intersect3planes(cross(Xr(i, 13:15)-Xr(i, 1:3),Xr(i, 13:15)-Xr(i, 4:6)),Xr(i, 13:15),cross(Xr(i, 16:18)-Xr(i, 7:9),Xr(i, 16:18)-Xr(i, 10:12)),Xr(i, 16:18),[0 1 0],contactPatch_R);
    
    [rollAxis, rollAxisPoint] = intersect2planes(cross(frontViewIC_L-contactPatch_L,sideViewIC_L-contactPatch_L),contactPatch_L,cross(frontViewIC_R-contactPatch_R,sideViewIC_R-contactPatch_R),contactPatch_R);
    if rollAxis(1) > 0
        rollAxis = -rollAxis; %ensure that roll occurs always in the same direction
    end
    i = i+1;
    
    % Rotate points fixed to chassis
    Xl(i,1:3) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xl(i-1, 1:3));
    Xl(i,4:6) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xl(i-1, 4:6));
    Xl(i,7:9) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xl(i-1, 7:9));
    Xl(i,10:12) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xl(i-1, 10:12));
    Xl(i,19:21) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xl(i-1, 19:21));
    Xl(i,13:15) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xl(i-1, 13:15));
    Xr(i,1:3) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xr(i-1, 1:3));
    Xr(i,4:6) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xr(i-1, 4:6));
    Xr(i,7:9) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xr(i-1, 7:9));
    Xr(i,10:12) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xr(i-1, 10:12));
    Xr(i,19:21) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xr(i-1, 19:21));
    Xr(i,13:15) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xr(i-1, 13:15));
    if length(X) == 45
        Xl(i,37:39) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xl(i-1, 37:39));
        Xl(i,43:45) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xl(i-1, 43:45));
        Xr(i,37:39) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xr(i-1, 37:39));
        Xr(i,43:45) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xr(i-1, 43:45));
        bellcrankPlane_l(i,1:3) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xl(i-1, 37:39)+Bellcrank_Plane_L) - Xl(i,37:39);
        bellcrankPlane_r(i,1:3) = rotatePointFixedAxis(resolution, rollAxis, rollAxisPoint, Xr(i-1, 37:39)+Bellcrank_Plane_R) - Xr(i,37:39);
    end
    
end

Xl(end,:) = [];
Xr(end,:) = [];
rollAngle = [-fliplr(rollAngle) 0 rollAngle]';
Xl = [flipud(Xr.*sym) ; X; Xl];
Xr = flipud(Xl.*sym)';
Xl = Xl';
wheelTravel = [flip(cumsum(wheelTravel_r)) 0 cumsum(wheelTravel_l)];
end

