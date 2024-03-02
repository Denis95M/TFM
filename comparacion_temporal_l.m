lqr_long

% Calculo de la matriz de ganancias por asignacion de polos
tau_a = 1/20.2;
[sys_long, Ala, Bla, Cla, Dla] = actuador(sys_long, tau_a, 1);
p=[-2.7+1.308i, -2.7-1.308i, -0.0665+0.0698i, -0.0665-0.0698i, -1/tau_a];
K_l_ap = place(Ala, Bla, p);    

K_l_lqr = K(:,3)';  % Seleccion de K para el q_LQR elegido

A_l_ap = Ala-Bla*K_l_ap*Cla;
A_l_lqr = Ala-Bla*K_l_lqr*Cla;

controlado_l_ap = ss(A_l_ap, Bla, Cla, Dla);
controlado_l_lqr = ss(A_l_lqr, Bla, Cla, Dla);

t_l = linspace(0, 60, 6001);
x0_l = [5 5*pi/180 1*pi/180 5*pi/180 0];

u_l = zeros(length(t),1);   % Entrada del piloto, se mantiene a cero

y_l_la   = lsim(sys_long,u_l,t_l,x0_l);
y_l_ap   = lsim(controlado_l_ap,u_l,t_l,x0_l);
y_l_lqr   = lsim(controlado_l_lqr,u_l,t_l,x0_l);

variables_l = {' Vt', ' \alpha', ' q', ' \theta'};
unidad_l = {'m/s','rad','rad/s','rad'};

FontSizeTitle=12;
FontSizeAxis=10;
LineWidth=2;

figure(1);
for j=1:4
    subplot(2, 2, j)
    title(strcat('Respuesta de ',variables_l{j}),'Fontsize',FontSizeTitle);
    hold on
    
    plot(t_l,y_l_la(:,j),'DisplayName','lazo abierto','linewidth',LineWidth); 
    plot(t_l,y_l_ap(:,j),'DisplayName','asig. polos','linewidth',LineWidth); 
    plot(t_l,y_l_lqr(:,j),'DisplayName','LQR','linewidth',LineWidth); 
        
    legend()
    set(gcf, 'Position',  [100, 100, 1000, 800]);
    a=gca;
    a.YAxis.Color = [0 0 0]; 
    a.XAxis.Color = [0 0 0];
    a.ZAxis.Color = [0 0 0];
    ylabel(strcat('Amplitud [',unidad_l(j),']'))
    xlabel('Tiempo [s]')
    grid on
end
saveas(gcf,'comparacion_l_x.jpg');

figure(2);
title('Deflexion de \delta_e','Fontsize',FontSizeTitle);
hold on

plot(t_l,y_l_ap(:,5),'DisplayName','asig. polos','linewidth',LineWidth); 
plot(t_l,y_l_lqr(:,5),'DisplayName','lqr','linewidth',LineWidth); 
   
legend()
set(gcf, 'Position',  [100, 100, 1000, 800]);
a=gca;
a.YAxis.Color = [0 0 0]; 
a.XAxis.Color = [0 0 0];
a.ZAxis.Color = [0 0 0];
ylabel(strcat('Amplitud [º]'))
xlabel('Tiempo [s]')
grid on

saveas(gcf,'comparacion_l_u.jpg');