function rotatedPoint = rotatePointAxis(alpha, u, P)
P = reshape(P,1,[]);
%alpha in degrees.
if numel(alpha) ~= 1
   error('Angle of rotation must be a scalar.');
end

s = sin(alpha*pi/180);
c = cos(alpha*pi/180);
% Different algorithms for 2, 3 and N dimensions:
switch nargin
   case 2
      % 2D rotation matrix:
      R = [c, -s;  s, c];
      
   case 3
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
   otherwise
      error('2 to 3 inputs required.');
end

rotatedPoint = P * R;
end


