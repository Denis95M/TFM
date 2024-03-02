lqr_long    % Se cargan las respuestas del sma para diferentes q_LQR
FontSizeTitle=12;
FontSizeAxis=10;
LineWidth=2;

variables = {' Vt', ' \alpha', ' q', ' \theta'};
unidad = {'m/s','rad','rad/s','rad'};
figure(1);
for j=1:4   % j recorre las variables de estado a pintar
    subplot(2, 2, j)
    title(strcat('Respuesta de',variables{j},' para diferentes q_{lqr}'),'Fontsize',FontSizeTitle);
    hold on
    
    for i= 1:length(q_LQR)
        plot(t,y(:,j,i),'DisplayName',strcat('q_{lqr}=',num2str(q_LQR(i))),'linewidth',LineWidth); 
    end
    
    legend()
    set(gcf, 'Position',  [100, 100, 1000, 800]);
    a=gca;
    a.YAxis.Color = [0 0 0]; 
    a.XAxis.Color = [0 0 0];
    a.ZAxis.Color = [0 0 0];
    ylabel(strcat('Amplitud [',unidad(j),']'))
    xlabel('Tiempo [s]')
    grid on
end
saveas(gcf,'x_lqr_long.jpg');

entradas = {" \delta_e", " u_e"};
figure(2);
for j=1:2
    subplot(2, 1, j)
    title(strcat('Entrada de ',entradas{j},' en la respuesta para diferentes q_{lqr}'),'Fontsize',FontSizeTitle);
    hold on
    
    for i= 1:length(q_LQR)
        if j==1 % Numero del grafico activo 
            plot(t,y(:,5,i),'DisplayName',strcat('q_{lqr}=',num2str(q_LQR(i))),'linewidth',LineWidth); 
        else
            plot(t,u_c(:,i),'DisplayName',strcat('q_{lqr}=',num2str(q_LQR(i))),'linewidth',LineWidth);
        end
    end
    
    legend()
    set(gcf, 'Position',  [100, 100, 1000, 800]);
    a=gca;
    a.YAxis.Color = [0 0 0];
    a.XAxis.Color = [0 0 0];
    a.ZAxis.Color = [0 0 0];
    a.YLim = [-5 5];
    a.XLim = [0 3];
    ylabel('Amplitud [grados]')
    xlabel('Tiempo [s]')
    grid on
end

saveas(gcf,'u_lqr_long.jpg');
