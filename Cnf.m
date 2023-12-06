function out = Cnf(alpha, beta)

    alpha = alpha*180/pi;
    beta = beta*180/pi;

    A = [ 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000,  0.000,  0.000,  0.000;...
          0.018, 0.019, 0.018, 0.019, 0.019, 0.018, 0.013, 0.007, 0.004, -0.014, -0.017, -0.033;... 
          0.038, 0.042, 0.042, 0.042, 0.043, 0.039, 0.030, 0.017, 0.004, -0.035, -0.047, -0.057;...
          0.056, 0.057, 0.059, 0.058, 0.058, 0.053, 0.032, 0.012, 0.002, -0.046, -0.071, -0.073;...
          0.064, 0.077, 0.076, 0.074, 0.073, 0.057, 0.029, 0.007, 0.012, -0.034, -0.065, -0.041;...
          0.074, 0.086, 0.093, 0.089, 0.080, 0.062, 0.049, 0.022, 0.028, -0.012, -0.002, -0.013;...
          0.079, 0.090, 0.106, 0.106, 0.096, 0.080, 0.068, 0.030, 0.064,  0.015,  0.011, -0.001];

   alpha_x = -10:5:45;
   beta_x = 0:5:30;

   out = interp2(alpha_x, beta_x, A, alpha, abs(beta))*beta/abs(beta);

end