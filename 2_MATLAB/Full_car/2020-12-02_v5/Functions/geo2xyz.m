function [x,y,z] = geo2xyz(lat,lon,alt,north,lat0,lon0,alt0)
% north - angle of north orientation respect to x axis, in deg
north = 2*pi-north*pi/180;
if nargin == 4
    lat0 = 0;
    lon0 = 0;
    alt0 = 0;
elseif nargin ~= 7
    warning('Enter valid number of inputs');
end
R0 = 6369809;
y0 = (lat-lat0)*pi/180*R0;
x0 = (lon-lon0)*pi/180*R0.*cos(lat*pi/180);
z = alt0 + alt;

x = x0*cos(north)-y0*sin(north);
y = x0*sin(north)+y0*cos(north);
end

