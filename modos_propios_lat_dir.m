function [dutch, dutch_mod, roll, roll_mod, spiral, spiral_mod, Dld, Vld] = modos_propios_lat_dir(A)
   
    Ald = A(5:8, 5:8);
    [Vld,Dld] = eig(Ald);
    
    mod_1_ld = Vld(:,1);
    mod_2_ld = Vld(:,2);
    mod_3_ld = Vld(:,3);
    mod_4_ld = Vld(:,4);
    
    eig_1 = Dld(1,1);
    eig_2 = Dld(2,2);
    eig_3 = Dld(3,3);
    eig_4 = Dld(4,4);
    
    if not(isreal(eig_1)) 
        dutch_mod  = mod_1_ld;
        dutch_n    = real(eig_1);
        dutch_w    = imag(eig_1);
        
        roll_mod   = mod_3_ld;
        roll_n     = eig_3;
        
        spiral_mod = mod_4_ld;
        spiral_n   = eig_4;
        
    elseif not(isreal(eig_2))
        dutch_mod  = mod_2_ld;
        dutch_n    = real(Dld(2,2));
        dutch_w    = imag(Dld(2,2));
        
        roll_mod   = mod_1_ld;
        roll_n     = eig_1;
        
        spiral_mod = mod_4_ld;
        spiral_n   = eig_4;
        
    else
        dutch_mod  = mod_3_ld;
        dutch_n    = real(Dld(3,3));
        dutch_w    = imag(Dld(3,3));
        
        roll_mod   = mod_1_ld;
        roll_n     = real(eig_1);
        
        spiral_mod = mod_2_ld;
        spiral_n   = real(eig_2);
        
    end
    
    dutch_T  = 2*pi/dutch_w;
    dutch_wn = sqrt(dutch_n^2+dutch_w^2);
    dutch_xi = -dutch_n/dutch_wn;
    dutch_t1_2 = -log(2)/dutch_n;
    roll_tau = 1/abs(roll_n);                       % constante de tiempos Tau
    roll_t1_2     = -log(2)/roll_n;                 % t_1/2
    spiral_tau = 1/abs(spiral_n);                       % constante de tiempos Tau
    spiral_t1_2   = -log(2)/spiral_n;               % t_1/2
    
    dutch    = [dutch_T dutch_xi dutch_wn dutch_t1_2];
    roll = [roll_t1_2 roll_tau];
    spiral = [spiral_t1_2 spiral_tau];


end














