% En este script se calcula el sma LTI para las condiciones de referencia
% deseadas

clear
clc
close all

% Se carga la condición de vuelo para el análisis dinámico
condicion_inestable

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

% Definición de sistema movimiento longitudinal
sys_long = ss(Al,Bl,C,D); 
systf_long = tf(sys_long); 

% Definición de sistema movimiento lateral direccional
sys_ld=ss(Ald,Bld,C,D); 
systf_ld=tf(sys_ld); 
