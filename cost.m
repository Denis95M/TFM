function [out] = cost(s, geom, I, xcg, h, vt, gamma, TR)
    
    %TR=Turn Rate
    
    [x,u] = s_to_x_u(s, h, vt, gamma, TR);
    
    xd = xdf(x, u, geom, I, xcg);
    out = [xd(1) xd(2) xd(5) xd(6) xd(3) xd(7)];

end
