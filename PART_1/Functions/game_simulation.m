function game_simulator ()

close all

% % Set up the initialization of parameters
% disp('Use Default Settings?')
% true=input('Y[1] / N[2] =');
% if(true==1)
% dt = 5;                     %speed of the simulation(lower,slower)
% X0_deputy = [50;30;0;0;0;0];% State vector (HILL RF)
% Thruster_impulse=0.005;    % [m/s]
% else
%         inp = input('Enter the vector of relative initial conditions (DEPUTY) [x0[m];y0[m];x0_dot[m/s];y0_dot[m/s]] = ');
%         X0_deputy = [inp(1:2);0;inp(3:4);0];
%         Thruster_impulse=input('Enter the Thruster impulsive velocity [m/s](default value=0.005) = ');
%         dt=input('Enter the multiplyer of the time simulation (default value=5) = ')
% end

X0_deputy = evalin('base', 'X0_deputy');
Thruster_impulse = evalin('base','thr');
dt = evalin('base','dt');

%variable to limit graph axes
X0_deputy_lim=X0_deputy;

if (X0_deputy_lim(1)==0)
X0_deputy_lim(1)=150;
end

if (X0_deputy_lim(2)==0)
X0_deputy_lim(2)=150;
end
    
% Set up the figure window
h_fig = figure('Units','normalized','Position',[0 0 1 1]);

% Set up the keyboard event handling
set(h_fig, 'KeyPressFcn', @keypress_callback);

% Initialization of parameters 
Re = 6371; % km
h = 500; % km
mu = (398600.5)*10^9; % m^3/s^2
rc = (Re + h)*10^3; %m
n = sqrt(mu / rc^3);
tau = 2 * pi / n;
t_max = tau/2;

% State transition matrix A
A = [0      0       0       1       0       0;
     0      0       0       0       1       0;
     0      0       0       0       0       1;
     3*n*n  0       0       0       2*n     0;
     0      0       0       -2*n    0       0;
     0      0       -n*n    0       0       0];

% Time vector
tt = 0:dt:t_max;

% Target orbit calculation
%[X_target,V_target] = OrbitCalcECI(tt,DT,X0_target);
X_target = [rc*cos(n*tt);rc*sin(n*tt);zeros(1,length(tt))];

% Initialitazions for the loop
t0 = 0; % Initial time
gameover = 0;
i = 1;
won = 0;
deltaVfin = 0;

