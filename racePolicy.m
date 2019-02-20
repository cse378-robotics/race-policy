function [desLwSpeed, desRwSpeed] = racePolicy(obs)
% You must implement this function. The input/output of the function must be as follows.
% Use main to test your implementation. 
% Inputs:
%   obs: a number for the reading of the light sensor. Ranges from 1 
%        if off the track, and 0 if on the track.
% Outputs:
%   desLwSpeed, desRwSpeed: desired left and right wheel speeds


persistent stepCount
persistent mode
persistent inTurn
persistent prevObs

% Initialize Variables
if isempty(stepCount)
    stepCount = 0;
    mode = "straight";
    prevObs = obs;
end
stepCount = stepCount + 1;

%When going offtrack, first try right turn
if obs > 0.9 && mode == "straight"
    mode = "right";
elseif obs < 0.9 && mode == "right"
    mode = "straight";
end

%Set speeds
if mode == "straight"
    [desLwSpeed, desRwSpeed] = move("straight");
elseif mode == "right"
    [desLwSpeed, desRwSpeed] = move("right");
elseif mode == "left"
    [desLwSpeed, desRwSpeed] = move("left");
end

%Record current obs for next timestamp
prevObs = obs;
