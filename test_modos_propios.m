clear
clc

% Condición de vuelo para el análisis dinámico
vt    = 140;
h     = 1000;
gamma = 0*pi/180;
TR    = 0;
xcg   = 0.3;
psi   = 0;

[geom, I] = F16();

[xtrim, utrim] = trim(vt, h(end), gamma, TR, psi, xcg, geom, I);
[A, B] = jacob(xtrim, utrim, geom, I, xcg);
    
[phug,  phug_m, short,  short_m] = modos_propios_long(A);
[dutch, ~, roll_tau, ~, spiral_tau, ~] = modos_propios_lat_dir(A);

