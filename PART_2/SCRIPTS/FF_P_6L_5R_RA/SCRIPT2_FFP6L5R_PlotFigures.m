%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (C) Dr. Marcello Romano, 2020-06-09
% Last modified: 2020-08-19
% Last modified: 2021-05-29
% This script is part of TORO: Tool Set for Orbital RObotics
%
% This script runs a numerical simulation and produce plot. 

FFP6L5R_Robot_Description;
SCRIPT1_FFP6L5R_Simulate;
clc;

% CREATE A FIGURE of THE EVOLUTION IN TIME OF the System CoM
% COORDINATES
sysname = 'FFP_6L_5R';
n=5;

t=t_out;
num_rotational_dof =6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creazione della figura
fig = figure('Name',strcat(sysname,'_NSysCOM'),'DefaultAxesFontSize',16);

% Dimensioni desiderate
width = 800;
height = 600;

% Ottenere le dimensioni dello schermo
screenSize = get(0, 'ScreenSize');
screenWidth = screenSize(3);
screenHeight = screenSize(4);

% Calcolo delle coordinate per centrare la figura
left = (screenWidth - width) / 2;
bottom = (screenHeight - height) / 2;

% Impostazione delle dimensioni e posizione della figura
fig.Position = [left bottom width height];


% fprintf('\n')
% fprintf('\n')
% fprintf('***********************\n')
% fprintf(strcat('CAPTION OF Figure ', sysname,'_NSysCOM:\n'))
% fprintf('Evolution in time of the coordinates of the system CoM on the N CCS\n') 
% fprintf('each subplot is showing a gen. coordinate in darker line and the corresponding generalized velocity in lighter line.\n')
% fprintf('***********************\n')
% fprintf('\n')
% fprintf('\n')


subplot(6,2,[1 3 5 7 9])
plot(t,SCMt(:,1),'LineWidth', 2, 'color','k')
xlabel('t [s]', 'FontSize',15)
ylabel('x_{SCM} on the N CCS', 'FontSize',15)


subplot(6,2,[2 4 6 8 10])
plot(t,SCMt(:,2),'LineWidth', 2, 'color','k')
xlabel('t [s]', 'FontSize',15)
ylabel('y_{SCM} on the N CCS', 'FontSize',15)

