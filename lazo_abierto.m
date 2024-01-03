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

sys_long = ss(Al,Bl,C,D); 
systf_long = tf(sys_long); 
FontSizeTitle=12;
FontSizeAxis=10;
LineWidth=2;
figure(1);
hold on
opt = RespConfig('Delay', 50);
impulse(systf_long(1,1), opt); % respuesta Vt para delta_e
yyaxis right
impulse(systf_long(2,1), opt); % respuesta alpha para delta_e  
impulse(systf_long(3,1), opt); % respuesta q para delta_e    
impulse(systf_long(4,1), opt); % respuesta theta para delta_e 
legend('Vt','alpha', 'q', 'theta')
title('Admitancia impulsional timón de profundidad','Fontsize',FontSizeTitle);
set(gcf, 'Position',  [100, 100, 1000, 800]);
set(findall(gcf,'type','line'),'linewidth',LineWidth);
set(findall(gcf, 'String', 'Time (seconds)'), 'String', 'Tiempo [s]');
saveas(gcf,['impulso_delta_e.jpg']);

figure(2)
hold on
impulseplot(systf_long(1,2), opt); % respuesta Vt para delta_t
yyaxis right
impulseplot(systf_long(2,2), opt); % respuesta alpha para delta_t    
impulseplot(systf_long(3,2), opt); % respuesta q para delta_t    
impulseplot(systf_long(4,2), opt); % respuesta theta para delta_t 
legend('Vt','alpha', 'q', 'theta')
title('Admitancia impulsional ratio de potencia','Fontsize',FontSizeTitle);
set(gcf, 'Position',  [100, 100, 1000, 800]);
set(findall(gcf,'type','line'),'linewidth',LineWidth);
set(findall(gcf, 'String', 'Time (seconds)'), 'String', 'Tiempo [s]');
saveas(gcf,['impulso_delta_t.jpg']);

%Obtencion funciones de transferencia mov. lat-dir
[num_delta_a,den_lat] = ss2tf(Ald,Bld,C,D,1);
[num_delta_r,~] = ss2tf(Ald,Bld,C,D,2);

%Respuesta entrada escalon unitario mov. lat-dir

sys_ld=ss(Ald,Bld,C,D); 
systf_ld=tf(sys_ld); 

figure(3)
hold on
impulseplot(systf_ld(1,1), opt); % respuesta beta para delta_a
impulseplot(systf_ld(2,1), opt); % respuesta p para delta_a    
impulseplot(systf_ld(3,1), opt); % respuesta r para delta_a    
impulseplot(systf_ld(4,1), opt); % respuesta phi para delta_a 
legend('beta','p', 'r', 'phi')
title('Admitancia impulsional deflexión alerones','Fontsize',FontSizeTitle);
set(gcf, 'Position',  [100, 100, 1000, 800]);
set(findall(gcf,'type','line'),'linewidth',LineWidth);
set(findall(gcf, 'String', 'Time (seconds)'), 'String', 'Tiempo [s]');
saveas(gcf,['impulso_delta_a.jpg']);

figure(4)
hold on
impulseplot(systf_ld(1,2),opt); % respuesta beta para delta_r
impulseplot(systf_ld(2,2), opt); % respuesta p para delta_r    
impulseplot(systf_ld(3,2), opt); % respuesta r para delta_r    
impulseplot(systf_ld(4,2), opt); % respuesta phi para delta_r 
legend('beta','p', 'r', 'phi')
title('Admitancia impulsional timón de dirección','Fontsize',FontSizeTitle);
set(gcf, 'Position',  [100, 100, 1000, 800]);
set(findall(gcf,'type','line'),'linewidth',LineWidth);
set(findall(gcf, 'String', 'Time (seconds)'), 'String', 'Tiempo [s]');
saveas(gcf,['impulso_delta_r.jpg']);

%Obtencion polos y ceros del sistema y su representacion
[z_delta_e, p_long, k_delta_e] = tf2zp(num_delta_e, den_long);
[z_delta_t, ~, k_delta_t] = tf2zp(num_delta_t, den_long);

% figure(5)
% zplane(num_delta_e(1,:), den_long)
% figure(6)
% zplane(num_delta_e(2,:), den_long)
% figure(7)
% zplane(num_delta_e(3,:), den_long)
% figure(8)
% zplane(num_delta_e(4,:), den_long)
% 
% [z_delta_a, p_lat, k_delta_a] = tf2zp(num_delta_a, den_lat);
% [z_delta_r, ~, k_delta_r] = tf2zp(num_delta_r, den_lat);
% 
% figure(9)
% zplane(num_delta_a(1,:), den_lat)
% figure(10)
% zplane(num_delta_a(2,:), den_lat)
% figure(11)
% zplane(num_delta_a(3,:), den_lat)
% figure(12)
% zplane(num_delta_a(4,:), den_lat)

% Diagramas de Bode
f13=figure(13);
b_long=bodeplot(sys_long);
title('Diagrama de Bode movimiento longitudinal','Fontsize',FontSizeTitle);
xlabel('Frecuencia','Fontsize',FontSizeAxis) % Etiqueta el eje horizontal
set(gcf, 'Position',  [100, 100, 1000, 800]);
set(findall(gcf,'type','line'),'linewidth',LineWidth);
p = getoptions(b_long);
p.YLabel.String = {"Magnitud", "Fase"};
setoptions(b_long,p);
f13_c = f13.Children(1).Children ;
saveas(gcf,['bode_long.jpg']);

figure(14)
b_ld = bodeplot(sys_ld);
title('Diagrama de Bode movimiento lateral y direccional','Fontsize',FontSizeTitle);
xlabel('Frecuencia','Fontsize',FontSizeAxis) % Etiqueta el eje horizontal
set(gcf, 'Position',  [100, 100, 1000, 800]);
set(findall(gcf,'type','line'),'linewidth',LineWidth);
p = getoptions(b_ld);
p.YLabel.String = {"Magnitud", "Fase"};
setoptions(b_ld,p);
saveas(gcf,['bode_lat_dir.jpg']);
