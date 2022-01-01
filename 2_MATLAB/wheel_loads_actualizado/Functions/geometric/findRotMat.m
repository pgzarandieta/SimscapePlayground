function [R] = findRotMat(u,v)
%findRotMat Calculate Rotation matrix to transform vector u into v.
%   
u = u/norm(u);
v = v/norm(v);
c = dot(u,v);
switch dot(u,v)
    case 1
        R = eye(3);
        return;
    case -1
        R = -eye(3);
        return;
end    
q = cross(u,v);
Qx = [0 -q(3) q(2);q(3) 0 -q(1); -q(2) q(1) 0];
R = eye(3) + Qx + Qx^2*1/(1+c);
end

