espacio_estado_cr
[sys_la, Ala, Bla, Cla, Dla] = actuador(sys_long, 1/20.2, 1);


% Definicion de la estructura de Q y de R
R = 1;
Q = diag([1 1 1 1 0]);
Q_R = diag([0 0 0 0 R]);

rank(obsv(sqrt(Q),Ala))

% Obtencion de la respuesta del sistema controlado para diferentes q
q=[0 10 20 30 40 50];
t = linspace(0, 10, 6001);
u = zeros(length(t),1);
x0 = [5 5*pi/180 1*pi/180 5*pi/180 0];
y=zeros(length(t),length(Ala),length(q));
u_c=zeros(length(t),length(q));
K = zeros(length(Ala),length(q));
for i=1:length(q)
    if q(i)==0
        K(:,i) = zeros(1,length(Ala));
    else
        K(:,i) = lqr(sys_la,q(i)*Q+Q_R,R);
    end
    A_lqr = Ala-Bla*K(:,i)';
    controlado = ss(A_lqr,Bla,Cla,Dla);
    y(:,:,i) = lsim(controlado,u,t,x0);
    u_c(:,i) = -lsim(ss(0,zeros(1,length(Ala)),0,K(:,i)'),y(:,:,i),t,0);
end

