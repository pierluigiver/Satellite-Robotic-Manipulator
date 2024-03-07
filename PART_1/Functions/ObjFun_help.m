% FINAL PROJECT ORBITAL ROBOTICS
% (c) Antonio Scazzi, Fernando Vetrugno, Pierluigi Vergari, Andrea Villa: written on 2023-05-23
% 
%% function [minimum_J, time] = ObjFun(X0)
%
% This function calculates the time at which the objective function reaches 
% its minimum value. It performs optimization calculations for a specific 
% problem involving the rendezvous maneuver between a deputy spacecraft 
% and a target. A maximum time is set at tau/2 and this represents a
% constraint for the aforementioned problem
%
% INPUT:
% - X0: A 6-element vector [6x1] representing the initial conditions of the 
%   deputy spacecraft. It includes the position and velocity components 
%   of the deputy relative to the target in the Hill reference frame. The 
%   elements of X0 are as follows:
%   -- X0(1): Initial x-coordinate [m] of the deputy spacecraft in the Hill frame.
%   -- X0(2): Initial y-coordinate [m] of the deputy spacecraft in the Hill frame.
%   -- X0(3): Initial z-coordinate [m] of the deputy spacecraft in the Hill frame.
%   -- X0(4): Initial velocity [m/s] along the x-axis of the deputy spacecraft in the Hill frame.
%   -- X0(5): Initial velocity [m/s] along the y-axis of the deputy spacecraft in the Hill frame.
%   -- X0(6): Initial velocity [m/s] along the z-axis of the deputy spacecraft in the Hill frame.
%
% OUTPUT:
% - minimum_J: The minimum value of the objective function, which represents 
%              the total delta-v [m/s] required for the two impulse rendezvous maneuver.
% - time: The time [s] at which the minimum value of the objective function is 
%         achieved, indicating the optimal time for executing the maneuver.
%
% Note: The objective function minimization process involves determining optimal 
%       delta-v values at specific time instances to achieve the desired rendezvous. 
%       The function also includes a plot of the objective function as a function of 
%       time within the specified constraints.