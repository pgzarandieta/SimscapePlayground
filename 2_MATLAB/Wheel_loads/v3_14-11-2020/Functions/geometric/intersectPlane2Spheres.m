function [intersectionPoint1,intersectionPoint2] = intersectPlane2Spheres(pa,na,Ca,Ra,Cb,Rb)
%Intersection between circle and sphere in 3D space:
%   -Circle: center Ca, radius Ra, contained in plane defined by point pa
%   and normal vecto na.
%   -Sphere: center Cb and radius Rb

[u,v] = findVectorsInPlane(na);

kA = Ra^2 - (Ca(1)^2+Ca(2)^2+Ca(3)^2);
kB = Rb^2 - (Cb(1)^2+Cb(2)^2+Cb(3)^2);
kab2 = (kA-kB)/2;
kalpha = ((Cb(1)-Ca(1))*u(1)+(Cb(2)-Ca(2))*u(2)+(Cb(3)-Ca(3))*u(3));
kbeta = ((Cb(1)-Ca(1))*v(1)+(Cb(2)-Ca(2))*v(2)+(Cb(3)-Ca(3))*v(3));
k0 = ((Cb(1)-Ca(1))*pa(1)+(Cb(2)-Ca(2))*pa(2)+(Cb(3)-Ca(3))*pa(3));

