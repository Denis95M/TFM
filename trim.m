function [xtrim, utrim] = trim(vt, h, gamma, TR, psi, xcg, geom, I)

    s0 = 0.1*ones(11,1);
    
    f = @(y) residual(y, geom, I, xcg, h, vt, gamma, TR, psi);
    [strim,~]=fsolve(f,s0);
    
    [xtrim, utrim]  = s_to_x_u(strim, h, vt, psi);

end