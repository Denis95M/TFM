function [xtrim, utrim] = trim(vt, h, gamma, TR, psi, xcg, geom, I)

% Cálculo del trimado para la condicóon de vuelo deseada

    s0 = 0.1*ones(11,1);    % Valor inicial de las variables de iteración 
    
    % Función que se desea minimizar
    f = @(y) residual(y, geom, I, xcg, h, vt, gamma, TR, psi);
    [strim,~]=fsolve(f,s0);
    
    [xtrim, utrim]  = s_to_x_u(strim, h, vt, psi);

end