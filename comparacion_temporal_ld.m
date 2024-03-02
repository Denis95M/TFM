lqr_ld

% Calculo de la matriz de ganancias por asignacion de polos
tau_a = 1/20.2;
[sys_ld, Alda, Blda, Clda, Dlda] = actuador(sys_ld, tau_a, 2);
p=[-1.25+2.165i, -1.25-2.165i, -5, -0.067, -1/tau_a, -1/tau_a];

K_ld_ap = place(Alda, Blda, p);
K_ld_lqr = K(:,:,4);    % Seleccion de K para el q elegido

A_ld_lqr = Alda - Blda*K_ld_lqr;
A_ld_ap = Alda - Blda*K_ld_ap;

controlado_ld_lqr = ss(A_ld_lqr, Blda, Clda, Dlda);
controlado_ld_ap = ss(A_ld_ap, Blda, Clda, Dlda);

t_ld = linspace(0, 6, 6001);
x0_ld = [30*pi/180 1*pi/180 1*pi/180 5*pi/180 0 0];

u_ld = zeros(length(t),2);

y_ld_la  = lsim(sys_ld,u_ld,t_ld,x0_ld);
y_ld_lqr = lsim(controlado_ld_lqr,u_ld,t_ld,x0_ld);
y_ld_ap  = lsim(controlado_ld_ap,u_ld,t_ld,x0_ld);

y_controles_ld_ap = lsim(ss(0,zeros(1,length(Alda)),[0; 0],K_ld_ap),y_ld_ap,t,0);
y_controles_ld_lqr = lsim(ss(0,zeros(1,length(Alda)),[0; 0],K_ld_lqr),y_ld_lqr,t,0);

variables_ld = {' \beta', ' p', ' r', ' \phi', ' \delta_a', ' \delta_r'};
unidad_ld = {'rad','rad/s','rad/s','rad'};

FontSizeTitle=12;
FontSizeAxis=10;
LineWidth=2;

figure(1);
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
saveas(gcf,'comparacion_ld_x.jpg');
figure(2);
for j=1:2
    subplot(2, 1, j)
    title(strcat('Deflexion ',variables_ld{4+j}),'Fontsize',FontSizeTitle);
    hold on
    
    plot(t_ld,y_ld_ap(:,4+j),'DisplayName','asig. polos','linewidth',LineWidth); 
    plot(t_ld,y_ld_lqr(:,4+j),'DisplayName','LQR','linewidth',LineWidth); 
        
    legend()
    set(gcf, 'Position',  [100, 100, 1000, 800]);
    a=gca;
    a.YAxis.Color = [0 0 0]; 
    a.XAxis.Color = [0 0 0];
    a.ZAxis.Color = [0 0 0];
    ylabel(strcat('Amplitud [º]'))
    xlabel('Tiempo [s]')
    grid on
end
saveas(gcf,'comparacion_ld_u.jpg');

