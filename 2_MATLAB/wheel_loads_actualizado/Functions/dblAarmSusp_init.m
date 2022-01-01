function [] = dblAarmSuspOptim_init(block)
%% Definition of internal parameters used by the model
addpath('Functions');

%% Get parameters
vars = get_param(block,'MaskWSVariables');
getMaskValue = containers.Map({vars.Name}',{vars.Value}');

X = getMaskValue('X_original');
sideSign = getMaskValue('sideSign');
enOptim = getMaskValue('enOptim');

if enOptim
    sepUpper = getMaskValue('sepUpper');
    symUpper = (1+getMaskValue('symUpper'))/2;
    sepLower = getMaskValue('sepLower');
    symLower = (1+getMaskValue('symLower'))/2;
% UCA
axis = (X(1:3)-X(4:6))/norm(X(1:3)-X(4:6));
A = intersectPlaneLine(X(1:3)-X(4:6),X(13:15),X(1:3)-X(4:6),X(1:3));
X(1:3) = A + sepUpper*symUpper*axis;
X(4:6) = A - sepUpper*(1-symUpper)*axis;
% LCA
axis = (X(7:9)-X(10:12))/norm(X(7:9)-X(10:12));
A = intersectPlaneLine(X(7:9)-X(10:12),X(16:18),X(7:9)-X(10:12),X(7:9));
X(7:9) = A + sepLower*symLower*axis;
X(10:12) = A - sepLower*(1-symLower)*axis;
end

%% A-arms geometry
% UCA
A = intersectPlaneLine(X(1:3)-X(4:6),X(13:15),X(1:3)-X(4:6),X(1:3));
UCAfore_X = norm(X(1:3)-A);
UCAaft_X = -norm(X(4:6)-A);
UCA_Y = -norm(X(13:15)-A);
UCA_pushBracket_X = distancePointPlane(X(31:33),X(1:3)-X(4:6),X(13:15));
UCA_pushBracket_Y = distancePointPlane(X(31:33),X(13:15)-A,X(13:15));
UCA_pushBracket_Z = distancePointPlane(X(31:33),cross(X(4:6)-X(13:15),X(1:3)-X(13:15)),X(13:15));
% LCA
A = intersectPlaneLine(X(7:9)-X(10:12),X(16:18),X(7:9)-X(10:12),X(7:9));
LCAfore_X = norm(X(7:9)-A);
LCAaft_X = -norm(X(10:12)-A);
LCA_Y = -norm(X(16:18)-A);


%% Joints orientation
% UCA
UCA_Rot = findRotMat([0 0 1],(X(1:3)-X(4:6)).*[1 sideSign 1]);
z = (X(13:15)-X(1:3))/norm(X(13:15)-X(1:3)).*[1 sideSign 1];
y = sideSign*cross(X(13:15)-X(4:6),X(13:15)-X(1:3))/norm(cross(X(13:15)-X(4:6),X(13:15)-X(1:3))).*[1 sideSign 1];
x = cross(y,z);
UCAfore_Rot = [x(:) y(:) z(:)];
z = (X(13:15)-X(4:6))/norm(X(13:15)-X(4:6)).*[1 sideSign 1];
y = sideSign*cross(X(13:15)-X(4:6),X(13:15)-X(1:3))/norm(cross(X(13:15)-X(4:6),X(13:15)-X(1:3))).*[1 sideSign 1];
x = cross(y,z);
UCAaft_Rot = [x(:) y(:) z(:)];
% LCA
LCA_Rot = findRotMat([0 0 1],(X(7:9)-X(10:12)).*[1 sideSign 1]);
z = (X(16:18)-X(7:9))/norm(X(16:18)-X(7:9)).*[1 sideSign 1];
y = sideSign*cross(X(16:18)-X(10:12),X(16:18)-X(7:9))/norm(cross(X(16:18)-X(10:12),X(16:18)-X(7:9))).*[1 sideSign 1];
x = cross(y,z);
LCAfore_Rot = [x(:) y(:) z(:)];
z = (X(16:18)-X(10:12))/norm(X(16:18)-X(10:12)).*[1 sideSign 1];
y = sideSign*cross(X(16:18)-X(10:12),X(16:18)-X(7:9))/norm(cross(X(16:18)-X(10:12),X(16:18)-X(7:9))).*[1 sideSign 1];
x = cross(y,z);
LCAaft_Rot = [x(:) y(:) z(:)];
% Steering
SteeringRot = findRotMat([0 0 1],(X(22:24)-X(19:21)).*[1 sideSign 1]);

%% Bellcranks
BcrnkDamp = norm(X(37:39)-X(40:42));
BcrnkPush = norm(X(37:39)-X(34:36));
BcrnkAng = vectsAngle(X(37:39)-X(40:42),X(37:39)-X(34:36));
BcrnkRot = findRotMat([0 0 1],cross(X(37:39)-X(34:36), X(37:39)-X(40:42)).*[1 sideSign 1]);
PushRot = findRotMat([0 0 1],(X(31:33)-X(34:36)).*[1 sideSign 1]);

%% Set parameters
set_param(block,...
    'X',mat2str(X),...
    'UCAfore_X',mat2str(UCAfore_X),...
    'UCAaft_X',mat2str(UCAaft_X),...
    'UCA_Y',num2str(UCA_Y),...
    'UCA_pushBracket_X',mat2str(UCA_pushBracket_X),...
    'UCA_pushBracket_Y',mat2str(UCA_pushBracket_Y),...
    'UCA_pushBracket_Z',mat2str(UCA_pushBracket_Z),...
    'LCAfore_X',mat2str(LCAfore_X),...
    'LCAaft_X',mat2str(LCAaft_X),...
    'LCA_Y',mat2str(LCA_Y),...
    'UCA_Rot',mat2str(UCA_Rot),...
    'LCA_Rot',mat2str(LCA_Rot),...
    'UCAfore_Rot',mat2str(UCAfore_Rot),...
    'LCAfore_Rot',mat2str(LCAfore_Rot),...
    'UCAaft_Rot',mat2str(UCAaft_Rot),...
    'LCAaft_Rot',mat2str(LCAaft_Rot),...
    'SteeringRot',mat2str(SteeringRot),...
    'BcrnkDamp',mat2str(BcrnkDamp),...
    'BcrnkPush',mat2str(BcrnkPush),...
    'BcrnkAng',mat2str(BcrnkAng),...
    'BcrnkRot',mat2str(BcrnkRot),...
    'PushRot',mat2str(PushRot));
end


