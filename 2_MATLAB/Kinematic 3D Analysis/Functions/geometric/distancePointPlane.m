function [d] = distancePointPlane(P,n,A)
%Distance from point P to plane defined by vector n and point A
n=n/norm(n);
d = dot(P-A,n);
end

