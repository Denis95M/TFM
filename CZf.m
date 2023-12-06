function out = CZf(alpha, beta, delta_e)

    alpha = alpha*180/pi;

    A = [ 0.770,  0.241, -0.100, -0.416, -0.731, -1.053,...
         -1.366, -1.646, -1.917, -2.120, -2.248, -2.229];
   
   alpha_x = -10:5:45;
   
  
   CZ_alpha = interp1(alpha_x, A, alpha);


   out = CZ_alpha*(1-beta^2) - 0.19*(delta_e/25.0);

end
