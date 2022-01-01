function [point] = projectPointPlane(X,n,P)
%Proyection of point X in plane defined by normal vector n and point P 
X = reshape(X,1,[]);
n = reshape(n,1,[]);
P = reshape(P,1,[]);

a = (n*(P-X)')/norm(n)^2;
point = X + n*a;
end

