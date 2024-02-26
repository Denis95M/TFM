espacio_estado_cr
[filtrado, Aldf, Bldf,Cldf,Dldf] = washout(sys_ld,1);

% Definicion de la estructura de Q y de R
Q=diag([5 1 10 1 0]);
R=[1 0;0 1];
rank(obsv(sqrt(Q),Aldf))

% Obtencion de la respuesta del sistema controlado para diferentes q
q=[0 100 200 300 400 500];
t = linspace(0, 6, 6001);
u = zeros(length(t),2);
x0 = [30*pi/180 0 0 0 0];
y=zeros(length(t),length(Aldf),length(q));
y_controles=zeros(length(t),2,length(q));
K = zeros(2,5,length(q));
for i=1:length(q)
    if q(i)==0
        K(:,:,i) = zeros(2,length(Aldf));
    else
        K(:,:,i) = lqr(filtrado,q(i)*Q,R);
    end
    A_lqr = Aldf-Bldf*K(:,:,i);
    controlado = ss(A_lqr,Bldf,Cldf,Dldf);
    y(:,:,i) = lsim(controlado,u,t,x0);
    y_controles(:,:,i) = lsim(ss(0,zeros(1,length(Aldf)),[0; 0],K(:,:,i)),y(:,:,i),t,0);
end





