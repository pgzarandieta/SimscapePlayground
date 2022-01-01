function [Fx,Fy,Fz] = extAcc_init(block)
%% Get parameters
vars = get_param(block,'MaskWSVariables');
getMaskValue = containers.Map({vars.Name}',{vars.Value}');

% Vehicle data
m = getMaskValue('mass'); 
wBias = getMaskValue('wBias'); 
h = getMaskValue('cog'); 
L = getMaskValue('wheelbase'); 
T = getMaskValue('track'); 
g = 9.81;
% Test data
ext_ax = getMaskValue('ext_ax');
ext_ay = getMaskValue('ext_ay');

try
% Simulation data
time = ext_ax.time;


Wx = ext_ax.signals.values*h*m*g/L;
Wf = m*g*wBias - Wx;
Wr = m*g*(1-wBias) + Wx;
Wyf = ext_ay.signals.values*h.*Wf/T;
Wyr = ext_ay.signals.values*h.*Wr/T;

Fz.signals.values = [Wf/2-Wyf Wf/2+Wyf Wr/2-Wyr Wr/2+Wyr];
Fz.signals.dimensions = 4;
Fz.time = time;

Fx.signals.values = Fz.signals.values.*ext_ax.signals.values;
Fx.signals.dimensions = 4;
Fx.time = time;

Fy.signals.values = Fz.signals.values.*ext_ay.signals.values;
Fy.signals.dimensions = 4;
Fy.time = time;
catch err
    disp(err);
    disp('Check format of external data');
    Fx = 0;
    Fy = 0;
    Fz = 0;
end
end

