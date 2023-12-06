clc
clear
vt    = 502*0.3048;
h     = 0;
gamma = 0;
TR    = 0;
xcg   = 0.3;

[geom, I] = F16();
[A,B,dt_conv_A,dt_conv_B,err_A,err_B] = jacob(geom, I, xcg, h, vt, gamma, TR);