annotation('textbox', [0, 0, 1, 0.1], 'String', 'Evolution in time of the coordinates of the system CoM on the N CCS, each subplot is showing a gen. coordinate in darker line and the corresponding generalized velocity in lighter line.', 'FontSize', 10, 'EdgeColor', 'black', 'BackgroundColor', 'none');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure('Name',strcat(sysname,'_BirdView'),'DefaultAxesFontSize',16)
% 
% fprintf('\n')
% fprintf('\n')
% fprintf('***********************\n')
% fprintf(strcat('CAPTION OF Figure ', sysname,'_BirdView:\n'))
% fprintf('Evolution on plane of motion\n')
% fprintf('***********************\n')
% fprintf('\n')
% fprintf('\n')
% 
% 
% plot(SCMt(:,1),SCMt(:,2),'LineWidth', 3, 'color','k','DisplayName','CoM')
% hold on
% txt = '\leftarrow C at t_0';
% text(SCMt(1,1),SCMt(1,2),txt,'FontSize',14) 
% 
% plot(C0_t(:,1),C0_t(:,2),'LineWidth', 2, 'color','k','DisplayName','C0')
% txt = '\leftarrow C0 at t_0';
% text(C0_t(1,1),C0_t(1,2),txt,'FontSize',14) 
% 
% plot(C1_t(:,1),C1_t(:,2),'LineWidth', 2, 'color','k','DisplayName','C1')
% txt = '\leftarrow C1 at t_0';
% text(C1_t(1,1),C1_t(1,2),txt,'FontSize',14) 
% 
% plot(C2_t(:,1),C2_t(:,2),'LineWidth', 2, 'color','k','DisplayName','C2')
% txt = '\leftarrow C2 at t_0';
% text(C2_t(1,1),C2_t(1,2),txt,'FontSize',14) 
% 
% plot(C3_t(:,1),C3_t(:,2),'LineWidth', 2, 'color','k','DisplayName','C3')
% txt = '\leftarrow C3 at t_0';
% text(C3_t(1,1),C3_t(1,2),txt,'FontSize',14) 
% 
% plot(C4_t(:,1)-SCMt(:,1),C4_t(:,2)-SCMt(:,2),'LineWidth', 2, 'color','k','DisplayName','C4')
% txt = '\leftarrow C4 at t_0';
% text(C4_t(1,1),C4_t(1,2),txt,'FontSize',14) 
% 
% plot(C5_t(:,1),C5_t(:,2),'LineWidth', 2, 'color','k','DisplayName','C5')
% txt = '\leftarrow C5 at t_0';
% text(C5_t(1,1),C5_t(1,2),txt,'FontSize',14) 
% 
% plot(Oj1_t(:,1),Oj1_t(:,2),'LineWidth', 2, 'color','k','DisplayName','Oj1')
% txt = '\leftarrow Oj1 at t_0';
% text(Oj1_t(1,1),Oj1_t(1,2),txt,'FontSize',14) 
% 
% plot(Oj2_t(:,1),Oj2_t(:,2),'LineWidth', 2, 'color','k','DisplayName','Oj2')
% txt = '\leftarrow Oj2 at t_0';
% text(Oj2_t(1,1),Oj2_t(1,2),txt,'FontSize',14) 
% 
% plot(Oj3_t(:,1),Oj3_t(:,2),'LineWidth', 2, 'color','k','DisplayName','Oj3')
% txt = '\leftarrow Oj3 at t_0';
% text(Oj3_t(1,1),Oj3_t(1,2),txt,'FontSize',14) 
% 
% plot(Oj4_t(:,1),Oj4_t(:,2),'LineWidth', 2, 'color','k','DisplayName','Oj4')
% txt = '\leftarrow Oj4 at t_0';
% text(Oj4_t(1,1),Oj4_t(1,2),txt,'FontSize',14) 
% 
% plot(Oj5_t(:,1),Oj5_t(:,2),'LineWidth', 2, 'color','k','DisplayName','Oj5')
% txt = '\leftarrow Oj5 at t_0';
% text(Oj5_t(1,1),Oj5_t(1,2),txt,'FontSize',14) 
% 
% plot(EE_t(:,1),EE_t(:,2),'LineWidth', 2, 'color','k','DisplayName','C0')
% txt = '\leftarrow EE at t_0';
% text(EE_t(1,1),EE_t(1,2),txt,'FontSize',14) 
% 
% xlabel('x')
% ylabel('y')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig2 = figure('Name',strcat(sysname,'_MB_Linear_Momentum'),'DefaultAxesFontSize',16);

% Dimensioni desiderate
width = 800;
height = 600;

% Ottenere le dimensioni dello schermo
screenSize = get(0, 'ScreenSize');
screenWidth = screenSize(3);
screenHeight = screenSize(4);

% Calcolo delle coordinate per centrare la figura
left = (screenWidth - width) / 2;
bottom = (screenHeight - height) / 2;

% Impostazione delle dimensioni e posizione della figura
fig2.Position = [left bottom width height];


% fprintf('\n')
% fprintf('\n')
% fprintf('***********************\n')
% fprintf(strcat('CAPTION OF Figure ', sysname,'_MB_Linear_Momentum:\n'))
% fprintf('Evolution in time of the Linear Momentum of the Multi-Body.\n') 
% fprintf('***********************\n')
% fprintf('\n')
% fprintf('\n')

subplot(6,2,[1 3 5 7 9])
plot(t,Linear_Momentum(:,1) ,'LineWidth', 2, 'color','k')
xlabel('t [s]', 'FontSize',15)
ylabel('Linear Momentum along x of the Multi-body', 'FontSize',15)
subplot(6,2,[2 4 6 8 10])
plot(t,Linear_Momentum(:,2) ,'LineWidth', 2, 'color','k')
xlabel('t [s]', 'FontSize',15)
ylabel('Linear Momentum along y of the Multi-body', 'FontSize',15)

annotation('textbox', [0, 0, 1, 0.1], 'String', 'Evolution in time of the Linear Momentum of the Multi-Body.', 'FontSize', 10, 'EdgeColor', 'black', 'BackgroundColor', 'none');

