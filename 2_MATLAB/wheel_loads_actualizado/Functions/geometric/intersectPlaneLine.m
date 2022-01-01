function [intersectionPoint] = intersectPlaneLine(n,P,t,T)
%This function calculates the intersection between:
%   Plane: with normal vector n, and containing point P
%   Line: with direction (vector) t, and containg point T

intersectionPoint(1) = T(1)+((P(1)*n(1)+P(2)*n(2)+P(3)*n(3))-(n(1)*T(1)+n(2)*T(2)+n(3)*T(3)))/(n(1)*t(1)+n(2)*t(2)+n(3)*t(3))*t(1);
intersectionPoint(2) = T(2)+((P(1)*n(1)+P(2)*n(2)+P(3)*n(3))-(n(1)*T(1)+n(2)*T(2)+n(3)*T(3)))/(n(1)*t(1)+n(2)*t(2)+n(3)*t(3))*t(2);
intersectionPoint(3) = T(3)+((P(1)*n(1)+P(2)*n(2)+P(3)*n(3))-(n(1)*T(1)+n(2)*T(2)+n(3)*T(3)))/(n(1)*t(1)+n(2)*t(2)+n(3)*t(3))*t(3);

end