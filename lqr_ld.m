clear
clc
close all

% Condicion de vuelo de referencia
vt    = 140;
h     = 1000;
gamma = 0;
TR    = 0;
xcg   = 0.3;
psi   = 0;

%Carga de parametros
tauw = 1;
FontSizeTitle=12;
FontSizeAxis=10;
LineWidth=2;

[geom, I] = F16();

%Obtención del modelo de avion
[xtrim, utrim] = trim(vt, h(end), gamma, TR, psi, xcg, geom, I);
[A, B] = jacob(xtrim, utrim, geom, I, xcg);

Ald = A(5:8, 5:8);
Bld = B(5:8, 2:3);
Dld = zeros(4, 2);
Cld = diag([1,1,1,1]);
avion = ss(Ald, Bld, Cld, Dld);


Q=diag([2 1 2 1]);
R=eye(2);
rank(obsv(sqrt(Q),Ald))

%Obtención de la respuesta del sistema controlado para diferentes q
q=[0 100 250 500];
t = linspace(0, 20, 10001);
u = zeros(length(t),2);
x0 = [1 0.1 0.1 1];
y=zeros(length(t),length(Ald),length(q));
y_controles=zeros(length(t),2,length(q));
for i=1:length(q)
    if q(i)==0
        K=zeros(2,length(Ald));
    else
        K = lqr(avion,q(i)*Q,R);
    end
    A_lqr = Ald-Bld*K;
    controlado = ss(A_lqr,Bld,Cld,Dld);
    figure(i+10)
    pzplot(controlado)
    y(:,:,i) = lsim(controlado,u,t,x0);
    y_controles(:,:,i) = lsim(ss(0,zeros(1,length(Ald)),[0; 0],K),y(:,:,i),t,0);
end
variables = {' \beta', ' p', ' r', ' \phi'};
figure(1);
for j=1:4
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
    ylabel('Amplitud')
    xlabel('Tiempo [s]')
end

entradas = {" \delta_a", " \delta_r"};
figure(2);
for j=1:2
    subplot(2, 1, j)
    title(strcat('Entrada de ',entradas{j},' en la respuesta para diferentes q'),'Fontsize',FontSizeTitle);
    hold on
    
    for i= 1:length(q)
        imp=plot(t,y_controles(:,j,i),'DisplayName',strcat('q=',num2str(q(i))),'linewidth',LineWidth); 
    end
    
    legend()
    set(gcf, 'Position',  [100, 100, 1000, 800]);
    a=gca;
    a.YAxis.Color = [0 0 0];
    a.XAxis.Color = [0 0 0];
    a.ZAxis.Color = [0 0 0];
    ylabel('Amplitud')
    xlabel('Tiempo [s]')
end





