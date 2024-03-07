% Dr. MARCELLO ROMANO, 
% Created 2019-05-28
% Modified 2023-04-30, prepared for ORO Class @ POLITO

clear all
close all
clc
format long

FFP6L5R_Robot_Description;

Re = 6371; % [km]
h = 500; % [km]
rc = (Re+h)*10^3; % [m]
mu = 398600.5*10^9; % [m^3]
n = sqrt(mu/rc^3); % [1/s]
tau = 2*pi/n; % [s]
vc = sqrt(mu/rc); % [m/s]

% Half length of the base and of the five links [m]
l0=0.4; 
l1=0.2; 
l2=0.2;
l3=0.2;
l4=0.2;
l5=0.2;

% Struct of the masses (base and five links) [kg]
m0 = robot.base_link.mass; 
m1 = robot.links(1).mass;
m2 = robot.links(2).mass;
m3 = robot.links(3).mass;
m4 = robot.links(4).mass;
m5 = robot.links(5).mass;

m_tot = m0+m1+m2+m3+m4+m5;
qm1 = pi/4; % Angle of the first joint wrt the base link [rad]

% CoM of the system coordinates calculated from the CoM of the base [m]
X_com = (m1*(l0+l1*cos(qm1))+m2*(l0+(2*l1+l2)*cos(qm1))+m3*(l0+(2*l1+2*l2+l3)*cos(qm1))+...
         m4*(l0+(2*l1+2*l2+2*l3+l4)*cos(qm1))+m5*(l0+(2*l1+2*l2+2*l3+2*l4+l5)*cos(qm1)))/m_tot;
Y_com = (m1*(l1*sin(qm1))+m2*((2*l1+l2)*sin(qm1))+m3*((2*l1+2*l2+l3)*sin(qm1))+...
         m4*((2*l1+2*l2+2*l3+l4)*sin(qm1))+m5*((2*l1+2*l2+2*l3+2*l4+l5)*sin(qm1)))/m_tot;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER INPUT: Set Initial Configuration of the MBS

t0.theta0=0;                                % Orientation of the base
t0.PV.pos.r0.N = [-X_com;-Y_com;0];         % Base (Link L0) CoM position (C0 is coincident in this case with 0 in the reference figure)
t0.qm = [qm1;0;0;0;0];                      % Displacement of the jointS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER INPUT: Set Initial Velocity of the MBS

t0.PV.Omega.L0.N.N = [0;0;n];                  % Angular velocity of base
t0.PV.dotN.pos.r0.N= n*[Y_com;-X_com;0];       % Absolute linear velocity of base COM
t0.dot.qm = [0;0;0;0;0];                       % Speed of the joints
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER INPUT:  SET external or internal non-control wrenches (resultant forces and moments acting on the base and the manipulator)

