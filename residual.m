function [out] = residual(s, geom, I, xcg, h, vt, gamma, TR, psi)
    % Calcula el error del trimado, imponiendo ligaduras de ascenso y giro
    % coordinado, der(psi)=TR, y las derivadas de las 8 primeras variables 
    % de estado sean igual a cero.
    
    % A partir de las variables de iteración del trimado se calculan las 
    % variables de estado y de entrada
    [x,u] = s_to_x_u(s, h, vt, psi);   

    out = zeros(11,1);
    
    % Se calculan las derivadas del vector de variables de estado
    xd = xdf(x, u, geom, I, xcg);

    % Se impone que las 8 primeras derivadas sean igual a cero
    out(1:8) = xd(1:8);

    out(9) = TR - xd(9);   

    % Giro coordinado, TR
    G = TR*x(1)/9.81;
    a_tr = 1-G*tan(x(2))*sin(x(5));
    b_tr = sin(gamma)/cos(x(5));
    c_tr = 1+ G^2*cos(x(5))^2;
    tanphi = G*cos(x(5))/cos(x(2))*((a_tr-b_tr^2)+b_tr*tan(x(2))*(c_tr*(1-b_tr)^2+G^2*sin(x(5))^2)^(1/2));
    tanphi = tanphi/(a_tr^2-b_tr^2*(1+c_tr*tan(x(2))^2));
    out(10) = x(8) - atan(tanphi);
    
    % Ritmo de ascenso, ROC
    a_roc = cos(x(2))*cos(x(5));
    b_roc = sin(x(8))*sin(x(5))+cos(x(8))*sin(x(2))*cos(x(5)); 
    out(11) = x(4) - atan((a_roc*b_roc + sin(gamma)*sqrt(a_roc^2-(sin(gamma))^2+b_roc^2))/(a_roc^2-sin(gamma)^2));

end
