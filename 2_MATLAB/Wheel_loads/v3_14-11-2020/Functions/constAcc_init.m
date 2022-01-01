function [Fx,Fy,Fz,St,ax,ay] = constAcc_init(block)
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
c_ax = getMaskValue('c_ax');
c_ay = getMaskValue('c_ay');
c_st = getMaskValue('c_st');

frcMode = getMaskValue('frcMode');
switch frcMode
    case 1 %Step
        Ax = c_ax*ones(1,length(0:timeStep:time))';
        Ay = c_ay*ones(1,length(0:timeStep:time))';
    case 2 %Ramp
        Ax = c_ax*(0:timeStep/time:1)';
        Ay = c_ay*(0:timeStep/time:1)';
end

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
if c_ay ~= 0
    St.signals.values = Ay*c_st/c_ay;
else
    St.signals.values = zeros(1,length(0:timeStep:time))';
end
St.signals.dimensions = 1;

ax.time = 0:timeStep:time;
ax.signals.values = Ax;
ax.signals.dimensions = 1;

ay.time = 0:timeStep:time;
ay.signals.values = Ay;
ay.signals.dimensions = 1;
end

