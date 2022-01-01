function [motionRatio] = motionRatio(X, wheelTravel)
%%Calculate motionRatio for suspension defined by X and wheelTravel
%   'X' is expected to contain the coordinates of one LEFT quarter suspension.
%   It must be a row vector with the following values, in order:
%       1-Upper Front x,y,z = X([1 2 3])
%       2-Upper Rear x,y,z = X([4 5 6])
%       3-Lower Front x,y,z = X([7 8 9])
%       4-Lower Rear x,y,z = X([10 11 12])
%       5-Upper Upright x,y,z = X([13 14 15])
%       6-Lower Upright x,y,z = X([16 17 18])
%       7-Steering Rack x,y,z = X([19 20 21])
%       8-Steering Upright x,y,z = X([22 23 24])
%       9-Wheel Center x,y,z = X([25 26 27])
%       10-Wheel Plane x,y,z = X([28 29 30])
%       11-Push A-Arm Bracket X([31 32 33])
%       12-Push Bellcrank X([34 35 36])
%       13-Bellcrank Bracket X([37 38 39])
%       14-Damper Bellcrank X([40 41 42])
%       15-Damper Bracket X([43 44 45])
% X must be a matrix of dimensions 45 by length(wheelTravel) 

% addpath('../geometric');

steps = length(X(1,:));

springCompresion = vecnorm(X(40:42,:) - X(43:45,:));

motionRatio = zeros(1,steps);
for i = 2:steps-1
    motionRatio(i) = ((wheelTravel(i-1)-wheelTravel(i))/(springCompresion(i)-springCompresion(i-1))+(wheelTravel(i+1)-wheelTravel(i))/(springCompresion(i)-springCompresion(i+1)))/2;
end
motionRatio(1) = 2*motionRatio(2) - motionRatio(3);
motionRatio(steps) = 2*motionRatio(steps-1) -  motionRatio(steps-2);
end