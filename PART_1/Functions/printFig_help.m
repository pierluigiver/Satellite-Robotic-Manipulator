% FINAL PROJECT ORBITAL ROBOTICS
% (c) Antonio Scazzi, Fernando Vetrugno, Pierluigi Vergari, Andrea Villa: written on 2023-05-23
% 
%% function printFig(ICs,v0,j,tf)
% The printFig is a void function that generates a plot showing the motion 
% of the deputy spacecraft for different variations of a specific initial 
% condition in the Hill frame. The integration is done by using ode45 since 
% it looks to be more computationally efficient rather than the use of the exact
% solution with the function expm().
%
% INPUT:
% - ICs: Initial conditions vector [6X1], representing the initial state 
%        of the deputy spacecraft. It contains the values for position (x, y, z) 
%        and velocity (vx, vy, vz) components respectively in [m] and [m/s]. 
% - v0: Vector containing the different values for the varying initial condition.
% - j: Index indicating the location of the initial condition that is varying within the ICs vector.
% - tf: Simulation time [s], representing the duration of the motion simulation.
%
% OUTPUT:
% None (void function)
% 