function [x,u] = s_to_x_u(s, h, vt, psi)
    % Se asignan las variables de iteración (s) a los vectores x y u
    x = zeros(1,12);
    u = zeros(1,4);

    x(1) =  vt;
    x(2) =  s(1);
    x(3) =  s(2);
    x(4) =  s(3);
    x(5) =  s(4);
    x(6) =  s(5);
    x(7) =  s(6);
    x(8) =  s(7);
    x(9) = psi;
    x(12) =  h;
    u(1) = s(8);
    u(2) = s(9);
    u(3) = s(10);
    u(4) = s(11);
       
end