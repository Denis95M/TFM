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
 
%phug = [T, xi, w_n]
%phug_m = [autovec fugoide]
[phug,  phug_mod, short,  short_mod, Dl, Vl] = modos_propios_long(A);
[dutch, dutch_mod , roll_t1_2, roll_mod, spiral_t1_2, spiral_mod, Dld, Vld] = modos_propios_lat_dir(A);

