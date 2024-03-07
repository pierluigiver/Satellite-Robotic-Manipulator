FFP6L5R_Robot_Description;
SCRIPT1_FFP6L5R_Simulate;
clc;
sysname = 'FFP_6L_5R';

% Half length of the arms [m]
l0=0.4; 
l1=0.2;  
l2=0.2; 
l3=0.2;
l4=0.2;
l5=0.2;

% Mass of the links [kg]
m0 = robot.base_link.mass; 
m1 = robot.links(1).mass;
m2 = robot.links(2).mass;
m3 = robot.links(3).mass;
m4 = robot.links(4).mass;
m5 = robot.links(5).mass;

m_tot = m0+m1+m2+m3+m4+m5;

% Angle of the first joint wrt the base link [rad]
qm1 = pi/4;

% CoM of the system coordinates calculated from the CoM of the base [m]
X_com = (m1*(l0+l1*cos(qm1))+m2*(l0+(2*l1+l2)*cos(qm1))+m3*(l0+(2*l1+2*l2+l3)*cos(qm1))+m4*(l0+(2*l1+2*l2+2*l3+l4)*cos(qm1))+m5*(l0+(2*l1+2*l2+2*l3+2*l4+l5)*cos(qm1)))/m_tot;
Y_com = (m1*(l1*sin(qm1))+m2*((2*l1+l2)*sin(qm1))+m3*((2*l1+2*l2+l3)*sin(qm1))+m4*((2*l1+2*l2+2*l3+l4)*sin(qm1))+m5*((2*l1+2*l2+2*l3+2*l4+l5)*sin(qm1)))/m_tot;

% Trajectory of the robot wrt ECI
Re = 6371; %km
h = 500; %km
rc = (Re+h)*10^3; %m
mu = 398600.5*10^9; %m^3
n = sqrt(mu/rc^3); %[1/s]
tau = 2*pi/n; %[s]

t_track = (0:30:tau)';
orbit_track = [rc*cos(n*t_track) rc*sin(n*t_track) zeros(length(t_track),1)];
orbit_point = [rc*cos(n*t_out) rc*sin(n*t_out) zeros(length(t_out),1)];

figure('Units','normalized','Position',[0 0 1 1],'Name',strcat(sysname,'_Animation'),'DefaultAxesFontSize',16)
alpha = linspace(0,(360*tau/4)/86400,length(t_out));
time = (tau/4)/length(t_out);

