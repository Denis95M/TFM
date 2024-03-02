% En este script se calcula el sma LTI para las condiciones de referencia
% deseadas

clear
clc
close all

% Condicion de vuelo para el analisis dinamico
vt    = 140;
h     = 1000;
gamma = 0;
TR    = 0;
xcg   = 0.3;
psi   = 0;

[geom, I] = F16();

[xtrim, utrim] = trim(vt, h(end), gamma, TR, psi, xcg, geom, I);
[A, B] = jacob(xtrim, utrim, geom, I, xcg);
Al = A(1:4, 1:4);
Bl = [B(1:4,1), B(1:4,4)];
Ald = A(5:8, 5:8);
Bld = B(5:8, 2:3);
D = zeros(4, 2);
C = eye(4);

% Desacoplamiento de mov. longitudinal y lateral-direccional

% Definicion de sistema movimiento longitudinal
sys_long = ss(Al,Bl,C,D); 
systf_long = tf(sys_long); 

% Definicion de sistema movimiento lateral direccional
sys_ld=ss(Ald,Bld,C,D); 
systf_ld=tf(sys_ld); 
