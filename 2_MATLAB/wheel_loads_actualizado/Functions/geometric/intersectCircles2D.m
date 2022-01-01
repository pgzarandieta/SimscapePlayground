function [intersectionPoint1, intersectionPoint2] = intersectCircles2D(Ca,Ra,Cb,Rb)
%Intersection of two circles in 2D space, with centers Ca and Cb and
%radius Ra and Rb, respectively.

intersectionPoint1(2) = (-((2*Cb(1)*(2*(Cb(2)-Ca(2))))/(2*(Cb(1)-Ca(1))) - 2*(((Ra^2-Rb^2)-(Ca(1)^2-Cb(1)^2)-(Ca(2)^2-Cb(2)^2))*(2*(Cb(2)-Ca(2))))/((2*(Cb(1)-Ca(1)))^2) - 2*Cb(2))+sqrt(((2*Cb(1)*(2*(Cb(2)-Ca(2))))/(2*(Cb(1)-Ca(1))) - 2*(((Ra^2-Rb^2)-(Ca(1)^2-Cb(1)^2)-(Ca(2)^2-Cb(2)^2))*(2*(Cb(2)-Ca(2))))/((2*(Cb(1)-Ca(1)))^2) - 2*Cb(2))^2-4*(((2*(Cb(2)-Ca(2)))^2/(2*(Cb(1)-Ca(1)))^2+1))*(((Ra^2-Rb^2)-(Ca(1)^2-Cb(1)^2)-(Ca(2)^2-Cb(2)^2))^2/(2*(Cb(1)-Ca(1)))^2 - 2*Cb(1)*((Ra^2-Rb^2)-(Ca(1)^2-Cb(1)^2)-(Ca(2)^2-Cb(2)^2))/(2*(Cb(1)-Ca(1))) - (Rb^2-Cb(1)^2-Cb(2)^2))))/(2*(((2*(Cb(2)-Ca(2)))^2/(2*(Cb(1)-Ca(1)))^2+1)));
intersectionPoint2(2) = (-((2*Cb(1)*(2*(Cb(2)-Ca(2))))/(2*(Cb(1)-Ca(1))) - 2*(((Ra^2-Rb^2)-(Ca(1)^2-Cb(1)^2)-(Ca(2)^2-Cb(2)^2))*(2*(Cb(2)-Ca(2))))/((2*(Cb(1)-Ca(1)))^2) - 2*Cb(2))-sqrt(((2*Cb(1)*(2*(Cb(2)-Ca(2))))/(2*(Cb(1)-Ca(1))) - 2*(((Ra^2-Rb^2)-(Ca(1)^2-Cb(1)^2)-(Ca(2)^2-Cb(2)^2))*(2*(Cb(2)-Ca(2))))/((2*(Cb(1)-Ca(1)))^2) - 2*Cb(2))^2-4*(((2*(Cb(2)-Ca(2)))^2/(2*(Cb(1)-Ca(1)))^2+1))*(((Ra^2-Rb^2)-(Ca(1)^2-Cb(1)^2)-(Ca(2)^2-Cb(2)^2))^2/(2*(Cb(1)-Ca(1)))^2 - 2*Cb(1)*((Ra^2-Rb^2)-(Ca(1)^2-Cb(1)^2)-(Ca(2)^2-Cb(2)^2))/(2*(Cb(1)-Ca(1))) - (Rb^2-Cb(1)^2-Cb(2)^2))))/(2*(((2*(Cb(2)-Ca(2)))^2/(2*(Cb(1)-Ca(1)))^2+1)));
intersectionPoint1(1) = (((Ra^2-Rb^2)-(Ca(1)^2-Cb(1)^2)-(Ca(2)^2-Cb(2)^2))-(2*(Cb(2)-Ca(2)))*intersectionPoint1(2))/(2*(Cb(1)-Ca(1)));
intersectionPoint2(1) = (((Ra^2-Rb^2)-(Ca(1)^2-Cb(1)^2)-(Ca(2)^2-Cb(2)^2))-(2*(Cb(2)-Ca(2)))*intersectionPoint2(2))/(2*(Cb(1)-Ca(1))); 
end

