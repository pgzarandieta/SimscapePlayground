%% Definición de parámetros del vehículo - FullCar

%% General
% Masas
Sprung_mass_COG = [-64.198 0 250.027]; %mm
Sprung_mass = 170; %Kg en COG
Sprung_mass_InertiaMoments = [17.708 86.853 83.89]; %kg*m2
Sprung_mass_InertiaProducts = [-0.63 5.022 0.443]; %kg*m2

Driver_mass = 70; %kg
Driver_COG = [384 0 294]; %Coordinates in mm
%Note that driver rotational inertia is not considered and might not be neglectable. It may be included in the sprung mass inertia

Unsprung_mass_front = 15.5; %Kg per wheel, including rotating mass (rim and tire)
Unsprung_mass_COG_front = [955.679 463.689 121.918]; %Coordinates in mm, excluding rotating mass (rim and tire)
Unsprung_mass_rear = 15.5; 
Unsprung_mass_COG_rear = [-590.057 467.305 121.917];

Mass = Sprung_mass + Driver_mass + Unsprung_mass_front*2 + Unsprung_mass_rear*2;
COG = (Sprung_mass_COG*Sprung_mass + Driver_COG*Driver_mass + Unsprung_mass_COG_front*Unsprung_mass_front*2.*[1 0 1] + Unsprung_mass_COG_rear*Unsprung_mass_rear*2.*[1 0 1])/Mass;
%Note that the z coordinate of the ground in the CAD might not be 0. For the UPM04e it is -100mm

%% Wheels and Tires
Rim_mass = 3; %kg
Tire_mass = 3.5; %kg
Tire_radius = 18*25.4/2; %mm unloaded tire radius
Wheel_width = 152.4; %mm
Wheel_inertia = [0.121 0.121 0.194+0.056]; %kg*m2 [Iox Ioy Ioz]. Inertia of rim+tire(0.194) + driveline(0.056). Local axis of the tire, being Z the rolling axis.
Tire_prs_front = 1; %bar
Tire_prs_rear = 1; %bar
Tire_VerticalK = 106e3; %N/m tire vertical stiffness

% Parameters for the Fiala tire block
Tire_Cx = 4.85e4; %N tire longitudinal stiffness
Tire_Cy = 2.3862e4; %N/rad tire lateral stiffness
Tire_Cg = 1e3; %N/rad tire camber stiffness
Tire_Lx = .05; %m tire longitudinal relaxation length
Tire_Ly = .15; %m tire lateral relaxation length
Tire_muMin = 1.8;
Tire_muMax = 2;



%% Suspension kinematics
%   Los hardpoints se cargan a partir dos vectores de 45 componentes. El
%   nombre de la variable en el archivo .mat utilizado debe ser 'X'
%       1-Upper Front x,y,z = X([1 2 3])
%       2-Upper Rear x,y,z = X([4 5 6])
%       3-Lower Front x,y,z = X([7 8 9])s
%       4-Lower Rear x,y,z = X([10 11 12])
%       5-Upper Upright x,y,z = X([13 14 15])
%       6-Lower Upright x,y,z = X([16 17 18])
%       7-Steering Rack x,y,z = X([19 20 21])
%       8-Steering Upright x,y,z = X([22 23 24])
%       9-Wheel Center x,y,z = X([25 26 27])
%       10-Wheel Plane normal vector x,y,z = X([28 29 30])
%       11-Push A-Arm Bracket x,y,z = X([31 32 33])
%       12-Push Bellcrank x,y,z = X([34 35 36])
%       13-Bellcrank Bracket x,y,z = X([37 38 39])
%       14-Damper Bellcrank x,y,z = X([40 41 42])
%       15-Damper Bracket x,y,z = X([43 44 45])
X_F = load('FrontSuspension.mat','X');
X_R = load('RearSuspension.mat','X');
X_F = reshape(X_F.X,1,[]); %X_F must be a row vector
X_R = reshape(X_R.X,1,[]); %X_R must be a row vector




FS_camber = -1.5; %deg of static camber at reference ride height
RS_camber = -1.5;

FS_toe = 0; %deg of static toe at reference ride height
RS_toe = 0;


%% Barras
RodDiameter = 14; %mm %this value is only for graphic representation
RodThickness = 1; %mm


%% Muelles
Spring_stiffness_front = 175; %lb/in
Damper_coefficient_front = 5; %N/(mm/s)
Spring_preload_front = 3.2; %mm

Spring_stiffness_rear = 225; %lb/in
Damper_coefficient_rear = 6; %N/(mm/s)
Spring_preload_rear = 0; %mm


%% ARB
%%-FS
%Dynamics
ARB_stiffness_front = 400; %N/mm
ARB_damping_front = 0.1; %N/(mm/s)
%Geometry
ARB_length_front = 56.5;
ARB_TieRod_length_front = 217;
ARB_pinSlot_correctionFactor_front = 0.97;

ARB_center_front = [950.3 0 491]; %Coordinates of the pivot center of the Z-type anti-roll bar
ARB_bcrnk_frontL = [933.294 223.974 476.126]; %Coordinates of the anchor point of the anti-roll bar in the bellcrank
ARB_bcrnk_frontR = [971.355 -224.582 474.967];


%%-RS
%Dynamics
ARB_stiffness_rear = 500; %N/mm
ARB_damping_rear = 0.1; %N/(mm/s)
%Geometry
ARB_length_rear = 56.5;
ARB_TieRod_length_rear = 222;
ARB_pinSlot_correctionFactor_rear = 0.97;

ARB_center_rear = [-598 0 397]; 
ARB_bcrnk_rearL = [-618.853 233.462 390.273];
ARB_bcrnk_rearR = [-580.799 -232.896 391.146];


%% Brakes
Brakes_staticMu = 0.35;
Brakes_kineticMu = 0.3;
Brakes_caliperD = 25; %mm caliper actuator (piston) diameter
Brakes_effectiveR = 81; %mm effective radius of the brake disc (radius of the center of pressure)
Brakes_pads_front = 4; %number of brake pads
Brakes_pads_rear = 2;


%% Transmission
DriveTrain_ratio = 13.176; %Transmission ratio (output/input)
DriveTrain_effcy = 0.9; %Torque transmission efficiency
DriveTrain_brkwyTrq = 28; %Nm Breakaway friction torque. Minimum torque on the input to have any torque on the output
DriveTrain_brkwyVel = 0.1; %rad/s Breakaway friction velocity. 
DriveTrain_CoulombTrq = 25; %Nm Constant friction torque
DriveTrain_viscCoef = 0.01 ; %N*m/(rad/s) Viscous friction coefficient


%% Aero
airDensity = 1.225; %kg/m3
aero_refArea = 1.05; %m2
aero_pressureCenter = [957-435 0 818-100]; %mm coordinates -100 is the z coordinate of the ground (contact patch). 957 is the x coordinate of the front axle
aero_CF = [1.18 0 2.58]; % [CFx CFy CFz] such that F = 1/2*v^2*airDensity*refArea*CF
aero_CM = [0 0.272 0];% [CMx CMy CMz] such that M = 1/2*v^2*airDensity*refArea*wheelBase*CM


%% Environment
% Gravity
gravity = 9.80665;

% Floor and Grid
Floor_size = [150 150 0.1]; %m
Floor_pos = [50 0 0]; %m
Grid_size = 2; %m

% Initial position
initialPosition = [0 0 0.155]; %m
initialHeading = 0; %deg %Currently initial heading different than 0 causes errors in the assembly

