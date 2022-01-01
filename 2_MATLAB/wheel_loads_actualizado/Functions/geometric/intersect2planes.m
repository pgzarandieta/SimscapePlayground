function [t,T] = intersect2planes(n1,P1,n2,P2)
%intersect2planes computes the intersection of two planes (if any)
% Inputs: 
%       n1: normal vector to Plane 1
%       P1: any point that belongs to Plane 1
%       n2: normal vector to Plane 2
%       P2: any point that belongs to Plane 2
%
%Outputs:
%   T    is a point that lies on the intersection straight line.
%   t    is the direction vector of the straight line
% check is an integer (0:Plane 1 and Plane 2 are parallel' 
%                      1:Plane 1 and Plane 2 coincide
%                      2:Plane 1 and Plane 2 intersect)
%
T=[0 0 0];
n1 = n1./norm(n1);
n2 = n2./norm(n2);
t = cross(n1,n2);

%  test if the two planes are parallel
             

if cross(n1,n2) == 0         
    disp('planes are coincident or parallel');                    
    return
end
 
% Plane 1 and Plane 2 intersect in a line
%first determine max abs coordinate of cross product
maxc=find(abs(t)==max(abs(t)));


%next, to get a point on the intersection line and
%zero the max coord, and solve for the other two
      
d1 = -dot(n1,P1);   %the constants in the Plane 1 equations
d2 = -dot(n2, P2);  %the constants in the Plane 2 equations

switch maxc
    case 1                   % intersect with x=0
        T(1)= 0;
        T(2) = (d2*n1(3) - d1*n2(3))/ t(1);
        T(3) = (d1*n2(2) - d2*n1(2))/ t(1);
    case 2                    %intersect with y=0
        T(1) = (d1*n2(3) - d2*n1(3))/ t(2);
        T(2) = 0;
        T(3) = (d2*n1(1) - d1*n2(1))/ t(2);
    case 3                    %intersect with z=0
        T(1) = (d2*n1(2) - d1*n2(2))/ t(3);
        T(2) = (d1*n2(1) - d2*n1(1))/ t(3);
        T(3) = 0;
end
end