beta1 = (kalpha*(- k0^2*u(1)^2*v(2)^2 - k0^2*u(1)^2*v(3)^2 + 2*k0^2*u(1)*u(2)*v(1)*v(2) + 2*k0^2*u(1)*u(3)*v(1)*v(3) - k0^2*u(2)^2*v(1)^2 - k0^2*u(2)^2*v(3)^2 + 2*k0^2*u(2)*u(3)*v(2)*v(3) - k0^2*u(3)^2*v(1)^2 - k0^2*u(3)^2*v(2)^2 + 2*k0*kab2*u(1)^2*v(2)^2 + 2*k0*kab2*u(1)^2*v(3)^2 - 4*k0*kab2*u(1)*u(2)*v(1)*v(2) - 4*k0*kab2*u(1)*u(3)*v(1)*v(3) + 2*k0*kab2*u(2)^2*v(1)^2 + 2*k0*kab2*u(2)^2*v(3)^2 - 4*k0*kab2*u(2)*u(3)*v(2)*v(3) + 2*k0*kab2*u(3)^2*v(1)^2 + 2*k0*kab2*u(3)^2*v(2)^2 - 2*k0*kalpha*u(1)*v(1)*v(2)*pa(2) + 2*k0*kalpha*u(1)*v(1)*v(2)*Ca(2) - 2*k0*kalpha*u(1)*v(1)*v(3)*pa(3) + 2*k0*kalpha*u(1)*v(1)*v(3)*Ca(3) + 2*k0*kalpha*u(1)*v(2)^2*pa(1) - 2*k0*kalpha*u(1)*v(2)^2*Ca(1) + 2*k0*kalpha*u(1)*v(3)^2*pa(1) - 2*k0*kalpha*u(1)*v(3)^2*Ca(1) + 2*k0*kalpha*u(2)*v(1)^2*pa(2) - 2*k0*kalpha*u(2)*v(1)^2*Ca(2) - 2*k0*kalpha*u(2)*v(1)*v(2)*pa(1) + 2*k0*kalpha*u(2)*v(1)*v(2)*Ca(1) - 2*k0*kalpha*u(2)*v(2)*v(3)*pa(3) + 2*k0*kalpha*u(2)*v(2)*v(3)*Ca(3) + 2*k0*kalpha*u(2)*v(3)^2*pa(2) - 2*k0*kalpha*u(2)*v(3)^2*Ca(2) + 2*k0*kalpha*u(3)*v(1)^2*pa(3) - 2*k0*kalpha*u(3)*v(1)^2*Ca(3) - 2*k0*kalpha*u(3)*v(1)*v(3)*pa(1) + 2*k0*kalpha*u(3)*v(1)*v(3)*Ca(1) + 2*k0*kalpha*u(3)*v(2)^2*pa(3) - 2*k0*kalpha*u(3)*v(2)^2*Ca(3) - 2*k0*kalpha*u(3)*v(2)*v(3)*pa(2) + 2*k0*kalpha*u(3)*v(2)*v(3)*Ca(2) + 2*k0*kbeta*u(1)^2*v(2)*pa(2) - 2*k0*kbeta*u(1)^2*v(2)*Ca(2) + 2*k0*kbeta*u(1)^2*v(3)*pa(3) - 2*k0*kbeta*u(1)^2*v(3)*Ca(3) - 2*k0*kbeta*u(1)*u(2)*v(1)*pa(2) + 2*k0*kbeta*u(1)*u(2)*v(1)*Ca(2) - 2*k0*kbeta*u(1)*u(2)*v(2)*pa(1) + 2*k0*kbeta*u(1)*u(2)*v(2)*Ca(1) - 2*k0*kbeta*u(1)*u(3)*v(1)*pa(3) + 2*k0*kbeta*u(1)*u(3)*v(1)*Ca(3) - 2*k0*kbeta*u(1)*u(3)*v(3)*pa(1) + 2*k0*kbeta*u(1)*u(3)*v(3)*Ca(1) + 2*k0*kbeta*u(2)^2*v(1)*pa(1) - 2*k0*kbeta*u(2)^2*v(1)*Ca(1) + 2*k0*kbeta*u(2)^2*v(3)*pa(3) - 2*k0*kbeta*u(2)^2*v(3)*Ca(3) - 2*k0*kbeta*u(2)*u(3)*v(2)*pa(3) + 2*k0*kbeta*u(2)*u(3)*v(2)*Ca(3) - 2*k0*kbeta*u(2)*u(3)*v(3)*pa(2) + 2*k0*kbeta*u(2)*u(3)*v(3)*Ca(2) + 2*k0*kbeta*u(3)^2*v(1)*pa(1) - 2*k0*kbeta*u(3)^2*v(1)*Ca(1) + 2*k0*kbeta*u(3)^2*v(2)*pa(2) - 2*k0*kbeta*u(3)^2*v(2)*Ca(2) - kab2^2*u(1)^2*v(2)^2 - kab2^2*u(1)^2*v(3)^2 + 2*kab2^2*u(1)*u(2)*v(1)*v(2) + 2*kab2^2*u(1)*u(3)*v(1)*v(3) - kab2^2*u(2)^2*v(1)^2 - kab2^2*u(2)^2*v(3)^2 + 2*kab2^2*u(2)*u(3)*v(2)*v(3) - kab2^2*u(3)^2*v(1)^2 - kab2^2*u(3)^2*v(2)^2 + 2*kab2*kalpha*u(1)*v(1)*v(2)*pa(2) - 2*kab2*kalpha*u(1)*v(1)*v(2)*Ca(2) + 2*kab2*kalpha*u(1)*v(1)*v(3)*pa(3) - 2*kab2*kalpha*u(1)*v(1)*v(3)*Ca(3) - 2*kab2*kalpha*u(1)*v(2)^2*pa(1) + 2*kab2*kalpha*u(1)*v(2)^2*Ca(1) - 2*kab2*kalpha*u(1)*v(3)^2*pa(1) + 2*kab2*kalpha*u(1)*v(3)^2*Ca(1) - 2*kab2*kalpha*u(2)*v(1)^2*pa(2) + 2*kab2*kalpha*u(2)*v(1)^2*Ca(2) + 2*kab2*kalpha*u(2)*v(1)*v(2)*pa(1) - 2*kab2*kalpha*u(2)*v(1)*v(2)*Ca(1) + 2*kab2*kalpha*u(2)*v(2)*v(3)*pa(3) - 2*kab2*kalpha*u(2)*v(2)*v(3)*Ca(3) - 2*kab2*kalpha*u(2)*v(3)^2*pa(2) + 2*kab2*kalpha*u(2)*v(3)^2*Ca(2) - 2*kab2*kalpha*u(3)*v(1)^2*pa(3) + 2*kab2*kalpha*u(3)*v(1)^2*Ca(3) + 2*kab2*kalpha*u(3)*v(1)*v(3)*pa(1) - 2*kab2*kalpha*u(3)*v(1)*v(3)*Ca(1) - 2*kab2*kalpha*u(3)*v(2)^2*pa(3) + 2*kab2*kalpha*u(3)*v(2)^2*Ca(3) + 2*kab2*kalpha*u(3)*v(2)*v(3)*pa(2) - 2*kab2*kalpha*u(3)*v(2)*v(3)*Ca(2) - 2*kab2*kbeta*u(1)^2*v(2)*pa(2) + 2*kab2*kbeta*u(1)^2*v(2)*Ca(2) - 2*kab2*kbeta*u(1)^2*v(3)*pa(3) + 2*kab2*kbeta*u(1)^2*v(3)*Ca(3) + 2*kab2*kbeta*u(1)*u(2)*v(1)*pa(2) - 2*kab2*kbeta*u(1)*u(2)*v(1)*Ca(2) + 2*kab2*kbeta*u(1)*u(2)*v(2)*pa(1) - 2*kab2*kbeta*u(1)*u(2)*v(2)*Ca(1) + 2*kab2*kbeta*u(1)*u(3)*v(1)*pa(3) - 2*kab2*kbeta*u(1)*u(3)*v(1)*Ca(3) + 2*kab2*kbeta*u(1)*u(3)*v(3)*pa(1) - 2*kab2*kbeta*u(1)*u(3)*v(3)*Ca(1) - 2*kab2*kbeta*u(2)^2*v(1)*pa(1) + 2*kab2*kbeta*u(2)^2*v(1)*Ca(1) - 2*kab2*kbeta*u(2)^2*v(3)*pa(3) + 2*kab2*kbeta*u(2)^2*v(3)*Ca(3) + 2*kab2*kbeta*u(2)*u(3)*v(2)*pa(3) - 2*kab2*kbeta*u(2)*u(3)*v(2)*Ca(3) + 2*kab2*kbeta*u(2)*u(3)*v(3)*pa(2) - 2*kab2*kbeta*u(2)*u(3)*v(3)*Ca(2) - 2*kab2*kbeta*u(3)^2*v(1)*pa(1) + 2*kab2*kbeta*u(3)^2*v(1)*Ca(1) - 2*kab2*kbeta*u(3)^2*v(2)*pa(2) + 2*kab2*kbeta*u(3)^2*v(2)*Ca(2) + kalpha^2*v(1)^2*Ca(1)^2 - kalpha^2*v(1)^2*pa(2)^2 + 2*kalpha^2*v(1)^2*pa(2)*Ca(2) - kalpha^2*v(1)^2*pa(3)^2 + 2*kalpha^2*v(1)^2*pa(3)*Ca(3) + kA*kalpha^2*v(1)^2 + 2*kalpha^2*v(1)*v(2)*pa(1)*pa(2) - 2*kalpha^2*v(1)*v(2)*pa(1)*Ca(2) - 2*kalpha^2*v(1)*v(2)*Ca(1)*pa(2) + 2*kalpha^2*v(1)*v(2)*Ca(1)*Ca(2) + 2*kalpha^2*v(1)*v(3)*pa(1)*pa(3) - 2*kalpha^2*v(1)*v(3)*pa(1)*Ca(3) - 2*kalpha^2*v(1)*v(3)*Ca(1)*pa(3) + 2*kalpha^2*v(1)*v(3)*Ca(1)*Ca(3) - kalpha^2*v(2)^2*pa(1)^2 + 2*kalpha^2*v(2)^2*pa(1)*Ca(1) + kalpha^2*v(2)^2*Ca(2)^2 - kalpha^2*v(2)^2*pa(3)^2 + 2*kalpha^2*v(2)^2*pa(3)*Ca(3) + kA*kalpha^2*v(2)^2 + 2*kalpha^2*v(2)*v(3)*pa(2)*pa(3) - 2*kalpha^2*v(2)*v(3)*pa(2)*Ca(3) - 2*kalpha^2*v(2)*v(3)*Ca(2)*pa(3) + 2*kalpha^2*v(2)*v(3)*Ca(2)*Ca(3) - kalpha^2*v(3)^2*pa(1)^2 + 2*kalpha^2*v(3)^2*pa(1)*Ca(1) - kalpha^2*v(3)^2*pa(2)^2 + 2*kalpha^2*v(3)^2*pa(2)*Ca(2) + kalpha^2*v(3)^2*Ca(3)^2 + kA*kalpha^2*v(3)^2 - 2*kalpha*kbeta*u(1)*v(1)*Ca(1)^2 + 2*kalpha*kbeta*u(1)*v(1)*pa(2)^2 - 4*kalpha*kbeta*u(1)*v(1)*pa(2)*Ca(2) + 2*kalpha*kbeta*u(1)*v(1)*pa(3)^2 - 4*kalpha*kbeta*u(1)*v(1)*pa(3)*Ca(3) - 2*kA*kalpha*kbeta*u(1)*v(1) - 2*kalpha*kbeta*u(1)*v(2)*pa(1)*pa(2) + 2*kalpha*kbeta*u(1)*v(2)*pa(1)*Ca(2) + 2*kalpha*kbeta*u(1)*v(2)*Ca(1)*pa(2) - 2*kalpha*kbeta*u(1)*v(2)*Ca(1)*Ca(2) - 2*kalpha*kbeta*u(1)*v(3)*pa(1)*pa(3) + 2*kalpha*kbeta*u(1)*v(3)*pa(1)*Ca(3) + 2*kalpha*kbeta*u(1)*v(3)*Ca(1)*pa(3) - 2*kalpha*kbeta*u(1)*v(3)*Ca(1)*Ca(3) - 2*kalpha*kbeta*u(2)*v(1)*pa(1)*pa(2) + 2*kalpha*kbeta*u(2)*v(1)*pa(1)*Ca(2) + 2*kalpha*kbeta*u(2)*v(1)*Ca(1)*pa(2) - 2*kalpha*kbeta*u(2)*v(1)*Ca(1)*Ca(2) + 2*kalpha*kbeta*u(2)*v(2)*pa(1)^2 - 4*kalpha*kbeta*u(2)*v(2)*pa(1)*Ca(1) - 2*kalpha*kbeta*u(2)*v(2)*Ca(2)^2 + 2*kalpha*kbeta*u(2)*v(2)*pa(3)^2 - 4*kalpha*kbeta*u(2)*v(2)*pa(3)*Ca(3) - 2*kA*kalpha*kbeta*u(2)*v(2) - 2*kalpha*kbeta*u(2)*v(3)*pa(2)*pa(3) + 2*kalpha*kbeta*u(2)*v(3)*pa(2)*Ca(3) + 2*kalpha*kbeta*u(2)*v(3)*Ca(2)*pa(3) - 2*kalpha*kbeta*u(2)*v(3)*Ca(2)*Ca(3) - 2*kalpha*kbeta*u(3)*v(1)*pa(1)*pa(3) + 2*kalpha*kbeta*u(3)*v(1)*pa(1)*Ca(3) + 2*kalpha*kbeta*u(3)*v(1)*Ca(1)*pa(3) - 2*kalpha*kbeta*u(3)*v(1)*Ca(1)*Ca(3) - 2*kalpha*kbeta*u(3)*v(2)*pa(2)*pa(3) + 2*kalpha*kbeta*u(3)*v(2)*pa(2)*Ca(3) + 2*kalpha*kbeta*u(3)*v(2)*Ca(2)*pa(3) - 2*kalpha*kbeta*u(3)*v(2)*Ca(2)*Ca(3) + 2*kalpha*kbeta*u(3)*v(3)*pa(1)^2 - 4*kalpha*kbeta*u(3)*v(3)*pa(1)*Ca(1) + 2*kalpha*kbeta*u(3)*v(3)*pa(2)^2 - 4*kalpha*kbeta*u(3)*v(3)*pa(2)*Ca(2) - 2*kalpha*kbeta*u(3)*v(3)*Ca(3)^2 - 2*kA*kalpha*kbeta*u(3)*v(3) + kbeta^2*u(1)^2*Ca(1)^2 - kbeta^2*u(1)^2*pa(2)^2 + 2*kbeta^2*u(1)^2*pa(2)*Ca(2) - kbeta^2*u(1)^2*pa(3)^2 + 2*kbeta^2*u(1)^2*pa(3)*Ca(3) + kA*kbeta^2*u(1)^2 + 2*kbeta^2*u(1)*u(2)*pa(1)*pa(2) - 2*kbeta^2*u(1)*u(2)*pa(1)*Ca(2) - 2*kbeta^2*u(1)*u(2)*Ca(1)*pa(2) + 2*kbeta^2*u(1)*u(2)*Ca(1)*Ca(2) + 2*kbeta^2*u(1)*u(3)*pa(1)*pa(3) - 2*kbeta^2*u(1)*u(3)*pa(1)*Ca(3) - 2*kbeta^2*u(1)*u(3)*Ca(1)*pa(3) + 2*kbeta^2*u(1)*u(3)*Ca(1)*Ca(3) - kbeta^2*u(2)^2*pa(1)^2 + 2*kbeta^2*u(2)^2*pa(1)*Ca(1) + kbeta^2*u(2)^2*Ca(2)^2 - kbeta^2*u(2)^2*pa(3)^2 + 2*kbeta^2*u(2)^2*pa(3)*Ca(3) + kA*kbeta^2*u(2)^2 + 2*kbeta^2*u(2)*u(3)*pa(2)*pa(3) - 2*kbeta^2*u(2)*u(3)*pa(2)*Ca(3) - 2*kbeta^2*u(2)*u(3)*Ca(2)*pa(3) + 2*kbeta^2*u(2)*u(3)*Ca(2)*Ca(3) - kbeta^2*u(3)^2*pa(1)^2 + 2*kbeta^2*u(3)^2*pa(1)*Ca(1) - kbeta^2*u(3)^2*pa(2)^2 + 2*kbeta^2*u(3)^2*pa(2)*Ca(2) + kbeta^2*u(3)^2*Ca(3)^2 + kA*kbeta^2*u(3)^2)^(1/2) - k0*kbeta*u(1)^2 - k0*kbeta*u(2)^2 - k0*kbeta*u(3)^2 + kab2*kbeta*u(1)^2 + kab2*kbeta*u(2)^2 + kab2*kbeta*u(3)^2 - kalpha^2*v(1)*pa(1) + kalpha^2*v(1)*Ca(1) - kalpha^2*v(2)*pa(2) + kalpha^2*v(2)*Ca(2) - kalpha^2*v(3)*pa(3) + kalpha^2*v(3)*Ca(3) + k0*kalpha*u(1)*v(1) + k0*kalpha*u(2)*v(2) + k0*kalpha*u(3)*v(3) - kab2*kalpha*u(1)*v(1) - kab2*kalpha*u(2)*v(2) - kab2*kalpha*u(3)*v(3) + kalpha*kbeta*u(1)*pa(1) - kalpha*kbeta*u(1)*Ca(1) + kalpha*kbeta*u(2)*pa(2) - kalpha*kbeta*u(2)*Ca(2) + kalpha*kbeta*u(3)*pa(3) - kalpha*kbeta*u(3)*Ca(3))/(kalpha^2*v(1)^2 + kalpha^2*v(2)^2 + kalpha^2*v(3)^2 - 2*kalpha*kbeta*u(1)*v(1) - 2*kalpha*kbeta*u(2)*v(2) - 2*kalpha*kbeta*u(3)*v(3) + kbeta^2*u(1)^2 + kbeta^2*u(2)^2 + kbeta^2*u(3)^2);
beta2 = -(kalpha*(- k0^2*u(1)^2*v(2)^2 - k0^2*u(1)^2*v(3)^2 + 2*k0^2*u(1)*u(2)*v(1)*v(2) + 2*k0^2*u(1)*u(3)*v(1)*v(3) - k0^2*u(2)^2*v(1)^2 - k0^2*u(2)^2*v(3)^2 + 2*k0^2*u(2)*u(3)*v(2)*v(3) - k0^2*u(3)^2*v(1)^2 - k0^2*u(3)^2*v(2)^2 + 2*k0*kab2*u(1)^2*v(2)^2 + 2*k0*kab2*u(1)^2*v(3)^2 - 4*k0*kab2*u(1)*u(2)*v(1)*v(2) - 4*k0*kab2*u(1)*u(3)*v(1)*v(3) + 2*k0*kab2*u(2)^2*v(1)^2 + 2*k0*kab2*u(2)^2*v(3)^2 - 4*k0*kab2*u(2)*u(3)*v(2)*v(3) + 2*k0*kab2*u(3)^2*v(1)^2 + 2*k0*kab2*u(3)^2*v(2)^2 - 2*k0*kalpha*u(1)*v(1)*v(2)*pa(2) + 2*k0*kalpha*u(1)*v(1)*v(2)*Ca(2) - 2*k0*kalpha*u(1)*v(1)*v(3)*pa(3) + 2*k0*kalpha*u(1)*v(1)*v(3)*Ca(3) + 2*k0*kalpha*u(1)*v(2)^2*pa(1) - 2*k0*kalpha*u(1)*v(2)^2*Ca(1) + 2*k0*kalpha*u(1)*v(3)^2*pa(1) - 2*k0*kalpha*u(1)*v(3)^2*Ca(1) + 2*k0*kalpha*u(2)*v(1)^2*pa(2) - 2*k0*kalpha*u(2)*v(1)^2*Ca(2) - 2*k0*kalpha*u(2)*v(1)*v(2)*pa(1) + 2*k0*kalpha*u(2)*v(1)*v(2)*Ca(1) - 2*k0*kalpha*u(2)*v(2)*v(3)*pa(3) + 2*k0*kalpha*u(2)*v(2)*v(3)*Ca(3) + 2*k0*kalpha*u(2)*v(3)^2*pa(2) - 2*k0*kalpha*u(2)*v(3)^2*Ca(2) + 2*k0*kalpha*u(3)*v(1)^2*pa(3) - 2*k0*kalpha*u(3)*v(1)^2*Ca(3) - 2*k0*kalpha*u(3)*v(1)*v(3)*pa(1) + 2*k0*kalpha*u(3)*v(1)*v(3)*Ca(1) + 2*k0*kalpha*u(3)*v(2)^2*pa(3) - 2*k0*kalpha*u(3)*v(2)^2*Ca(3) - 2*k0*kalpha*u(3)*v(2)*v(3)*pa(2) + 2*k0*kalpha*u(3)*v(2)*v(3)*Ca(2) + 2*k0*kbeta*u(1)^2*v(2)*pa(2) - 2*k0*kbeta*u(1)^2*v(2)*Ca(2) + 2*k0*kbeta*u(1)^2*v(3)*pa(3) - 2*k0*kbeta*u(1)^2*v(3)*Ca(3) - 2*k0*kbeta*u(1)*u(2)*v(1)*pa(2) + 2*k0*kbeta*u(1)*u(2)*v(1)*Ca(2) - 2*k0*kbeta*u(1)*u(2)*v(2)*pa(1) + 2*k0*kbeta*u(1)*u(2)*v(2)*Ca(1) - 2*k0*kbeta*u(1)*u(3)*v(1)*pa(3) + 2*k0*kbeta*u(1)*u(3)*v(1)*Ca(3) - 2*k0*kbeta*u(1)*u(3)*v(3)*pa(1) + 2*k0*kbeta*u(1)*u(3)*v(3)*Ca(1) + 2*k0*kbeta*u(2)^2*v(1)*pa(1) - 2*k0*kbeta*u(2)^2*v(1)*Ca(1) + 2*k0*kbeta*u(2)^2*v(3)*pa(3) - 2*k0*kbeta*u(2)^2*v(3)*Ca(3) - 2*k0*kbeta*u(2)*u(3)*v(2)*pa(3) + 2*k0*kbeta*u(2)*u(3)*v(2)*Ca(3) - 2*k0*kbeta*u(2)*u(3)*v(3)*pa(2) + 2*k0*kbeta*u(2)*u(3)*v(3)*Ca(2) + 2*k0*kbeta*u(3)^2*v(1)*pa(1) - 2*k0*kbeta*u(3)^2*v(1)*Ca(1) + 2*k0*kbeta*u(3)^2*v(2)*pa(2) - 2*k0*kbeta*u(3)^2*v(2)*Ca(2) - kab2^2*u(1)^2*v(2)^2 - kab2^2*u(1)^2*v(3)^2 + 2*kab2^2*u(1)*u(2)*v(1)*v(2) + 2*kab2^2*u(1)*u(3)*v(1)*v(3) - kab2^2*u(2)^2*v(1)^2 - kab2^2*u(2)^2*v(3)^2 + 2*kab2^2*u(2)*u(3)*v(2)*v(3) - kab2^2*u(3)^2*v(1)^2 - kab2^2*u(3)^2*v(2)^2 + 2*kab2*kalpha*u(1)*v(1)*v(2)*pa(2) - 2*kab2*kalpha*u(1)*v(1)*v(2)*Ca(2) + 2*kab2*kalpha*u(1)*v(1)*v(3)*pa(3) - 2*kab2*kalpha*u(1)*v(1)*v(3)*Ca(3) - 2*kab2*kalpha*u(1)*v(2)^2*pa(1) + 2*kab2*kalpha*u(1)*v(2)^2*Ca(1) - 2*kab2*kalpha*u(1)*v(3)^2*pa(1) + 2*kab2*kalpha*u(1)*v(3)^2*Ca(1) - 2*kab2*kalpha*u(2)*v(1)^2*pa(2) + 2*kab2*kalpha*u(2)*v(1)^2*Ca(2) + 2*kab2*kalpha*u(2)*v(1)*v(2)*pa(1) - 2*kab2*kalpha*u(2)*v(1)*v(2)*Ca(1) + 2*kab2*kalpha*u(2)*v(2)*v(3)*pa(3) - 2*kab2*kalpha*u(2)*v(2)*v(3)*Ca(3) - 2*kab2*kalpha*u(2)*v(3)^2*pa(2) + 2*kab2*kalpha*u(2)*v(3)^2*Ca(2) - 2*kab2*kalpha*u(3)*v(1)^2*pa(3) + 2*kab2*kalpha*u(3)*v(1)^2*Ca(3) + 2*kab2*kalpha*u(3)*v(1)*v(3)*pa(1) - 2*kab2*kalpha*u(3)*v(1)*v(3)*Ca(1) - 2*kab2*kalpha*u(3)*v(2)^2*pa(3) + 2*kab2*kalpha*u(3)*v(2)^2*Ca(3) + 2*kab2*kalpha*u(3)*v(2)*v(3)*pa(2) - 2*kab2*kalpha*u(3)*v(2)*v(3)*Ca(2) - 2*kab2*kbeta*u(1)^2*v(2)*pa(2) + 2*kab2*kbeta*u(1)^2*v(2)*Ca(2) - 2*kab2*kbeta*u(1)^2*v(3)*pa(3) + 2*kab2*kbeta*u(1)^2*v(3)*Ca(3) + 2*kab2*kbeta*u(1)*u(2)*v(1)*pa(2) - 2*kab2*kbeta*u(1)*u(2)*v(1)*Ca(2) + 2*kab2*kbeta*u(1)*u(2)*v(2)*pa(1) - 2*kab2*kbeta*u(1)*u(2)*v(2)*Ca(1) + 2*kab2*kbeta*u(1)*u(3)*v(1)*pa(3) - 2*kab2*kbeta*u(1)*u(3)*v(1)*Ca(3) + 2*kab2*kbeta*u(1)*u(3)*v(3)*pa(1) - 2*kab2*kbeta*u(1)*u(3)*v(3)*Ca(1) - 2*kab2*kbeta*u(2)^2*v(1)*pa(1) + 2*kab2*kbeta*u(2)^2*v(1)*Ca(1) - 2*kab2*kbeta*u(2)^2*v(3)*pa(3) + 2*kab2*kbeta*u(2)^2*v(3)*Ca(3) + 2*kab2*kbeta*u(2)*u(3)*v(2)*pa(3) - 2*kab2*kbeta*u(2)*u(3)*v(2)*Ca(3) + 2*kab2*kbeta*u(2)*u(3)*v(3)*pa(2) - 2*kab2*kbeta*u(2)*u(3)*v(3)*Ca(2) - 2*kab2*kbeta*u(3)^2*v(1)*pa(1) + 2*kab2*kbeta*u(3)^2*v(1)*Ca(1) - 2*kab2*kbeta*u(3)^2*v(2)*pa(2) + 2*kab2*kbeta*u(3)^2*v(2)*Ca(2) + kalpha^2*v(1)^2*Ca(1)^2 - kalpha^2*v(1)^2*pa(2)^2 + 2*kalpha^2*v(1)^2*pa(2)*Ca(2) - kalpha^2*v(1)^2*pa(3)^2 + 2*kalpha^2*v(1)^2*pa(3)*Ca(3) + kA*kalpha^2*v(1)^2 + 2*kalpha^2*v(1)*v(2)*pa(1)*pa(2) - 2*kalpha^2*v(1)*v(2)*pa(1)*Ca(2) - 2*kalpha^2*v(1)*v(2)*Ca(1)*pa(2) + 2*kalpha^2*v(1)*v(2)*Ca(1)*Ca(2) + 2*kalpha^2*v(1)*v(3)*pa(1)*pa(3) - 2*kalpha^2*v(1)*v(3)*pa(1)*Ca(3) - 2*kalpha^2*v(1)*v(3)*Ca(1)*pa(3) + 2*kalpha^2*v(1)*v(3)*Ca(1)*Ca(3) - kalpha^2*v(2)^2*pa(1)^2 + 2*kalpha^2*v(2)^2*pa(1)*Ca(1) + kalpha^2*v(2)^2*Ca(2)^2 - kalpha^2*v(2)^2*pa(3)^2 + 2*kalpha^2*v(2)^2*pa(3)*Ca(3) + kA*kalpha^2*v(2)^2 + 2*kalpha^2*v(2)*v(3)*pa(2)*pa(3) - 2*kalpha^2*v(2)*v(3)*pa(2)*Ca(3) - 2*kalpha^2*v(2)*v(3)*Ca(2)*pa(3) + 2*kalpha^2*v(2)*v(3)*Ca(2)*Ca(3) - kalpha^2*v(3)^2*pa(1)^2 + 2*kalpha^2*v(3)^2*pa(1)*Ca(1) - kalpha^2*v(3)^2*pa(2)^2 + 2*kalpha^2*v(3)^2*pa(2)*Ca(2) + kalpha^2*v(3)^2*Ca(3)^2 + kA*kalpha^2*v(3)^2 - 2*kalpha*kbeta*u(1)*v(1)*Ca(1)^2 + 2*kalpha*kbeta*u(1)*v(1)*pa(2)^2 - 4*kalpha*kbeta*u(1)*v(1)*pa(2)*Ca(2) + 2*kalpha*kbeta*u(1)*v(1)*pa(3)^2 - 4*kalpha*kbeta*u(1)*v(1)*pa(3)*Ca(3) - 2*kA*kalpha*kbeta*u(1)*v(1) - 2*kalpha*kbeta*u(1)*v(2)*pa(1)*pa(2) + 2*kalpha*kbeta*u(1)*v(2)*pa(1)*Ca(2) + 2*kalpha*kbeta*u(1)*v(2)*Ca(1)*pa(2) - 2*kalpha*kbeta*u(1)*v(2)*Ca(1)*Ca(2) - 2*kalpha*kbeta*u(1)*v(3)*pa(1)*pa(3) + 2*kalpha*kbeta*u(1)*v(3)*pa(1)*Ca(3) + 2*kalpha*kbeta*u(1)*v(3)*Ca(1)*pa(3) - 2*kalpha*kbeta*u(1)*v(3)*Ca(1)*Ca(3) - 2*kalpha*kbeta*u(2)*v(1)*pa(1)*pa(2) + 2*kalpha*kbeta*u(2)*v(1)*pa(1)*Ca(2) + 2*kalpha*kbeta*u(2)*v(1)*Ca(1)*pa(2) - 2*kalpha*kbeta*u(2)*v(1)*Ca(1)*Ca(2) + 2*kalpha*kbeta*u(2)*v(2)*pa(1)^2 - 4*kalpha*kbeta*u(2)*v(2)*pa(1)*Ca(1) - 2*kalpha*kbeta*u(2)*v(2)*Ca(2)^2 + 2*kalpha*kbeta*u(2)*v(2)*pa(3)^2 - 4*kalpha*kbeta*u(2)*v(2)*pa(3)*Ca(3) - 2*kA*kalpha*kbeta*u(2)*v(2) - 2*kalpha*kbeta*u(2)*v(3)*pa(2)*pa(3) + 2*kalpha*kbeta*u(2)*v(3)*pa(2)*Ca(3) + 2*kalpha*kbeta*u(2)*v(3)*Ca(2)*pa(3) - 2*kalpha*kbeta*u(2)*v(3)*Ca(2)*Ca(3) - 2*kalpha*kbeta*u(3)*v(1)*pa(1)*pa(3) + 2*kalpha*kbeta*u(3)*v(1)*pa(1)*Ca(3) + 2*kalpha*kbeta*u(3)*v(1)*Ca(1)*pa(3) - 2*kalpha*kbeta*u(3)*v(1)*Ca(1)*Ca(3) - 2*kalpha*kbeta*u(3)*v(2)*pa(2)*pa(3) + 2*kalpha*kbeta*u(3)*v(2)*pa(2)*Ca(3) + 2*kalpha*kbeta*u(3)*v(2)*Ca(2)*pa(3) - 2*kalpha*kbeta*u(3)*v(2)*Ca(2)*Ca(3) + 2*kalpha*kbeta*u(3)*v(3)*pa(1)^2 - 4*kalpha*kbeta*u(3)*v(3)*pa(1)*Ca(1) + 2*kalpha*kbeta*u(3)*v(3)*pa(2)^2 - 4*kalpha*kbeta*u(3)*v(3)*pa(2)*Ca(2) - 2*kalpha*kbeta*u(3)*v(3)*Ca(3)^2 - 2*kA*kalpha*kbeta*u(3)*v(3) + kbeta^2*u(1)^2*Ca(1)^2 - kbeta^2*u(1)^2*pa(2)^2 + 2*kbeta^2*u(1)^2*pa(2)*Ca(2) - kbeta^2*u(1)^2*pa(3)^2 + 2*kbeta^2*u(1)^2*pa(3)*Ca(3) + kA*kbeta^2*u(1)^2 + 2*kbeta^2*u(1)*u(2)*pa(1)*pa(2) - 2*kbeta^2*u(1)*u(2)*pa(1)*Ca(2) - 2*kbeta^2*u(1)*u(2)*Ca(1)*pa(2) + 2*kbeta^2*u(1)*u(2)*Ca(1)*Ca(2) + 2*kbeta^2*u(1)*u(3)*pa(1)*pa(3) - 2*kbeta^2*u(1)*u(3)*pa(1)*Ca(3) - 2*kbeta^2*u(1)*u(3)*Ca(1)*pa(3) + 2*kbeta^2*u(1)*u(3)*Ca(1)*Ca(3) - kbeta^2*u(2)^2*pa(1)^2 + 2*kbeta^2*u(2)^2*pa(1)*Ca(1) + kbeta^2*u(2)^2*Ca(2)^2 - kbeta^2*u(2)^2*pa(3)^2 + 2*kbeta^2*u(2)^2*pa(3)*Ca(3) + kA*kbeta^2*u(2)^2 + 2*kbeta^2*u(2)*u(3)*pa(2)*pa(3) - 2*kbeta^2*u(2)*u(3)*pa(2)*Ca(3) - 2*kbeta^2*u(2)*u(3)*Ca(2)*pa(3) + 2*kbeta^2*u(2)*u(3)*Ca(2)*Ca(3) - kbeta^2*u(3)^2*pa(1)^2 + 2*kbeta^2*u(3)^2*pa(1)*Ca(1) - kbeta^2*u(3)^2*pa(2)^2 + 2*kbeta^2*u(3)^2*pa(2)*Ca(2) + kbeta^2*u(3)^2*Ca(3)^2 + kA*kbeta^2*u(3)^2)^(1/2) + k0*kbeta*u(1)^2 + k0*kbeta*u(2)^2 + k0*kbeta*u(3)^2 - kab2*kbeta*u(1)^2 - kab2*kbeta*u(2)^2 - kab2*kbeta*u(3)^2 + kalpha^2*v(1)*pa(1) - kalpha^2*v(1)*Ca(1) + kalpha^2*v(2)*pa(2) - kalpha^2*v(2)*Ca(2) + kalpha^2*v(3)*pa(3) - kalpha^2*v(3)*Ca(3) - k0*kalpha*u(1)*v(1) - k0*kalpha*u(2)*v(2) - k0*kalpha*u(3)*v(3) + kab2*kalpha*u(1)*v(1) + kab2*kalpha*u(2)*v(2) + kab2*kalpha*u(3)*v(3) - kalpha*kbeta*u(1)*pa(1) + kalpha*kbeta*u(1)*Ca(1) - kalpha*kbeta*u(2)*pa(2) + kalpha*kbeta*u(2)*Ca(2) - kalpha*kbeta*u(3)*pa(3) + kalpha*kbeta*u(3)*Ca(3))/(kalpha^2*v(1)^2 + kalpha^2*v(2)^2 + kalpha^2*v(3)^2 - 2*kalpha*kbeta*u(1)*v(1) - 2*kalpha*kbeta*u(2)*v(2) - 2*kalpha*kbeta*u(3)*v(3) + kbeta^2*u(1)^2 + kbeta^2*u(2)^2 + kbeta^2*u(3)^2);
alpha1 = ((kab2-kbeta*beta1-k0)/kalpha);
alpha2 = ((kab2-kbeta*beta2-k0)/kalpha);

intersectionPoint1(1) = pa(1) + u(1)*alpha1 + v(1)*beta1;
intersectionPoint1(2) = pa(2) + u(2)*alpha1 + v(2)*beta1;
intersectionPoint1(3) = pa(3) + u(3)*alpha1 + v(3)*beta1;

intersectionPoint2(1) = pa(1) + u(1)*alpha2 + v(1)*beta2;
intersectionPoint2(2) = pa(2) + u(2)*alpha2 + v(2)*beta2;
intersectionPoint2(3) = pa(3) + u(3)*alpha2 + v(3)*beta2;
end

