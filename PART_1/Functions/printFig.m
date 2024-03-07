function printFig(ICs,v0,j,tf)

% Inputs of this function are: 
%  - ICs: initial conditions vector 
%  - v0: vector where there are all the different ICs that are varying)
%  - j: index where the initial condition that is varying is located on the ICs vector)
%  - t: simulation time

    % Mean motion calculation
    Re = 6371; % [km]
    h = 500; % [km]
    rc = Re+h; % [km]
    mu = 398600.5; % [km^3]
    n = sqrt(mu/rc^3); % [1/s]
    
%     %State transition matrix 
%     A = [0      0       0       1       0       0;
%          0      0       0       0       1       0;
%          0      0       0       0       0       1;
%          3*n*n  0       0       0       2*n     0;
%          0      0       0       -2*n    0       0;
%          0      0       -n*n    0       0       0];
%     %PHI = @(t) expm(A*t);
%      
%     %Time vector
%     t_vec = 0:tf;

    figure('Position',[300 50 1000 700])
    for i = 1:length(v0)
    
        ICs(j) = v0(i);
        
%         for k = 1:length(t_vec)
%             X(k,:) = PHI(t_vec(k))*ICs;
%         end
        
%         plot(X(:,2),X(:,1),'Linewidth',1.5)

        [~, z_out] = ode45(@(t,z) ODE_func(z,n), 0:tf, ICs);
        plot(z_out(:,2),z_out(:,1),'Linewidth',1.5)
        
        hold on

    end
    
    %Plot settings
    grid on
    xlim([-3000 3000])
    ylim([-2000 2000])
    xlabel('y(m)')
    ylabel('x(m)')
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    
    switch j
        case 1
            legendString = "$x_0$ = " + string(v0) + " m";
            t = title('Motion of the Interceptor for Various $x_0$ displacement, with $y_0$='+string(ICs(2))+'[m], $z_0$='+string(ICs(3))+...
                '[m], $\dot{x_0}$='+string(ICs(4))+'[m/s], $\dot{y_0}$='+string(ICs(5))+'[m/s], $\dot{z_0}$='+string(ICs(6))+'[m/s]');
        case 2
            legendString = "$y_0$ = " + string(v0) + " m";
            t = title('Motion of the Interceptor for Various $y_0$ displacement, with $x_0$='+string(ICs(1))+'[m], $z_0$='+string(ICs(3))+...
                '[m], $\dot{x_0}$='+string(ICs(4))+'[m/s], $\dot{y_0}$='+string(ICs(5))+'[m/s], $\dot{z_0}$='+string(ICs(6))+'[m/s]');
        case 3
            legendString = "$z_0$ = " + string(v0) + " m";
            t = title('Motion of the Interceptor for Various $z_0$ displacement, with $x_0$='+string(ICs(1))+'[m], $y_0$='+string(ICs(2))+...
                '[m], $\dot{x_0}$='+string(ICs(4))+'[m/s], $\dot{y_0}$='+string(ICs(5))+'[m/s], $\dot{z_0}$='+string(ICs(6))+'[m/s]');
        case 4
            legendString = "$\dot{x_0}$ = " + string(v0) + " m/s";
            t = title('Motion of the Interceptor for $\dot{x_0}$ Variations, with $x_0$='+string(ICs(1))+'[m], $y_0$='+string(ICs(2))+...
                '[m], $z_0$='+string(ICs(3))+'[m], $\dot{y_0}$='+string(ICs(5))+'[m/s], $\dot{z_0}$='+string(ICs(6))+'[m/s]');
        case 5
            legendString = "$\dot{y_0}$ = " + string(v0) + " m/s"; 
            t = title('Motion of the Interceptor for $\dot{y_0}$ Variations, with $x_0$='+string(ICs(1))+'[m], $y_0$='+string(ICs(2))+...
                '[m], $z_0$='+string(ICs(3))+'[m], $\dot{x_0}$='+string(ICs(4))+'[m/s], $\dot{z_0}$='+string(ICs(6))+'[m/s]');
        case 6
            legendString = "$\dot{z_0}$ = " + string(v0) + " m/s";
            t = title('Motion of the Interceptor for $\dot{z_0}$ Variations, with $x_0$='+string(ICs(1))+'[m], $y_0$='+string(ICs(2))+...
                '[m], $z_0$='+string(ICs(3))+'[m], $\dot{x_0}$='+string(ICs(4))+'[m/s], $\dot{y_0}$='+string(ICs(5))+'[m/s]');
    end
    
    leg = legend(legendString);
    set(leg,'Interpreter','latex');
    set(leg,'FontSize',15);
    set(t,'Interpreter','latex');
    t.FontSize = 15;
    t.FontWeight = 'bold';
    
end