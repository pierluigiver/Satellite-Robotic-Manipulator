clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER INPUT: Set Initial Conditions of the relative position/velocity of
% Deputy w.r.t. target (in phisycal Cartesian coordinates)
format long

% disp('Enter initial conditions of the relative position/velocity of Deputy w.r.t. Target (in physical ');
% disp('cartesian coordinates) in a column vector [6x1] with the following structure');
% disp('[x0 [m];y0 [m];z0 [m];x0_dot [m/s];y0_dot [m/s];z0_dot [m/s]].')
% disp('')
% X0 = input('X0 = ');
% 
% while(length(X0)~=6)
%     disp('The initial condition vector provided is not correct. Enter it again: ')
%     X0 = input('X0 = ');
% end
X0 = evalin('base', 'X0');
[J_min,Optimal_time] = ObjFun(X0);
fprintf('\n')
fprintf('\n')
disp('J_min [m/s] (cost function)')
fprintf('%f', J_min)
fprintf('\n')
fprintf('\n')
disp('Optimal time [s]')
fprintf('%f', Optimal_time)
fprintf('\n')


