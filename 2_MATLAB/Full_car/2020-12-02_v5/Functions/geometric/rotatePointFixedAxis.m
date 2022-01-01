function rotatedPoint = rotatePointFixedAxis(alpha, u, T, P)
% rotatePointFixedAxis(alpha, u, T, P)
% 'u' is rotation axis
% 'P' is the point to rotate around 'u'
% 'T' is a point of the rotation axis
% 'alpha' is rotation angle in deg

P = reshape(P,1,[]);
T = reshape(T,1,[]);

translation = intersectPlaneLine(u,P,u,T);
P = P - translation;
%alpha in degrees.
if numel(alpha) ~= 1
   error('Angle of rotation must be a scalar.');
end

s = sin(alpha*pi/180);
c = cos(alpha*pi/180);
% Different algorithms for 2, 3 and N dimensions:

  if numel(u) ~= 3
     error('3D: Rotation axis must have 3 elements.');
  end
  % Normalized vector:
  u = u(:);
  u = u ./ sqrt(u.' * u);   
  % 3D rotation matrix:
  x  = u(1);
  y  = u(2);
  z  = u(3);
  mc = 1 - c;
  R  = [c + x * x * mc,      x * y * mc - z * s,   x * z * mc + y * s; ...
        x * y * mc + z * s,  c + y * y * mc,       y * z * mc - x * s; ...
        x * z * mc - y * s,  y * z * mc + x * s,   c + z * z .* mc];

rotatedPoint = (P * R) + translation;
end
