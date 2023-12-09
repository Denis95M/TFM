clc
clear
vt    = 502*0.3048;
h     = 0;
gamma = 0;
TR    = 0;
psi   = 0;
xcg   = 0.3;

[geom, I] = F16();

[xtrim, utrim] = trim(vt, h, gamma, TR, psi, xcg, geom, I);

xd_trim = xdf(xtrim, utrim, geom, I, xcg);
 
trim_V = [xtrim(1)/0.3048 xtrim(2) xtrim(5) xtrim(8) xtrim(4) xtrim(6) xtrim(3) xtrim(7) xtrim(9) xtrim(10) xtrim(11) xtrim(12) utrim(4) utrim(1) utrim(2) utrim(3)]';
