function [symPoint] = symPointPlane(X,n,P)
%Returns symetric point of X respect to the plane defined by normal vector n and point P
X = reshape(X,1,[]);
P = reshape(P,1,[]);
n = reshape(n,1,[]);

a = (n*(P-X)')/norm(n)^2;
M = X + n*a;
symPoint = 2*M - X;
end