% subplot(1,3,3)
% plot(t,Linear_Momentum(:,3) ,'LineWidth', 2, 'color','k')
% xlabel('t [s]')
% ylabel('Linear Momentum along z of the Multi-body')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure('Name',strcat(sysname,'_NSysMoMwrtC0'),'DefaultAxesFontSize',16)
% 
% fprintf('\n')
% fprintf('\n')
% fprintf('***********************\n')
% fprintf(strcat('CAPTION OF Figure ', sysname,'_NSysMoMwrtC0:\n'))
% fprintf('Evolution in time of the Moment of Momentum w.r.t. C0 (CoM L0)\n') 
% fprintf('***********************\n')
% fprintf('\n')
% fprintf('\n')
% 
% plot(t, MoMt_C0(:,3)-MoMt_C0(1,3)*ones(size(MoMt_C0)),'LineWidth', 2, 'color','k')
% xlabel('t [s]')
% ylabel('MoM wrt C0 minus its Init. Value')
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure('Name',strcat(sysname,'_NSysMoMwrtOI'),'DefaultAxesFontSize',16)
% 
% fprintf('\n')
% fprintf('\n')
% fprintf('***********************\n')
% fprintf(strcat('CAPTION OF Figure ', sysname,'_NSysMoMwrtOI:\n'))
% fprintf('Evolution in time of the Moment of Momentum w.r.t. OI (Origin of Inertially Fixed CCS)\n') 
% fprintf('***********************\n')
% fprintf('\n')
% fprintf('\n')
% 
% plot(t, MoMt_OI(:,3)-MoMt_OI(1,3)*ones(size(MoMt_OI)),'LineWidth', 2, 'color','k')
% xlabel('t [s]')
% ylabel('MoM wrt OI minus its Init. Value')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig3 = figure('Name',strcat(sysname,'_NSysMoMwrtC'),'DefaultAxesFontSize',16);
% Dimensioni desiderate
width = 800;
height = 600;

% Ottenere le dimensioni dello schermo
screenSize = get(0, 'ScreenSize');
screenWidth = screenSize(3);
screenHeight = screenSize(4);

% Calcolo delle coordinate per centrare la figura
left = (screenWidth - width) / 2;
bottom = (screenHeight - height) / 2;

% Impostazione delle dimensioni e posizione della figura
fig3.Position = [left bottom width height];

% fprintf('\n')
% fprintf('\n')
% fprintf('***********************\n')
% fprintf(strcat('CAPTION OF Figure ', sysname,'_NSysMoMwrtC:\n'))
% fprintf('Evolution in time of the Moment of Momentum w.r.t. C (system CoM)\n') 
% fprintf('***********************\n')
% fprintf('\n')
% fprintf('\n')

subplot(10,1,[1 2 3 4 5 6 7 8])
plot(t, MoMt_sysC(:,3)-MoMt_sysC(1,3)*ones(size(MoMt_sysC)),'LineWidth', 2, 'color','k')
xlabel('t [s]', 'FontSize',15)
ylabel('MoM wrt C minus its Init. Value', 'FontSize',15)

