function out = CYf(beta, delta_a, delta_r)

    beta = beta*180/pi;

    out = -0.02*beta + 0.021*(delta_a/20) + 0.086*(delta_r/30.0);

end
