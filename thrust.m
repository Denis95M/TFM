function out= thrust(delta_t,h,Mach) 

% Matriz A contiene los valores de empuje del motor en regimen de ralenti.
% Matriz B contiene los valores de empuje del motor en regimen militar.
% Matriz C contiene los valores de empuje del motor en regimen de maxima potencia.

    A = [ 1060.0,   670.0,   880.0,  1140.0, 1500.0, 1860.0;...
           635.0,   425.0,   690.0,  1010.0, 1330.0, 1700.0;...
            60.0,    25.0,   345.0,   755.0, 1130.0, 1525.0;...
         -1020.0,  -710.0,  -300.0,   350.0,  910.0, 1360.0;...
         -2700.0, -1900.0, -1300.0,  -247.0,  600.0, 1100.0;...
         -3600.0, -1400.0,  -595.0,  -342.0, -200.0,  700.0];
    
    B = [12680.0,  9150.0,  6200.0,  3950.0, 2450.0, 1400.0; ... 
         12680.0,  9150.0,  6313.0,  4040.0, 2470.0, 1400.0; ...
         12610.0,  9312.0,  6610.0,  4290.0, 2600.0, 1560.0; ...
         12640.0,  9839.0,  7090.0,  4660.0, 2840.0, 1660.0; ...
         12390.0, 10176.0,  7750.0,  5320.0, 3250.0, 1930.0; ...
         11680.0,  9848.0,  8050.0,  6100.0, 3800.0, 2310.0];
    
    C = [20000.0, 15000.0, 10800.0,  7000.0, 4000.0, 2500.0;...
         21420.0, 15700.0, 11225.0,  7323.0, 4435.0, 2600.0;...
         22700.0, 16860.0, 12250.0,  8154.0, 5000.0, 2835.0;...
         24240.0, 18910.0, 13760.0,  9285.0, 5700.0, 3215.0;...
         26070.0, 21075.0, 15975.0, 11115.0, 6860.0, 3950.0;...
         28886.0, 23319.0, 18300.0, 13484.0, 8642.0, 5057.0];
   
    h = h*3.28084; %Convertimos metros a pies
    
    h_vec = 0:10000:50000;
    M_vec = 0:0.2:1;
    
    % Interpolacion 2D para cada regimen de funcionamiento del motor
    A_interp = interp2(h_vec, M_vec, A, h, Mach);
    B_interp = interp2(h_vec, M_vec, B, h, Mach);
    C_interp = interp2(h_vec, M_vec, C, h, Mach);
    
    pow_vec = 0:50:100;
    thrust_vec = [A_interp B_interp C_interp];
    
    out = interp1(pow_vec, thrust_vec, delta_t*100);
    out = out*4.44822162; %Convertimos libras a Newton
end