annotation('textbox', [0, 0, 1, 0.1], 'String', 'Evolution in time of the Moment of Momentum w.r.t. C (system CoM).', 'FontSize', 10, 'EdgeColor', 'black', 'BackgroundColor', 'none');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure('Name',strcat(sysname,'_NAxialMoMmwrtj1'),'DefaultAxesFontSize',16)
% 
% fprintf('\n')
% fprintf('\n')
% fprintf('***********************\n')
% fprintf(strcat('CAPTION OF Figure ', sysname,'_NAxialMoMmwrtj1:\n'))
% fprintf('Evolution in time of the Axial Moment of Momentum of the manipulator w.r.t. j1 (joint 1)\n') 
% fprintf('***********************\n')
% fprintf('\n')
% fprintf('\n')
% 
% plot(t, Axial_MoMm_j1(:,1),'LineWidth', 2, 'color','k')
% xlabel('t [s]')
% ylabel('Axial MoMm at j1')
% 
% figure('Name',strcat(sysname,'_NAxialMoMmwrtj2'),'DefaultAxesFontSize',16)
% 
% fprintf('\n')
% fprintf('\n')
% fprintf('***********************\n')
% fprintf(strcat('CAPTION OF Figure ', sysname,'_NAxialMoMmwrtj2:\n'))
% fprintf('Evolution in time of the Axial Moment of Momentum of the manipulator w.r.t. j2 (joint 2)\n') 
% fprintf('***********************\n')
% fprintf('\n')
% fprintf('\n')
% 
% plot(t, Axial_MoMm_j2(:,1),'LineWidth', 2, 'color','k')
% xlabel('t [s]')
% ylabel('Axial MoMm at j2')
% 
% figure('Name',strcat(sysname,'_NAxialMoMmwrtj3'),'DefaultAxesFontSize',16)
% 
% fprintf('\n')
% fprintf('\n')
% fprintf('***********************\n')
% fprintf(strcat('CAPTION OF Figure ', sysname,'_NAxialMoMmwrtj3:\n'))
% fprintf('Evolution in time of the Axial Moment of Momentum of the manipulator w.r.t. j3 (joint 3)\n') 
% fprintf('***********************\n')
% fprintf('\n')
% fprintf('\n')
% 
% plot(t, Axial_MoMm_j3(:,1),'LineWidth', 2, 'color','k')
% xlabel('t [s]')
% ylabel('Axial MoMm at j3')
% 
% figure('Name',strcat(sysname,'_NAxialMoMmwrtj4'),'DefaultAxesFontSize',16)
% 
% fprintf('\n')
% fprintf('\n')
% fprintf('***********************\n')
% fprintf(strcat('CAPTION OF Figure ', sysname,'_NAxialMoMmwrtj4:\n'))
% fprintf('Evolution in time of the Axial Moment of Momentum of the manipulator w.r.t. j4 (joint 4)\n') 
% fprintf('***********************\n')
% fprintf('\n')
% fprintf('\n')
% 
% plot(t, Axial_MoMm_j4(:,1),'LineWidth', 2, 'color','k')
% xlabel('t [s]')
% ylabel('Axial MoMm at j4')
% 
% figure('Name',strcat(sysname,'_NAxialMoMmwrtj5'),'DefaultAxesFontSize',16)
% 
% fprintf('\n')
% fprintf('\n')
% fprintf('***********************\n')
% fprintf(strcat('CAPTION OF Figure ', sysname,'_NAxialMoMmwrtj5:\n'))
% fprintf('Evolution in time of the Axial Moment of Momentum of the manipulator w.r.t. j5 (joint 5)\n') 
% fprintf('***********************\n')
% fprintf('\n')
% fprintf('\n')
% 
% plot(t, Axial_MoMm_j5(:,1),'LineWidth', 2, 'color','k')
% xlabel('t [s]')
% ylabel('Axial MoMm at j5')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure('Name',strcat(sysname,'_thetas_dot_thetas'),'DefaultAxesFontSize',16)
% 
% fprintf('\n')
% fprintf('\n')
% fprintf('***********************\n')
% fprintf(strcat('CAPTION OF Figure ', sysname,'_thetas_dot_thetas:\n'))
% fprintf('Evolution in time of the theta coordinates (theta0, theta1, ... , theta5) and velocites \n') 
% fprintf('each subplot is showing a theta coordinate in darker line and the corresponding generalized velocity in lighter line.\n')
% fprintf('***********************\n')
% fprintf('\n')
% fprintf('\n')
% 
% 
% for ii=1:num_rotational_dof
% subplot(num_rotational_dof,1,ii)
% plot(t,thetas(:,ii),'LineWidth', 2, 'color','k')
% hold on
% grid on
% plot(t,dot_thetas(:,ii),'LineWidth', 0.5, 'color','k')
% %plot(t,Y(:,(2*ii-1):(2*ii)),'LineWidth', 2, 'color','k')
% %plot(t,Y(:,(2*ii-1):(2*ii)),'LineWidth', 2, 'color','k')
% xlabel('t [s]')
% ylabel(strcat('$\theta$',num2str(ii),', $\dot{\theta}$',num2str(ii)),'Interpreter','latex')
% end