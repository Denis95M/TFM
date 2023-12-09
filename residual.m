function [out] = residual(s, geom, I, xcg, h, vt, gamma, TR, psi)
    
    %TR=Turn Rate, target psi dot
    
    [x,u] = s_to_x_u(s, h, vt, psi);

    out = zeros(11,1);
    xd = xdf(x, u, geom, I, xcg);
    out(1:8) = xd(1:8);

    out(9) = TR - xd(9);

    %Giro coordinado + ritmo de ascenso
    G = TR*x(1)/9.81;
    a_tr = 1-G*tan(x(2))*sin(x(5));
    b_tr = sin(gamma)/cos(x(5));
    c_tr = 1+ G^2*cos(x(5))^2;
    tanphi = G*cos(x(5))/cos(x(2))*((a_tr-b_tr^2)+b_tr*tan(x(2))*(c_tr*(1-b_tr)^2+G^2*sin(x(5))^2)^(1/2));
    tanphi = tanphi/(a_tr^2-b_tr^2*(1+c_tr*tan(x(2))^2));
    out(10) = x(8) - atan(tanphi);
    
    %Ritmo de ascenso
    a_roc = cos(x(2))*cos(x(5));
    b_roc = sin(x(8))*sin(x(5))+cos(x(8))*sin(x(2))*cos(x(5)); 
    out(11) = x(4) - atan((a_roc*b_roc + sin(gamma)*sqrt(a_roc^2-(sin(gamma))^2+b_roc^2))/(a_roc^2-sin(gamma)^2));

end
