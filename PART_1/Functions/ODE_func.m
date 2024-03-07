function dz = ODE_func(z,n)
    
    % HCW equations with ux=uy=uz=0
    
    dz =  [z(4);
           z(5);
           z(6);
           2*n*z(5) + 3*n^2*z(1);
           -2*n*z(4);
           -n^2*z(3)];
       
end

