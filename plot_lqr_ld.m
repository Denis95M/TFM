lqr_ld      % Se cargan las respuestas del sma para diferentes q
FontSizeTitle=12;
FontSizeAxis=10;
LineWidth=2;

variables = {' \beta', ' p', ' r', ' \phi'};
unidad = {'rad','rad/s','rad/s','rad'};
figure(1);
for j=1:4       % j recorre las variables de estado a pintar
    subplot(2, 2, j)
    title(strcat('Respuesta de',variables{j},' controlada para diferentes q'),'Fontsize',FontSizeTitle);
    hold on
    
    for i= 1:length(q)
        imp=plot(t,y(:,j,i),'DisplayName',strcat('q=',num2str(q(i))),'linewidth',LineWidth); 
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
saveas(gcf,'x_lqr_ld.jpg');
entradas = {" u_a", " \delta_a", " u_r", " \delta_r"};
figure(2);

for j=1:4
    subplot(2, 2, j)    % Número del gráfico activo
    title(strcat(entradas{j},' en la respuesta para diferentes q'),'Fontsize',FontSizeTitle);
    hold on
    
    for i= 1:length(q)
        if mod(j,2) == 1
            plot(t,u_c(:,(j+1)/2,i),'DisplayName',strcat('q=',num2str(q(i))),'linewidth',LineWidth); 
        else
            plot(t,y(:,4+j/2,i),'DisplayName',strcat('q=',num2str(q(i))),'linewidth',LineWidth); 
        end
    end
    
    legend()
    set(gcf, 'Position',  [100, 100, 1000, 800]);
    a=gca;
    a.YAxis.Color = [0 0 0];
    a.XAxis.Color = [0 0 0];
    a.ZAxis.Color = [0 0 0];
    ylabel('Amplitud [grados]')
    xlabel('Tiempo [s]')
    grid on
end

saveas(gcf,'u_lqr_ld.jpg');
