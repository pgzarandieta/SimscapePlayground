function [] = dblAarmSusp_init(block)
%% Definition of internal parameters used by the model
addpath('Functions');

%% Get parameters
vars = get_param(block,'MaskWSVariables');
getMaskValue = containers.Map({vars.Name}',{vars.Value}');

X = getMaskValue('X');
sideSign = getMaskValue('sideSign');

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
%FS
UCA_Rot = findRotMat([0 0 1],(X(1:3)-X(4:6)).*[1 sideSign 1]);
LCA_Rot = findRotMat([0 0 1],(X(7:9)-X(10:12)).*[1 sideSign 1]);

%% Bellcranks
BcrnkDamp = norm(X(37:39)-X(40:42));
BcrnkPush = norm(X(37:39)-X(34:36));
BcrnkAng = vectsAngle(X(37:39)-X(40:42),X(37:39)-X(34:36));
BcrnkRot = findRotMat([0 0 1],cross(X(37:39)-X(34:36), X(37:39)-X(40:42)).*[1 sideSign 1]);

%% Set parameters
set_param(block,...
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
    'BcrnkDamp',mat2str(BcrnkDamp),...
    'BcrnkPush',mat2str(BcrnkPush),...
    'BcrnkAng',mat2str(BcrnkAng),...
    'BcrnkRot',mat2str(BcrnkRot));
end


