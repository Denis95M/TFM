clc
clear
vt    = 502*0.3048;
h     = 0;
gamma = 0;
TR    = 0.3;
psi   = 0;
xcg   = 0.3;
A     = [0.976935796588449,0.916041324742770,1.03724427059314,0.302132699689234,0.855521364474863,0.828119221759165];

[geom, I] = F16();

[xtrim, utrim] = trim_fix(vt, h, gamma, TR, psi, xcg, geom, I, A);

xd_trim = xdf_fix(xtrim, utrim, geom, I, xcg, A);
 
trim_V = [xtrim(1)/0.3048 xtrim(2) xtrim(5) xtrim(8) xtrim(4) xtrim(6) xtrim(3) xtrim(7) xtrim(9) xtrim(10) xtrim(11) xtrim(12) utrim(4) utrim(1) utrim(2) utrim(3)]';
