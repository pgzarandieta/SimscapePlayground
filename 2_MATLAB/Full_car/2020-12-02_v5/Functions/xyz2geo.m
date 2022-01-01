function [lat,lon,alt] = xyz2geo(x,y,z,north,lat0,lon0,alt0)
% north - components of a vector pointing north in the x,y,z reference system, or angle
if length(north) == 3
    north = acos(dot([1 0 0],north))*sign(y);
end
if nargin == 4
    lat0 = 0;
    lon0 = 0;
    alt0 = 0;
elseif nargin ~= 7
    warning('Enter valid number of inputs');
end
x = x*cos(north*pi/180)+y*sin(north*pi/180);
y = -x*sin(north*pi/180)+y*cos(north*pi/180);

R0 = 6369809;
lat = lat0 + y/R0*180/pi;
lon = lon0 + x./(R0*cos(lat*pi/180))*180/pi;
alt = alt0+z;
end