wFB=zeros(6,1);
wFm=zeros(6,5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER INPUT:  SET Control Actions
tau_control_B_Internal_Torque = zeros(3,1); %Forces acting on the base
tau_control_B_External_Force = zeros(3,1);
tau_control_manipulator = [0;0;0;0;0];      %Forces acting on the manipulator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER INPUT: Set numerical propagation parameters

finaltime=tau/4;   % Propagation time (a quarter of an orbit) [s]
propagation_timespan = 0:1:finaltime;

mytol = 3e-14; % Relative and absolute tolerance of the propagator

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%  CODE  %%%%%

% Concatenate in a set the intial configuration
t0.DCM.L0.N=EulAxAngl2DCM([0;0;1], t0.theta0);  % DCM from N to L0

q_BI_0 = DCM2quaternion(t0.DCM.L0.N);           % Initial Orientation of the base using orientation quaternion

q_IB_0 = quaternion2inversequat(q_BI_0);        % I perform the inverse of the quaternion because the recursive algorithm expects to have in input the quaternion from the Inertial RF to the base RF
Q_B_0 = [q_IB_0;t0.PV.pos.r0.N];                % Base initial configuration;  (7 ,1) matrix   
Q_0 = [Q_B_0; t0.qm];                           % Base and manipulator initial configuration; (15 ,1) matrix
    
% Concatenate in a set the initial Velocity
uB_0 = [t0.PV.Omega.L0.N.N;t0.PV.dotN.pos.r0.N];  
u_0 = [uB_0;t0.dot.qm];

% Concatenate initial system state
initial_state = [Q_0;u_0];

% ODE options
ODEoptions = odeset('RelTol',mytol, 'AbsTol', mytol,'Stats','off', 'NormControl','on');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Concatenate wrenches and control actions
NonControlWrenches = [wFB wFm];
JointControlActions =[tau_control_B_Internal_Torque;tau_control_B_External_Force;tau_control_manipulator];


% Execute Numerical Integration
[t_out, state_out] = ode113(@FFP6L5R_odefun_state2dotstate, propagation_timespan, initial_state, ODEoptions, JointControlActions, NonControlWrenches, robot); 

% EXPLANATION OF THE INTEGRATION OUTPUT
%
% t_out(i,1)        ith instant time at which solution is found
%
% CONFIGURATION AT TIME t_out(i,1), as follows:  
% state_out(i,1)   q_IB(1) at time t_out(i,1) --> quaternion of the base
% state_out(i,2)   q_IB(2) at time t_out(i,1) 
% state_out(i,3)   q_IB(3) at time t_out(i,1) 
% state_out(i,4)   q_IB(4) at time t_out(i,1)    
% state_out(i,5)   I_r_B(1) at time t_out(i,1) --> position of the base 
% state_out(i,6)   I_r_B(2) at time t_out(i,1)   
% state_out(i,7)   I_r_B(3) at time t_out(i,1)  
% state_out(i,8)   qm1 at time t_out(i,1)  --> displacement of the joint
% state_out(i,9)   qm2 at time t_out(i,1)
% state_out(i,10)  qm3 at time t_out(i,1)
% state_out(i,11)  qm4 at time t_out(i,1)
% state_out(i,12)  qm5 at time t_out(i,1)
%
% VELOCITY AT TIME t_out(i,1), as follows:  
% state_out(i,13)   I_Omega_BI(1) at time t_out(i,1)
% state_out(i,14)   I_Omega_BI(2) at time t_out(i,1) 
% state_out(i,15)   I_Omega_BI(3) at time t_out(i,1) 
% state_out(i,16)   I_dot_r_B(1) at time t_out(i,1) 
% state_out(i,17)   I_dot_r_B(2) at time t_out(i,1) 
% state_out(i,18)   I_dot_r_B(3) at time t_out(i,1) 
% state_out(i,19)   dot_qm1 at time t_out(i,1)
% state_out(i,20)   dot_qm2 at time t_out(i,1) 
% state_out(i,21)   dot_qm3 at time t_out(i,1) 
% state_out(i,22)   dot_qm4 at time t_out(i,1) 
% state_out(i,23)   dot_qm5 at time t_out(i,1) 


% Compute SYSTEM Momenta and SYSTEM CENTER OF MASS
MBB=robot.base_link.mass;
MLL1=robot.links(1).mass;
MLL2=robot.links(2).mass;
MLL3=robot.links(3).mass;
MLL4=robot.links(4).mass;
MLL5=robot.links(5).mass;


% Ppositions in plane of motion (for plotting)
SCMt= zeros(size(state_out,1),2);
C0_t= zeros(size(state_out,1),2);
C5_t= zeros(size(state_out,1),2);
Oj1_t= zeros(size(state_out,1),2);
EE_t= zeros(size(state_out,1),2);

MoMt_C0 = zeros(size(state_out,1),3);
MoMt_OI = zeros(size(state_out,1),3);
MoMt_sysC = zeros(size(state_out,1),3);
Linear_Momentum = zeros(size(state_out,1),3);
Axial_MoMm_j1 = zeros(size(state_out,1),1);
Axial_MoMm_j2 = zeros(size(state_out,1),1);
Axial_MoMm_j3 = zeros(size(state_out,1),1);
Axial_MoMm_j4 = zeros(size(state_out,1),1);
Axial_MoMm_j5 = zeros(size(state_out,1),1);
thetas=zeros(size(state_out,1),6);
dot_thetas=zeros(size(state_out,1),6);

for i=1:length(t_out)
    t = t_out(i);
    state = state_out(i,:)';
    C0_t(i,:)=state(5:6);
   % Recover Current Configuration
    q_IB = state(1:4);
    q = q_IB/norm(q_IB);
    
    C_IB = Quaternion2DCM(q);    
    I_r_B = state(5:7);
    qm = state(8:12)';

    [EulerAxis, theta0] =DCM2EulAxAngl_V2(C_IB');
    thetas(i,:)=[theta0,qm];
    dot_thetas(i,:)=[state(15),state(19:23)'];
   
    % Recover Current Velocity
    uB = state(13:18);
    um = state(19:23);
   
    % Compute kinematics
    [RJ,RL,rJ,rL,e,g]=Kinematics(C_IB,I_r_B,qm,robot); %e: axis of the joint, g: axis that connects the joint to the next link
    C1_t(i,:)=rL(1:2,1)';
    C2_t(i,:)=rL(1:2,2)';
    C3_t(i,:)=rL(1:2,3)';
    C4_t(i,:)=rL(1:2,4)';
    C5_t(i,:)=rL(1:2,5)';
    Oj1_t(i,:)=rJ(1:2,1)';
    Oj2_t(i,:)=rJ(1:2,2)';
    Oj3_t(i,:)=rJ(1:2,3)';
    Oj4_t(i,:)=rJ(1:2,4)';
    Oj5_t(i,:)=rJ(1:2,5)';
    posEEwrtC5_L5=(RL(:,:,5)*[l5;0;0])'; % Position of the end effector
    EE_t(i,:)= C5_t(i,:) + posEEwrtC5_L5(1:2);

    % Compute differential kinematics
    [Bij,Bi0,P0,pm]=DiffKinematics(C_IB,I_r_B,rL,e,g,robot); 

    % Velocities
    [tB,tm]=Velocities(Bij,Bi0,P0,pm,uB,um,robot); % This function implement the equation t=Nu and it returns the twist matrix
    
    % Center of mass
    r_com = Center_of_Mass(I_r_B,rL,robot); % Computantion of the CoM 
    com(i,:)=r_com';
    SCMt(i,:)=r_com(1:2)';
    % Save initial r_com
    if i==1
        r_com_0 = r_com;
    end
    dot_r_com = Center_of_Mass(tB(4:6),tm(4:6,:),robot); %Velocity of the CoM
      
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %MOMENTA COMPUTED FROM THE General Inertia Matrix
    
    % Inertias in inertial frames
    [I0,Im]=I_I(C_IB,RL,robot); %This funciton transfers the inertia matrix in inertial coordinates (?) system because the recursive approach requires this
    [M0_tilde,Mm_tilde]=MCB(I0,Im,Bij,Bi0,robot);
    
    % Generalized Inertia matrix (GIM)
    [H0, H0m, Hm] = GIM(M0_tilde,Mm_tilde,Bij,Bi0,P0,pm,robot);
    
    Hall=[H0, H0m;H0m', Hm];

    MM = (H0*uB+H0m*um)';
    
    % Moment of Momentum
    MoMt_C0(i,:)= MM(1:3); % We don't expect this to be conserved
    MoMt_OI(i,:)= MoMt_C0(i,:)+((MBB+MLL1+MLL2+MLL3+MLL4+MLL5)*SkewSym(I_r_B)*dot_r_com)'; 

    OC=r_com;
    OC0=I_r_B;
    CC0= OC0-OC;
    MoMt_sysC(i,:) = MoMt_C0(i,:)+((MBB+MLL1+MLL2+MLL3+MLL4+MLL5)*SkewSym(CC0)*dot_r_com)';
    
    % Linear_Momentum(i,:) = m_tot*r_com; %LinearMomentum of the Multi-body
    Linear_Momentum(i,:) = MM(4:6);             % LinearMomentum of the Multi-body
%     Axial_MoMm_j1(i,:)=H0m(:,1)'*uB+Hm(1,:)*um; % MoM about the joint axis 1
%     Axial_MoMm_j2(i,:)=H0m(:,2)'*uB+Hm(2,:)*um; % MoM about the joint axis 2
%     Axial_MoMm_j3(i,:)=H0m(:,3)'*uB+Hm(3,:)*um; % MoM about the joint axis 3
%     Axial_MoMm_j4(i,:)=H0m(:,4)'*uB+Hm(4,:)*um; % MoM about the joint axis 4
%     Axial_MoMm_j5(i,:)=H0m(:,5)'*uB+Hm(5,:)*um; % MoM about the joint axis 5
    
end