for i = 1:5:length(t_out)
    % Four vertices of the base, used to draw the square and their evolution over time
    p_ur_B = [l0;l0;0];
    p_ul_B = [-l0;l0;0];
    p_ll_B = [-l0;-l0;0];
    p_lr_B = [l0;-l0;0];
   
    DCM.I.B = Quaternion2DCM(state_out(i,1:4)'/norm(state_out(i,1:4)'));
    p_ur_I = DCM.I.B*p_ur_B + state_out(i,5:7)';
    p_ul_I = DCM.I.B*p_ul_B + state_out(i,5:7)';
    p_ll_I = DCM.I.B*p_ll_B + state_out(i,5:7)';
    p_lr_I = DCM.I.B*p_lr_B + state_out(i,5:7)';
    

    % Plot of the evolution in time of the base + manipulator
    subplot(1,2,1)
    % Plot of the CoM of the system
    plot(SCMt(i,1),SCMt(i,2),'ro','Markersize',10)
    hold on
    
    % Plot of the links
    plot([Oj1_t(i,1),Oj2_t(i,1)],[Oj1_t(i,2),Oj2_t(i,2)],'-k','Linewidth',3)
    plot([Oj2_t(i,1),Oj3_t(i,1)],[Oj2_t(i,2),Oj3_t(i,2)],'-k','Linewidth',3)
    plot([Oj3_t(i,1),Oj4_t(i,1)],[Oj3_t(i,2),Oj4_t(i,2)],'-k','Linewidth',3)
    plot([Oj4_t(i,1),Oj5_t(i,1)],[Oj4_t(i,2),Oj5_t(i,2)],'-k','Linewidth',3)
    plot([Oj5_t(i,1),EE_t(i,1)],[Oj5_t(i,2),EE_t(i,2)],'-k','Linewidth',3)
    
    % Plot of the joints
    plot(Oj1_t(i,1),Oj1_t(i,2),'ko','Markersize',10)
    plot(Oj2_t(i,1),Oj2_t(i,2),'ko','Markersize',10)
    plot(Oj3_t(i,1),Oj3_t(i,2),'ko','Markersize',10)
    plot(Oj4_t(i,1),Oj4_t(i,2),'ko','Markersize',10)
    plot(Oj5_t(i,1),Oj5_t(i,2),'ko','Markersize',10)
    
    % Plot of the base
    plot([p_ur_I(1),p_ul_I(1)],[p_ur_I(2),p_ul_I(2)] ,'-k','Linewidth',3)
    plot([p_ur_I(1),p_lr_I(1)],[p_ur_I(2),p_lr_I(2)] ,'-k','Linewidth',3)
    plot([p_lr_I(1),p_ll_I(1)],[p_lr_I(2),p_ll_I(2)] ,'-k','Linewidth',3)
    plot([p_ll_I(1),p_ul_I(1)],[p_ll_I(2),p_ul_I(2)] ,'-k','Linewidth',3)
   
    % Axis of the inertial RF centered in the CoM of the entire system (base + manipulator)
    quiver3(0,0,0,2,0,0,'Color','blue','MaxHeadSize', .3)
    quiver3(0,0,0,0,2,0,'Color','blue','MaxHeadSize', .3)

    % Plot settings
    leg2 = legend('CoM of the system');
    set(leg2, 'FontSize', 10); 

    xlim([-2 2])
    ylim([-2 2])
    xlabel('X_{N} [m]','FontSize',10,'FontWeight','bold','Color','blue')
    ylabel('Y_{N} [m]','FontSize',10,'FontWeight','bold','Color','blue')
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    daspect([1,1,1])
    hold off
    
    % Plot of the evolution in time of the base + manipulator, seen from an ECI RF in order to notice the orbital motion
    subplot(1,2,2)

    r_second = Re*1000;
    earth = '1.jpg';
    matrix_vector_I = [0 2*10^6 0;
                       2*10^6 0 0;
                       0 0 0];
 
    DCM_HI = [cos(n*t_out(i)) -sin(n*t_out(i)) 0;
              sin(n*t_out(i)) cos(n*t_out(i)) 0;
              0 0 1];
    
    matrix_vector_H = DCM_HI*matrix_vector_I;
    
    % PlotCelestialBody is the function that allow us to plot the Earth as
    % a 3D body, starting from a 2D image, useful for enabling rotation around itself

    [globeSB2,cdataSB] = PlotCelestialBody(0,0,0,r_second,r_second,r_second,earth);
    set(globeSB2, 'FaceColor', 'texturemap', 'CData', cdataSB, 'FaceAlpha', 1, 'EdgeColor', 'none');
    rotate(globeSB2,[0 0 1],alpha(i))
    view(0,90)
    hold on

    % Plot of the shape of the orbit and the evolution in time of the satellite
    % (sketched as a red marker)

    plot(orbit_track(:,1),orbit_track(:,2),'b--','Linewidth',2)
    plot(orbit_point(i,1),orbit_point(i,2),'ro','Markersize',10)
    
    % Plot of the inertial RF centered in the CoM of the entire system
    % (base + manipulator) which is just translating wrt ECI RF

    quiver3(orbit_point(i,1),orbit_point(i,2),0,0,3*10^6,0,'Color','blue','MaxHeadSize', 1.1)
    text(orbit_point(i,1)+3*10^6,orbit_point(i,2),0, 'X_{N}','Color','blue');
    quiver3(orbit_point(i,1),orbit_point(i,2),0,3*10^6,0,0,'Color','blue','MaxHeadSize', 1.1)
    text(orbit_point(i,1),orbit_point(i,2)+3*10^6,0, 'Y_{N}','Color','blue');

    % Plot of the real time evolution 
    textPosition = [0.665, 0.08, 0.29, 0.29]; 
    textHandle = annotation('textbox', textPosition, 'FontSize', 12, 'EdgeColor', 'none', 'FitBoxToText', 'on');
    delete(findall(gcf, 'Type', 'textbox'));
    elapsedTime = i+time; %Time elapsed since the start
    timeStr = datestr(elapsedTime/86400, 'HH:MM:SS'); %Conversion to string format
    textHandle = annotation('textbox', textPosition, 'String', timeStr, 'FontSize', 12, 'EdgeColor', 'none', 'FitBoxToText', 'on');

    % Plot of the Hill RF centered in the CoM of the system (base + manipulator)
    quiver3(orbit_point(i,1),orbit_point(i,2),0,matrix_vector_H(1,1),matrix_vector_H(1,2),matrix_vector_H(1,3),'Color','red','MaxHeadSize', 1.1)
    quiver3(orbit_point(i,1),orbit_point(i,2),0,matrix_vector_H(2,1),matrix_vector_H(2,2),matrix_vector_H(2,3),'Color','red','MaxHeadSize', 1.1)
    
    % Plot settings
    grid off
    leg = legend('','Robot Orbit','Robot Position');
    set(leg, 'FontSize', 10); 
    xlabel('X_{ECI} [m]')
    ylabel('Y_{ECI} [m]')
    xlim([-1.2*10^7 1.2*10^7])
    ylim([-1*10^7 1*10^7])
    daspect([1,1,1]);

    annotation('textbox', [0, 0, 1, 0.1], 'String', 'We have illustrated in blue the inertial reference system, centered in the system''s CoM. Shown in red is the evolution of Hill''s reference system. If you look closely you can also observe the movement of the Earth around itself', 'FontSize', 10, 'EdgeColor', 'black', 'BackgroundColor', 'none');

    hold off
    pause(1/120)
    clearvars globeSB2
end
