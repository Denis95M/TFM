function out = dndaf(alpha, beta) 

    A = [ 0.001, -0.027, -0.017, -0.013, -0.012, -0.016,  0.001,  0.017,  0.011, 0.017,  0.008, 0.016;...
          0.002, -0.014, -0.016, -0.016, -0.014, -0.019, -0.021,  0.002,  0.012, 0.015,  0.015, 0.011;...
         -0.006, -0.008, -0.006, -0.006, -0.005, -0.008, -0.005,  0.007,  0.004, 0.007,  0.006, 0.006;...
         -0.011, -0.011, -0.010, -0.009, -0.008, -0.006,  0.000,  0.004,  0.007, 0.010,  0.004, 0.010;...
         -0.015, -0.015, -0.014, -0.012, -0.011, -0.008, -0.002,  0.002,  0.006, 0.012,  0.011, 0.011;...
         -0.024, -0.010, -0.004, -0.002, -0.001,  0.003,  0.014,  0.006, -0.001, 0.004,  0.004, 0.006;...
         -0.022,  0.002, -0.003, -0.005, -0.003, -0.001, -0.009, -0.009, -0.001, 0.003, -0.002, 0.001];
     
    alpha_x = -10:5:45;
    beta_x = -30:10:30;
    out = interp2(alpha_x, beta_x, A, alpha, beta);

end