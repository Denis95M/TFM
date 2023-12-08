function [x,u] = s_to_x_u(s, h, vt, gamma, TR, xe, ye)

    x = zeros(1,12);
    u = zeros(1,4);
    u(1) = s(3);
    u(2) = s(4);
    u(3) = s(5);
    u(4) = s(6);
    x(2) =  s(1);
    x(5) =  s(2);
    
    x(1)=   vt;
    x(10) = xe;
    x(11) = ye;
    x(12) =  h;
    
    %Giro coordinado + ritmo de ascenso
    G = TR*x(1)/9.81;
    a_tr = 1-G*tan(x(2))*sin(x(5));
    b_tr = sin(gamma)/cos(x(5));
    c_tr = 1+ G^2*cos(x(5))^2;
    tanphi = G*cos(x(5))/cos(x(2))*((a_tr-b_tr^2)+b_tr*tan(x(2))*(c_tr*(1-b_tr)^2+G^2*sin(x(5))^2)^(1/2));
    tanphi = tanphi/(a_tr^2-b_tr^2*(1+c_tr*tan(x(2))^2));
    x(8) =  atan(tanphi);
    
    %Ritmo de ascenso
    a_roc = cos(x(2))*cos(x(5));
    b_roc = sin(x(8))*sin(x(5))+cos(x(8))*sin(x(2))*cos(x(5)); 
    x(4) =  atan((a_roc*b_roc + sin(gamma)*sqrt(a_roc^2-(sin(gamma))^2+b_roc^2))/(a_roc^2-sin(gamma)^2));
    
    %Relaciones cinemáticas para psi_dot=TR, phi_dot=0 y theta_dot=0
    x(3) =  TR*cos(x(4))*sin(x(8));
    x(7) =  TR*cos(x(4))*cos(x(8)); 
    x(6) = -TR*sin(x(4));
       
end