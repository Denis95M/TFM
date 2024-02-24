clc
clear
vt    = 140;
h     = 1000;
gamma = 0;
TR    = 0;
psi   = 0;
xcg   = 0.3;

[geom, I] = F16();

[xtrim, utrim] = trim(vt, h, gamma, TR, psi, xcg, geom, I);
[A,B,dt_conv_A,dt_conv_B,err_A,err_B] = jacob(xtrim, utrim, geom, I, xcg);