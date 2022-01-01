function projection = projectVectPlane(v,n)
%vector v proyected in plane defined by normal vector n
v = reshape(v,1,[]);
n = reshape(n,1,[]);

a = dot(n,-v)/norm(n)^2;
projection = v + n*a;

end

