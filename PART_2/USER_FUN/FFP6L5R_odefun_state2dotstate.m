function dot_state = odefun_state_2_dotstate(t, state,  ControlActions, NonControlWrenches, robot)

% CONFIGURATION AT TIME t, provided by the numerical integrator  
% state(i,1)   q_IB(1) at t
% state(i,2)   q_IB(2) at t
% state(i,3)   q_IB(3) at t 
% state(i,4)   q_IB(4) at t    
% state(i,5)   I_r_B(1) at t 
% state(i,6)   I_r_B(2) at t
% state(i,7)   I_r_B(3) at t  
% state(i,8)   qm1 at t
% state(i,9)   qm2 at t
% state(i,10)  qm3 at t
% state(i,11)  qm4 at t
% state(i,12)  qm5 at t

%
% VELOCITY AT TIME t_out(i,1), provided by the numerical integrator    
% state(i,13)   I_Omega_BI(1) at t  
% state(i,14)   I_Omega_BI(2) at t   
% state(i,15)   I_Omega_BI(3) at t   
% state(i,16)   I_dot_r_B(1) at t  
% state(i,17)   I_dot_r_B(2) at t  
% state(i,18)   I_dot_r_B(3)at t  
% state(i,19)   dot_qm1 at t 
% state(i,20)   dot_qm2 at t 
% state(i,21)   dot_qm3 at t 
% state(i,22)   dot_qm4 at t 
% state(i,23)   dot_qm5 at t 

Re = 6371; % [km]
h = 500; % [km]
rc = (Re+h)*10^3; % [m]
mu = 398600.5*10^9; % [m^3/s^2]
n = sqrt(mu/rc^3); % [1/s]

% Recover Current Configuration
q_IB = state(1:4);% /norm(state(1:4));

C_IB = quat_DCM(q_IB);

I_r_B = state(5:7);
qm = state(8:12);

% Recover Current Velocity
uB = state(13:18);
um = state(19:23);

% Compute kinematics
[RJ,RL,rJ,I_r_L,e,g]=Kinematics(C_IB,I_r_B,qm,robot);


% Computation of the r_CoM wrt tthe inertial CCS
r_com = Center_of_Mass(I_r_B,I_r_L,robot);

% Rotation Matrix from Hill RF to inertial RF
theta = n*t; %rad
DCM.I.H = EulAxAngl2DCM([0;0;-1],theta);

% Inertias in inertial frames
[IB,Im]=I_I(C_IB,RL,robot);

% Compute differential kinematics
[Bij,Bi0,P0,pm]=DiffKinematics(C_IB,I_r_B,I_r_L,e,g,robot);

% Operational Velocities
[tB,tm]=Velocities(Bij,Bi0,P0,pm,uB,um,robot);

% Forward Dynamics
tau_control_B = ControlActions(1:6);
tau_control_joint =ControlActions(7:11);
WB=NonControlWrenches(1:6,1);
Wm=NonControlWrenches(1:6,2:6);

% Computation of the gravitational effects
CC0 = I_r_B - r_com;
CC1 = I_r_L(:,1) - r_com;
CC2 = I_r_L(:,2) - r_com;
CC3 = I_r_L(:,3) - r_com;
CC4 = I_r_L(:,4) - r_com;
CC5 = I_r_L(:,5) - r_com;
h1.H = [1;0;0];
h1.I = DCM.I.H*h1.H;

% Gravitational moments
WB(1:3) = (3*mu/rc^3)*(cross(h1.I,IB*h1.I));
Wm(1:3,1) = (3*mu/rc^3)*(cross(h1.I,Im(:,:,1)*h1.I));
Wm(1:3,2) = (3*mu/rc^3)*(cross(h1.I,Im(:,:,2)*h1.I));
Wm(1:3,3) = (3*mu/rc^3)*(cross(h1.I,Im(:,:,3)*h1.I));
Wm(1:3,4) = (3*mu/rc^3)*(cross(h1.I,Im(:,:,4)*h1.I));
Wm(1:3,5) = (3*mu/rc^3)*(cross(h1.I,Im(:,:,5)*h1.I));

% Gravitational forces
WB(4:6) = - (robot.base_link.mass*mu/rc^3)*(CC0 - dot(h1.I,CC0)*h1.I*3);
Wm(4:6,1) = - (robot.links(1).mass*mu/rc^3)*(CC1 - dot(h1.I,CC1)*h1.I*3);
Wm(4:6,2) = - (robot.links(2).mass*mu/rc^3)*(CC2 - dot(h1.I,CC2)*h1.I*3);
Wm(4:6,3) = - (robot.links(3).mass*mu/rc^3)*(CC3 - dot(h1.I,CC3)*h1.I*3);
Wm(4:6,4) = - (robot.links(4).mass*mu/rc^3)*(CC4 - dot(h1.I,CC4)*h1.I*3);
Wm(4:6,5) = - (robot.links(5).mass*mu/rc^3)*(CC5 - dot(h1.I,CC5)*h1.I*3);

[uBdot,umdot] = FD(tau_control_B,tau_control_joint,WB,Wm,tB,tm,P0,pm,IB,Im,Bij,Bi0,uB,um,robot); 
%This function called FD gives out the generalized accelerations and it's implementing 
%a recoursive algorithm to get the current generalized acceleration from the 
%knowledge of Q,tau,w (H*u_dot+C*u=tau). In order to have an efficient calculation 
%I have to express the formulation in the folowing way: u_dot = inv(H)*(tau-C*u). 
%I can avoid the inversion of the matrix by using algebra that is better when the system grows.

% Get quaternion velocity
I_Omega_BI = uB(1:3);
q1=q_IB(1);
q2=q_IB(2);
q3=q_IB(3);
q4=q_IB(4);
dot_q_IB=0.5*[q4,-q3,q2,q1; q3, q4,-q1,q2; -q2, q1,q4,q3; -q1, -q2,-q3,q4]*[-I_Omega_BI(1);-I_Omega_BI(2);-I_Omega_BI(3);0];

dot_state=[dot_q_IB;uB(4:6);um;uBdot;umdot];
end