% Simulation loop
while(i<=length(tt) && ~gameover)
    
    deltaV = zeros(3,1);
    
    t = tt(i);
    
    % State transition matrix PHI
    PHI = expm(A * (t - t0));
    
    % Update deputy's position and velocity
    X_deputy = PHI(1:3, 1:6) * X0_deputy;
    V_deputy = PHI(4:6, 1:6) * X0_deputy;
    
    %Condition that verify if the deputy reached the target [accuracy 50 cm ans 0.01 m/s]
    if ((abs(X_deputy(1))<0.5)&&(abs(X_deputy(2))<0.5)&&...
        (abs(V_deputy(1))<0.01)&&(abs(V_deputy(2))<0.01))
         won = 1;
    end
    
    %Condition necessary because I am using global variables. If I win I
    %will continue to be on the same trajectory of the target for the rest
    %of the simulation
    if won == 1
        X_deputy_plot_HILL = zeros(3,1); % I have reached the target and the position vector in Hill RF is zero
        X_deputy_plot_ECI = zeros(3,1);
    else
        X_deputy_plot_HILL = X_deputy;
        DCM_ECI_HILL = EulAxAngl2DCM([0;0;1],n*t);
        X_deputy_plot_ECI = DCM_ECI_HILL*X_deputy_plot_HILL;
    end
    
    subplot(1,2,1)
    % Plot of the deputy and target positions in the ECI RF
    plot(X_target(1,:),X_target(2,:),'b-','Linewidth',1.5)
    grid on; hold on;
    xlabel('X_{ECI}[m]')
    ylabel('Y_{ECI}[m]')
    plot(X_deputy_plot_ECI(1)+X_target(1,i), X_deputy_plot_ECI(2)+X_target(2,i), 'r*', 'MarkerSize', 8);
    hold on
    plot(X_target(1,i), X_target(2,i), 'bo', 'MarkerSize', 8);
    hold on
    str2={'Your relative x-distance [m] is',X_deputy(1),'Your relative y-distance [m] is',X_deputy(2)};
                text(0,9e6,str2,"FontSize",10);
    
        if won == 1
            text(1, 7.3*10^6, 'YOU WON! Press space to close the simulation', 'HorizontalAlignment', 'center', 'FontSize', 15);
            %Print the final results
            fprintf('You reached the target in %d [s] and with total DeltaV equal to %f [m/s]', time, deltaVfin)
            pause(15)
            break
        end
        daspect([1,1,1]);
    hold off
    drawnow;        
    
    subplot(1,2,2)
    %Plot of the deputy position w.r.t. to the target position in HILL RF
    plot(0,0,'bo','MarkerSize',8)
    grid on; hold on;
    if(X0_deputy_lim(1)>X0_deputy_lim(2))
    ylim([-X0_deputy_lim(1)*1.5 X0_deputy_lim(1)*1.5]); xlim([-X0_deputy_lim(1)*1.5 X0_deputy_lim(1)*1.5]);
     text(0, 1.7*X0_deputy_lim(1), 'Use the arrow on your keyboard to reach the chief', 'HorizontalAlignment', 'center', 'FontSize', 12);
    else
    ylim([-X0_deputy_lim(2)*1.5 X0_deputy_lim(2)*1.5]); xlim([-X0_deputy_lim(2)*1.5 X0_deputy_lim(2)*1.5]);
      text(0, 1.7*X0_deputy_lim(2), 'Use the arrow on your keyboard to reach the chief', 'HorizontalAlignment', 'center', 'FontSize', 12);
    end
    hold on
    plot(X_deputy_plot_HILL(2), X_deputy_plot_HILL(1), 'r*', 'MarkerSize', 8);

    hold on
     if won == 1
            text(0, 2*10^6, 'YOU WON! Press space to close the simulation...', 'HorizontalAlignment', 'center', 'FontSize', 15);
            %Print the final results
            fprintf('You reached the target in %d [s] and with total DeltaV equal to %f [m/s]', time, deltaVfin)
     end
    quiver(X_deputy_plot_HILL(2), X_deputy_plot_HILL(1),V_deputy(2)*200,V_deputy(1)*200,'LineWidth',2,'color','red')
    daspect([1,1,1]);
    hold off
    xlabel('X_{HILL}[m]')
    ylabel('Y_{HILL}[m]')
    
    
    drawnow;
    
    % Pause to control the real-time simulation speed
    pause(1/60);
    
    i = i+1;
    time = dt*i;
    
    
end


    function keypress_callback(~,event)

        % Obtain the key pressed by the user
        key = event.Key;
        deltaV = [0;0;0];

        % Process the key input and update the delta-v control
        switch key
            case 'uparrow'
                % Increase the delta-v in the positive Y direction
                deltaV(1) = deltaV(1) + Thruster_impulse;
                deltaVfin = deltaVfin + norm(deltaV);
                    % Update deputy's initial conditions
                    X0_deputy(1:3) = X_deputy;
                    X0_deputy(4:6) = V_deputy + deltaV;

                t0 = t;

            case 'downarrow'
                % Increase the delta-v in the negative Y direction
                deltaV(1) = deltaV(1) - Thruster_impulse;
                deltaVfin = deltaVfin + norm(deltaV);
                    % Update deputy's initial conditions
                    X0_deputy(1:3) = X_deputy;
                    X0_deputy(4:6) = V_deputy + deltaV;

                t0 = t;

            case 'leftarrow'
                % Increase the delta-v in the negative X direction
                deltaV(2) = deltaV(2) - Thruster_impulse;
                deltaVfin = deltaVfin + norm(deltaV);
                    % Update deputy's initial conditions
                    X0_deputy(1:3) = X_deputy;
                    X0_deputy(4:6) = V_deputy + deltaV;

                t0 = t;

            case 'rightarrow'
                % Increase the delta-v in the positive X direction
                deltaV(2) = deltaV(2) + Thruster_impulse;
                deltaVfin = deltaVfin + norm(deltaV);
                    % Update deputy's initial conditions
                    X0_deputy(1:3) = X_deputy;
                    X0_deputy(4:6) = V_deputy + deltaV;

                t0 = t;

            case 'space'
               % Close the figure
               close all
               gameover = 1;
        end
    end

end