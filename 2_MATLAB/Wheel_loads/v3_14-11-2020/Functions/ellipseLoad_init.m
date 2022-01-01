function [Fx, Fy, Fz, St, ax, ay] = ellipseLoad_init(block)
%% Get parameters
vars = get_param(block,'MaskWSVariables');
getMaskValue = containers.Map({vars.Name}',{vars.Value}');
% Simulation data
time = getMaskValue('time');
timeStep = getMaskValue('timeStep');
% Vehicle data
m = getMaskValue('mass'); 
wBias = getMaskValue('wBias'); 
h = getMaskValue('cog'); 
L = getMaskValue('wheelbase'); 
T = getMaskValue('track'); 
g = 9.81;
% Test data
e_axBrk = abs(getMaskValue('e_axBrk'));
e_axAcc = abs(getMaskValue('e_axAcc'));
e_ay = abs(getMaskValue('e_ay'));
e_st = getMaskValue('e_st');

s1 = pi*linspace(0,1,length(0:timeStep:time));
s2 = pi*(1 + linspace(0,1,length(0:timeStep:time)));
s2 = s2(2:end);
r1 = e_ay*e_axBrk./sqrt((e_axBrk*cos(s1)).^2+(e_ay*sin(s1)).^2);
r2 = e_ay*e_axAcc./sqrt((e_axAcc*cos(s2)).^2+(e_ay*sin(s2)).^2);
s = interp1([s1 s2],[s1 s2],linspace(0,2*pi,length(0:timeStep:time)));
r = interp1([s1 s2],[r1 r2],s);
Ax = -(r.*sin(s))';
Ay = (r.*cos(s))';

Wx = Ax*h*m*g/L;
Wf = m*g*wBias - Wx;
Wr = m*g*(1-wBias) + Wx;
Wyf = Ay*h.*Wf/T;
Wyr = Ay*h.*Wr/T;

Fz.signals.values = [Wf/2-Wyf Wf/2+Wyf Wr/2-Wyr Wr/2+Wyr];
Fz.signals.dimensions = 4;
Fz.time = 0:timeStep:time;

Fx.signals.values = Fz.signals.values.*Ax;
Fx.signals.dimensions = 4;
Fx.time = 0:timeStep:time;
Fy.signals.values = Fz.signals.values.*Ay;
Fy.signals.dimensions = 4;
Fy.time = 0:timeStep:time;

St.time = 0:timeStep:time;
St.signals.values = Ay*e_st/e_ay;
St.signals.dimensions = 1;

ax.time = 0:timeStep:time;
ax.signals.values = Ax;
ax.signals.dimensions = 1;

ay.time = 0:timeStep:time;
ay.signals.values = Ay;
ay.signals.dimensions = 1;
end
