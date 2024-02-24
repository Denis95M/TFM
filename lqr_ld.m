clear
clc
close all

% Condicion de vuelo de referencia
vt    = 140;
h     = 1000;
gamma = 0*pi/180;
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
Cld = diag([1,-1,-1, 1]);
avion = ss(Ald, Bld, Cld, Dld);

%Inclusion del filtro washout en r
aw = -1/tauw;
bw = [0 0 1/tauw 0];
cw = [0; 0; -1; 0; 1];
dw = [eye(4); 0 0 0 0];
washout = ss(aw, bw, cw, dw);
filtrado = series(avion, washout);
[Aldf,Bldf,Cldf,Dldf] = ssdata(filtrado);

%Reordenación para poner xw el último estado
Aldf = Aldf([2 3 4 5 1],[2 3 4 5 1]);
Bldf = Bldf([2 3 4 5 1],:);
Cldf = Cldf(:,[2 3 4 5 1]);

% Aldf = [Ald zeros(4,1)];
% Aldf = [Aldf; 0 0 -1 0 -1];
% Bldf = [Bld; 0 0];
% Cldf = [Cld [0 0 -1 0]'];
% Dldf = Dld;
% filtrado = ss(Aldf,Bldf,Cldf,Dldf);
%Definicion de la estructura de Q y de R
Q=diag([2 1 2 1 0]);
R=eye(2);
rank(obsv(sqrt(Q),Aldf))

%Obtención de la respuesta del sistema controlado para diferentes q
q=[0 1000 2500 5000];
t = linspace(0, 20, 10001);
u = zeros(length(t),2);
x0 = [1 0.1 0.1 1 0];
y=zeros(length(t),length(Aldf),length(q));
y_controles=zeros(length(t),2,length(q));
for i=1:length(q)
    if q(i)==0
        K=zeros(2,length(Aldf));
    else
        K = lqr(filtrado,q(i)*Q,R);
    end
    A_lqr = Aldf-Bldf*K*Cldf;
    controlado = ss(A_lqr,Bldf,Cldf,Dldf);
    figure(i+10)
    % pzplot(controlado)
    y(:,:,i) = lsim(controlado,u,t,x0);
    y_controles(:,:,i) = lsim(ss(0,zeros(1,length(Aldf)),[0; 0],K),y(:,:,i),t,0);
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






