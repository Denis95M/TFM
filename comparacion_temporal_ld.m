lqr_ld_filter

K_ld_lqr = K(:,:,4);
K_ld_ap = [0 -3.73 0 0 0 0 0; 0 0 -19.8 0 0 0 0];

A_ld_lqr = Aldf - Bldf*K_ld_lqr*Cldf;
A_ld_ap = Aldf - Bldf*K_ld_ap*Cldf;

controlado_ld_lqr = ss(A_ld_lqr, Bldf, Cldf, Dldf);
controlado_ld_ap = ss(A_ld_ap, Bldf, Cldf, Dldf);

t_ld = linspace(0, 6, 6001);
x0_ld_la = [30*pi/180 1*pi/180 1*pi/180 5*pi/180 0 0];
x0_ld_lc = [x0_ld_la 0];

u_ld = zeros(length(t),2);

y_ld_la  = lsim(sys_ld,u_ld,t_ld,x0_ld_la);
y_ld_lqr = lsim(controlado_ld_lqr,u_ld,t_ld,x0_ld_lc);
y_ld_ap  = lsim(controlado_ld_ap,u_ld,t_ld,x0_ld_lc);

y_controles_ld_ap = lsim(ss(0,zeros(1,length(Aldf)),[0; 0],K_ld_ap),y_ld_ap,t,0);
y_controles_ld_lqr = lsim(ss(0,zeros(1,length(Aldf)),[0; 0],K_ld_lqr),y_ld_lqr,t,0);

variables_ld = {' \beta', ' p', ' r', ' \phi'};
unidad_ld = {'rad','rad/s','rad/s','rad'};

FontSizeTitle=12;
FontSizeAxis=10;
LineWidth=2;

figure(2);
for j=1:4
    subplot(2, 2, j)
    title(strcat('Respuesta de ',variables_ld{j}),'Fontsize',FontSizeTitle);
    hold on
    
    plot(t_ld,y_ld_la(:,j),'DisplayName','lazo abierto','linewidth',LineWidth); 
    plot(t_ld,y_ld_ap(:,j),'DisplayName','asig. polos','linewidth',LineWidth); 
    plot(t_ld,y_ld_lqr(:,j),'DisplayName','LQR','linewidth',LineWidth); 
        
    legend()
    set(gcf, 'Position',  [00, 00, 800, 600]);
    a=gca;
    a.YAxis.Color = [0 0 0]; 
    a.XAxis.Color = [0 0 0];
    a.ZAxis.Color = [0 0 0];
    ylabel(strcat('Amplitud [',unidad_ld(j),']'))
    xlabel('Tiempo [s]')
    grid on
end

