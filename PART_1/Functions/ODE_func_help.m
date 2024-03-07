% FINAL PROJECT ORBITAL ROBOTICS
% (c) Antonio Scazzi, Fernando Vetrugno, Pierluigi Vergari, Andrea Villa: written on 2023-05-23
% 
%% function dz = ODE_func(z,n)
%
% This function defines the system of Ordinary Differential Equations (ODEs) 
% known as the Hill-Clohessy-Wiltshire (HCW) equations with respect to a chief 
% spacecraft in a circular reference orbit. The HCW equations describe the 
% relative motion of a deputy spacecraft with respect to the chief spacecraft.
% In this equations it is supposed that ux=uy=uz=0.
%
% INPUT:
% - z: A 6-element vector representing the state variables of the system. 
%      The elements of the state vector z are as follows:
%      - z(1): x-coordinate [m] of the deputy spacecraft relative to the 
%              chief spacecraft in the Hill frame.
%      - z(2): y-coordinate [m] of the deputy spacecraft relative to the 
%              chief spacecraft in the Hill frame.
%      - z(3): z-coordinate [m] of the deputy spacecraft relative to the 
%              chief spacecraft in the Hill frame.
%      - z(4): Velocity [m/s] along the x-axis of the deputy spacecraft 
%              relative to the chief spacecraft in the Hill frame.
%      - z(5): Velocity [m/s] along the y-axis of the deputy spacecraft 
%              relative to the chief spacecraft in the Hill frame.
%      - z(6): Velocity [m/s] along the z-axis of the deputy spacecraft 
%              relative to the chief spacecraft in the Hill frame.
% - n: The mean motion of the chief spacecraft's circular reference orbit 
%      (in radians per second).
%
% OUTPUT:
% - dz: A 6-element vector representing the time derivatives of the state 
%       variables which are computed based on the HCW equations. This
%       output is defined in order to be used with the solver Ode45.
%       
%       
% Note: The HCW equations describe the dynamics of the relative motion between 
%       the deputy spacecraft and the chief spacecraft, considering the 
%       gravitational effects and the rotating reference frame centered around 
%       the chief spacecraft. By integrating these equations numerically over time, 
%       the trajectory and motion of the deputy spacecraft relative to the chief 
%       spacecraft can be simulated.
%