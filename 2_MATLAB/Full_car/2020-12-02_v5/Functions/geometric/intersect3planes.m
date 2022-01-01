function intersectionPoint = intersect3planes(n1,P1,n2,P2,n3,P3)
intersectionPoint = [0 0 0];
n1 = n1./norm(n1);
n2 = n2./norm(n2);
t = cross(n1,n2);

maxc = find(abs(t)==max(abs(t)));
    
d1 = -dot(n1,P1);
d2 = -dot(n2, P2);
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

intersectionPoint(1) = T(1)+((P3(1)*n3(1)+P3(2)*n3(2)+P3(3)*n3(3))-(n3(1)*T(1)+n3(2)*T(2)+n3(3)*T(3)))/(n3(1)*t(1)+n3(2)*t(2)+n3(3)*t(3))*t(1);
intersectionPoint(2) = T(2)+((P3(1)*n3(1)+P3(2)*n3(2)+P3(3)*n3(3))-(n3(1)*T(1)+n3(2)*T(2)+n3(3)*T(3)))/(n3(1)*t(1)+n3(2)*t(2)+n3(3)*t(3))*t(2);
intersectionPoint(3) = T(3)+((P3(1)*n3(1)+P3(2)*n3(2)+P3(3)*n3(3))-(n3(1)*T(1)+n3(2)*T(2)+n3(3)*T(3)))/(n3(1)*t(1)+n3(2)*t(2)+n3(3)*t(3))*t(3);

end

