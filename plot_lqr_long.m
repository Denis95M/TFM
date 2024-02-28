lqr_long
FontSizeTitle=12;
FontSizeAxis=10;
LineWidth=2;

variables = {' Vt', ' \alpha', ' q', ' \theta'};
unidad = {'m/s','rad','rad/s','rad'};
figure(1);
for j=1:4
    subplot(2, 2, j)
    title(strcat('Respuesta de',variables{j},' para diferentes q'),'Fontsize',FontSizeTitle);
    hold on
    
    for i= 1:length(q)
        imp=plot(t,y(:,j,i),'DisplayName',strcat('q=',num2str(q(i))),'linewidth',LineWidth); 
    end
    
    legend()
    set(gcf, 'Position',  [0, 0, 800, 600]);
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
    title(strcat('Entrada de ',entradas{j},' en la respuesta para diferentes q'),'Fontsize',FontSizeTitle);
    hold on
    
    for i= 1:length(q)
        if j==1 
            imp=plot(t,y(:,5,i),'DisplayName',strcat('q=',num2str(q(i))),'linewidth',LineWidth); 
        else
            imp=plot(t,u_c(:,i),'DisplayName',strcat('q=',num2str(q(i))),'linewidth',LineWidth);
        end
    end
    
    legend()
    set(gcf, 'Position',  [0, 0, 800, 600]);
    a=gca;
    a.YAxis.Color = [0 0 0];
    a.XAxis.Color = [0 0 0];
    a.ZAxis.Color = [0 0 0];
    ylabel('Amplitud [grados]')
    xlabel('Tiempo [s]')
    grid on
end

saveas(gcf,'u_lqr_long.jpg');
