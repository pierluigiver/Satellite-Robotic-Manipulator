function [minimum_J, time] = ObjFun(X0)

    %This function calculates the time where the Objective function reaches
    %the minimum

    % Mean motion calculation
    Re = 6371; %km
    h = 500; %km
    rc = Re+h; %km
    mu = 398600.5; %km^3/s^2
    n = sqrt(mu/rc^3); %rad/s

    tau = 2*pi/n; %orbit period [s]
    t_max = tau/2; %constraint for the optimization problem [s]

    %State transition matrix 
    syms t real
    
    A = [0      0       0       1       0       0;
         0      0       0       0       1       0;
         0      0       0       0       0       1;
         3*n*n  0       0       0       2*n     0;
         0      0       0       -2*n    0       0;
         0      0       -n*n    0       0       0];
     
    PHI = expm(A*t);
    
    %Initial conditions necessary to reach x=y=z=0
    v0_p = PHI(1:3,4:6)\(-PHI(1:3,1:3))*X0(1:3);
    
    %First Dv to be imposed in order to get to the target 
    Dv1 = v0_p - X0(4:6);
    Dv1_fun_handle = matlabFunction(Dv1,'Vars',t);
    
    %New initial conditions
    X1 = [X0(1:3);v0_p];
    
    %Second Dv to be imposed in order to complete the rendezvous maneuver
    Dv2 = -PHI(4:6,1:6)*X1;
    Dv2_fun_handle = matlabFunction(Dv2,'Vars',t);
    
    %Time vector
    tt = (0.1:1:t_max)';
    
    %Norm of the sum that has to be minimized
    Obj_fun = norm(Dv1,2)+norm(Dv2,2);
    Obj_fun_handle = matlabFunction(Obj_fun,'Vars',t);
    Obj_vec = Obj_fun_handle(tt);
    
    %Minimum
    [minimum_J,i] = min(Obj_vec);
    time = tt(i);
    DeltaV = [Dv1_fun_handle(time) Dv2_fun_handle(time)];
    disp('DV1 [m/s] (You will see DV_x, DV_y, DV_z)')
    for i=1:3
    fprintf('%f ',DeltaV(i))
    end
    fprintf('\n')
    disp('DV2 [m/s] (You will see DV_x, DV_y, DV_z)')
    for i=4:6
    fprintf('%f ',DeltaV(i))
    end
    
    %Plot of the function in the imposed limits
    figure('Units','normalized','Position',[0 0 1 1])
    subplot(1,2,2)
    plot(time,Obj_fun_handle(time),'ro','Markersize',10)
    hold on
    plot(tt,Obj_fun_handle(tt),'-b','LineWidth',2)
    ylabel('$J = \sum_{i=1}^{2} \|\vec{\Delta V_i}\| [m/s]$', 'Interpreter', 'latex', 'FontSize', 23);
    xlabel('$t [s]$', 'Interpreter', 'latex', 'FontSize', 23);
    legend('Optimal Point')
    xlim([0 t_max])
    ylim([0 Obj_fun_handle(10)])

    % plot the trajectory   
    Phi=@(t) expm(A*t);
    for i=1:6
        X0_o(i)=X0(i);
        if i==4||i==5||i==6
            X0_o(i)=X0(i)+ DeltaV(i-3);
        end
    end
    X=@(t,X0) Phi(t)*transpose(X0_o);
    t=linspace(0,time);
    Xfinal=Phi(time)*transpose(X0_o);
    
for i=1:length(t)
  X_t(:,i)=X(t(i),X0_o);
end
subplot(1,2,1)
plot3(X_t(1,:),X_t(2,:),X_t(3,:),'k--','LineWidth',0.5,'DisplayName','Trajectory')
xlabel('x[m]')
ylabel('y[m]')
zlabel('z[m]')
grid on
hold on
quiver3(X0_o(1),X0_o(2),X0_o(3),DeltaV(1),DeltaV(2),DeltaV(3),'b','DisplayName','DV1')
hold on
quiver3(Xfinal(1),Xfinal(2),Xfinal(3),DeltaV(4),DeltaV(5),DeltaV(6),'r','DisplayName','DV2')
legend('show')
hold off

end
