clc
clear
vt    = 502*0.3048;
h     = 0;
gamma = 0;
TR    = 0;
PU    = 0.1;
xcg   = -0.3;

[geom, I] = F16();
s0 = [0.3 4.1e-5 -7 -6.2e-4 0.01655 1];

f = @(y) cost(y, geom, I, xcg, h, vt, gamma, TR);
[strim,fval]=fsolve(f,s0);

[xtrim, utrim]  = s_to_x_u(strim, h, vt, gamma, TR);

 xd_trim = xdf(xtrim, utrim, geom, I, xcg);
 
 trim_V = [xtrim(1)/0.3048 xtrim(2) xtrim(5) xtrim(8) xtrim(4) xtrim(6) xtrim(3) xtrim(7) utrim(4) utrim(1) utrim(2) utrim(3)]';