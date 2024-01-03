function [xtrim, utrim] = trim_fix(vt, h, gamma, TR, psi, xcg, geom, I, A)

    s0 = 0.1*ones(11,1);
    
    f = @(y) residual_fix(y, geom, I, xcg, h, vt, gamma, TR, psi,A);
    options = optimoptions('fsolve');
    options.MaxIterations = 10000;
    options.MaxFunctionEvaluations = 10000;
    [strim,~]=fsolve(f,s0,options);
    
    [xtrim, utrim]  = s_to_x_u(strim, h, vt, psi);

end