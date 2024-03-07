%--- Manipulator Description a la DH ---%      
% Mass of the base and of the five links [kg]
m0=50;
m1=10;
m2=10;
m3=10;
m4=10;
m5=10;

% Half length of the base and of the five links [m]
l0=0.4;
l1=0.2; 
l2=0.2;
l3=0.2;
l4=0.2;
l5=0.2;

% Width of manipulator [m] (hp: parallelepiped box)
s=0.1; 

base_side = 2*l0;
man_side1 = 2*l1;
man_side2 = 2*l2;
man_side3 = 2*l3;
man_side4 = 2*l4;
man_side5 = 2*l5;
man_width = s;

%Number of joints
data.n=5;

%Base-spacecraft inertia matrix
data.base.mass=m0;
data.base.I=diag(data.base.mass/6*(base_side^2)*[1,1,2]); 

%First joint location with respect to base
data.base.T_L0_J1=[eye(3),[base_side/2;0;0];zeros(1,3),1]; %Homogeneus transformation matrix between L0 and J1

%First joint 
data.man(1).type=1; %REVOLUTE
%I define 4 parameters according to the DH parametrization
data.man(1).DH.d = 0;
data.man(1).DH.alpha = 0;
data.man(1).DH.a = man_side1;
data.man(1).DH.theta=0;
data.man(1).b = [data.man(1).DH.a/2;0;0];
data.man(1).mass=m1;

%Second joint 
data.man(2).type=1; %REVOLUTE
%I define 4 parameters according to the DH parametrization
data.man(2).DH.d = 0;
data.man(2).DH.alpha = 0;
data.man(2).DH.a = man_side2;
data.man(2).DH.theta=0;
data.man(2).b = [data.man(2).DH.a/2;0;0];
data.man(2).mass=m2;


%Third joint 
data.man(3).type=1; %REVOLUTE
%I define 4 parameters according to the DH parametrization
data.man(3).DH.d = 0;
data.man(3).DH.alpha = 0;
data.man(3).DH.a = man_side3;
data.man(3).DH.theta=0;
data.man(3).b = [data.man(3).DH.a/2;0;0];
data.man(3).mass=m3;

%Fourth joint 
data.man(4).type=1; %REVOLUTE
%I define 4 parameters according to the DH parametrization
data.man(4).DH.d = 0;
data.man(4).DH.alpha = 0;
data.man(4).DH.a = man_side4;
data.man(4).DH.theta=0;
data.man(4).b = [data.man(4).DH.a/2;0;0];
data.man(4).mass=m4;

%Fifth joint 
data.man(5).type=1; %REVOLUTE
%I define 4 parameters according to the DH parametrization
data.man(5).DH.d = 0;
data.man(5).DH.alpha = 0;
data.man(5).DH.a = man_side5;
data.man(5).DH.theta=0;
data.man(5).b = [data.man(5).DH.a/2;0;0];
data.man(5).mass=m5;


%NOTE: WE NEED TO GIVE NON SINGULAR MATRIX!
data.man(1).I=diag(1/12*data.man(1).mass*[2*man_width^2,man_width^2+man_side1^2,man_side1^2+man_width^2]); %inertia matrix of the manipulator
data.man(2).I=diag(1/12*data.man(2).mass*[2*man_width^2,man_width^2+man_side2^2,man_side2^2+man_width^2]);
data.man(3).I=diag(1/12*data.man(3).mass*[2*man_width^2,man_width^2+man_side3^2,man_side3^2+man_width^2]);
data.man(4).I=diag(1/12*data.man(4).mass*[2*man_width^2,man_width^2+man_side4^2,man_side4^2+man_width^2]);
data.man(5).I=diag(1/12*data.man(5).mass*[2*man_width^2,man_width^2+man_side5^2,man_side5^2+man_width^2]);

%End-Effector (actually we are not using them in this experiment)
data.EE.theta=0; %Rotation around z-axis
data.EE.d=0; %Translation along z-axis

%--- Create robot structure ---%
[robot,TEE_Ln] = DH_Serial2robot(data); %We obtain all the structures that define the robot for example for the base I have robot.base_link