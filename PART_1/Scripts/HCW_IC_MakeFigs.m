clc

% Simulation time (in seconds) [try 10000s]
% T = input('Enter the simulation time in seconds T = ');
T = evalin('base', 'T');

% tic
% Shape of the initial conditions vector
% ICs = [x0(m) y0(m) z0(m) x0_dot(m/s) y0_dot(m/s) z0_dot(m/s)]

% Different x0s to be tested as initial condition
x0 = [-500 -100 -50 -10 -5 5 10 50 100 500];
ICs = zeros(6,1);

printFig(ICs,x0,1,T)

% Different x0_dots to be tested as initial condition
x0_dot = [-50 -10 -5 -1 -0.5 0.5 1 5 10 50];
ICs = zeros(6,1);

printFig(ICs,x0_dot,4,T)

% Different y0_dots to be tested as initial condition
y0_dot = [-50 -10 -5 -1 -0.5 -0.25 -0.113 0.113 0.25 0.5 1 5 10 50];
ICs = zeros(6,1);

printFig(ICs,y0_dot,5,T)

% Different x0_dots to be tested as initial condition with x0 = 50m as a
% constant offset
x0_dot = [-50 -10 -5 -1 -0.5 0 0.5 1 5 10 50];
ICs = [50;zeros(5,1)];

printFig(ICs,x0_dot,4,T)

% Different y0_dots to be tested as initial condition with x0 = 50m as a
% constant offset
y0_dot = [-24 -12 -2.5 -1.3 -0.117 -0.176 0.058 1.05 2.2 12 24];
ICs = [50;zeros(5,1)];

printFig(ICs,y0_dot,5,T)

% toc

yesno;

% answer = 1;
% 
% while (answer == 1)
%     disp('Would you like to plot the evolution of the orbit of the deputy w.r.t the chief')
%     disp('with a different set of initial conditions?')
%     disp('[1] YES')
%     disp('[2] NO')
% 
%     answer = input('');
%     
%     if (answer==1)
%         disp('')
%         ICs = input('Enter the vector of initial conditions [x0 [m];y0 [m];z0 [m];x0_dot [m/s];y0_dot [m/s];z0_dot [m/s]] = ');
%         n = input('Enter the index j of the initial condition that you want to vary (for instance if you are varying x0 enter 1): ');
%         v0 = input('Enter the vector of different initial conditions in position j of the ICs that you want to plot: ');
%         T = input('Enter the simulation time. T = ');
%         printFig(ICs,v0,n,T);
%     end
%     
% end