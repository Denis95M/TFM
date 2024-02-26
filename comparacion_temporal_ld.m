lqr_ld_filter
K_ld_lqr = K(:,:,4);
K_ld_ap = [0 -3.73 0 0 0; 0 0 -19.8 0 0];

K_l_ap = [0.0151  -21.7841  -25.1038   -9.1311 ; zeros(1,4)];
K_l_lqr = [0.0151  -21.7841  -25.1038   -9.1311 ; zeros(1,4)];

A_ld_lqr = Aldf - Bldf*K_ld_lqr*Cldf;
A_ld_ap = Aldf - Bldf*K_ld_ap*Cldf;
A_l_ap = Al-Bl*K_l_ap*C;
A_l_lqr = Al-Bl*K_l_lqr*C;

controlado_ld_lqr = ss(A_ld_lqr, Bldf, Cldf, Dldf);
controlado_ld_ap = ss(A_ld_ap, Bldf, Cldf, Dldf);
controlado_l_ap = ss(A_l_ap, Bl, C, D);
controlado_l_lqr = ss(A_l_lqr, Bl, C, D);

t_l = linspace(0, 600, 6001);
x0_l = [10 5*pi/180 1*pi/180 1*pi/180];

t_ld = linspace(0, 6, 6001);
x0_ld_la = [30*pi/180 1*pi/180 1*pi/180 5*pi/180];
x0_ld_lc = [x0_ld_la 0];

u = zeros(length(t),2);

y_ld_la  = lsim(sys_ld,u,t_ld,x0_ld_la);
y_ld_lqr = lsim(controlado_ld_lqr,u,t_ld,x0_ld_lc);
y_ld_ap  = lsim(controlado_ld_ap,u,t_ld,x0_ld_lc);
y_l_la   = lsim(sys_long,u,t_l,x0_l);
y_l_ap   = lsim(controlado_l_ap,u,t_l,x0_l);
y_l_lqr   = lsim(controlado_l_lqr,u,t_l,x0_l);

y_controles_l_ap = lsim(ss(0,zeros(1,length(Al)),[0; 0],K_l_ap),y_l_ap,t,0);
y_controles_l_lqr = lsim(ss(0,zeros(1,length(Al)),[0; 0],K_l_lqr),y_l_lqr,t,0);
y_controles_ld_ap = lsim(ss(0,zeros(1,length(Aldf)),[0; 0],K_ld_ap),y_ld_ap,t,0);
y_controles_ld_lqr = lsim(ss(0,zeros(1,length(Aldf)),[0; 0],K_ld_lqr),y_ld_lqr,t,0);

variables_l = {' Vt', ' \alpha', ' q', ' \theta'};
unidad_l = {'m/s','rad','rad/s','rad'};
variables_ld = {' \beta', ' p', ' r', ' \phi'};
unidad_ld = {'rad','rad/s','rad/s','rad'};

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

figure(2);
for j=1:4
    subplot(2, 2, j)
    title(strcat('Respuesta de ',variables_ld{j}),'Fontsize',FontSizeTitle);
    hold on
    
    plot(t_ld,y_ld_la(:,j),'DisplayName','lazo abierto','linewidth',LineWidth); 
    plot(t_ld,y_ld_ap(:,j),'DisplayName','asig. polos','linewidth',LineWidth); 
    plot(t_ld,y_ld_lqr(:,j),'DisplayName','LQR','linewidth',LineWidth); 
        
    legend()
    set(gcf, 'Position',  [100, 100, 1000, 800]);
    a=gca;
    a.YAxis.Color = [0 0 0]; 
    a.XAxis.Color = [0 0 0];
    a.ZAxis.Color = [0 0 0];
    ylabel(strcat('Amplitud [',unidad_ld(j),']'))
    xlabel('Tiempo [s]')
    grid on
end

figure(3);
title('Deflexión de \delta_e','Fontsize',FontSizeTitle);
hold on

plot(t_ld,y_controles_l_ap(:,1),'DisplayName','asig. polos','linewidth',LineWidth); 
   
legend()
set(gcf, 'Position',  [100, 100, 1000, 800]);
a=gca;
a.YAxis.Color = [0 0 0]; 
a.XAxis.Color = [0 0 0];
a.ZAxis.Color = [0 0 0];
ylabel(strcat('Amplitud [\delta_e]'))
xlabel('Tiempo [s]')
grid on

saveas(gcf,'x_lqr.jpg');