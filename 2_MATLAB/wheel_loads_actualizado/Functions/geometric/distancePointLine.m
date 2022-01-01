function [d] = distancePointLine(P,R,r)
%Distance from point P to line defined by vector r and point R
P = reshape(P,1,[]);
R = reshape(R,1,[]);
r = reshape(r,1,[]);
d = norm(cross((P-R),r))/norm(r);
end

