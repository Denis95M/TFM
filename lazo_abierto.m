clear
clc
close all
% Condicion de vuelo para el analisis dinamico
vt    = 140;
h     = 1000;
gamma = 0*pi/180;
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

%Obtencion funciones de transferencia mov. longitudinal
[num_delta_e,den_long] = ss2tf(Al,Bl,C,D,1);
[num_delta_t,~] = ss2tf(Al,Bl,C,D,2);

%Respuesta entrada escalon unitario mov. longitudinal

sys_long=ss(Al,Bl,C,D); 
systf_long=tf(sys_long); 
opt = timeoptions;
opt.Normalize = 'off';
Config1 = stepDataOptions('InputOffset',0,'stepAmplitude',5);
figure(1)
hold on
stepplot(systf_long(1,1), opt, Config1); % respuesta Vt para delta_e
yyaxis right
stepplot(systf_long(2,1), opt, Config1); % respuesta alpha para delta_e    
stepplot(systf_long(3,1), opt, Config1); % respuesta q para delta_e    
stepplot(systf_long(4,1), opt, Config1); % respuesta theta para delta_e 
legend('Vt','alpha', 'q', 'theta')

Config2 = stepDataOptions('InputOffset',0,'stepAmplitude',0.1);
figure(2)
hold on
stepplot(systf_long(1,2),opt, Config2); % respuesta Vt para delta_t
yyaxis right
stepplot(systf_long(2,2), opt, Config2); % respuesta alpha para delta_t    
stepplot(systf_long(3,2), opt, Config2); % respuesta q para delta_t    
stepplot(systf_long(4,2), opt, Config2); % respuesta theta para delta_t 
legend('Vt','alpha', 'q', 'theta')

%Obtencion funciones de transferencia mov. lat-dir
[num_delta_a,den_lat] = ss2tf(Ald,Bld,C,D,1);
[num_delta_r,~] = ss2tf(Ald,Bld,C,D,2);

%Respuesta entrada escalon unitario mov. lat-dir

sys_ld=ss(Ald,Bld,C,D); 
systf_ld=tf(sys_ld); 
opt = timeoptions;
opt.Normalize = 'off';
Config3 = stepDataOptions('InputOffset',0,'stepAmplitude',1);
figure(3)
hold on
stepplot(systf_ld(1,1), opt, Config3); % respuesta beta para delta_a
%yyaxis right
stepplot(systf_ld(2,1), opt, Config3); % respuesta p para delta_a    
stepplot(systf_ld(3,1), opt, Config3); % respuesta r para delta_a    
stepplot(systf_ld(4,1), opt, Config3); % respuesta phi para delta_a 
legend('beta','p', 'r', 'phi')

Config4 = stepDataOptions('InputOffset',0,'stepAmplitude',5);
figure(4)
hold on
stepplot(systf_ld(1,2),opt, Config4); % respuesta beta para delta_r
%yyaxis right
stepplot(systf_ld(2,2), opt, Config4); % respuesta p para delta_r    
stepplot(systf_ld(3,2), opt, Config4); % respuesta r para delta_r    
stepplot(systf_ld(4,2), opt, Config4); % respuesta phi para delta_r 
legend('beta','p', 'r', 'phi')

%Obtencion polos y ceros del sistema
[z_delta_e, p_long, k_delta_e] = tf2zp(num_delta_e, den_long);
[z_delta_t, ~, k_delta_t] = tf2zp(num_delta_t, den_long);

figure(5)
zplane(num_delta_e(1,:), den_long)
% hold on
% zplane(num_delta_e(2,:), den_long)
% zplane(num_delta_e(3,:), den_long)
% zplane(num_delta_e(4,:), den_long)

[z_delta_a, p_lat, k_delta_a] = tf2zp(num_delta_a, den_lat);
[z_delta_r, ~, k_delta_r] = tf2zp(num_delta_r, den_lat);

figure(6)
zplane(num_delta_a(1,:), den_lat)
% hold on
% zplane(num_delta_a(2,:), den_lat)
% zplane(num_delta_a(3,:), den_lat)
% zplane(num_delta_a(4,:), den_lat)
