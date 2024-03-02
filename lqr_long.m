espacio_estado_cr       % Se cargan los smas LTI del movimiento del avion

% Se obtiene el sma actuado correspondiente al mov. longitudinal
[sys_la, Ala, Bla, Cla, Dla] = actuador(sys_long, 1/20.2, 1); 

% Definicion de la estructura de Q y de R
R = 1;
Q = diag([0.01 20 100 1 0]);

% Definicion de la condicion inicial
x0 = [0 -5*pi/180 -1*pi/180 -5*pi/180 0];

rank(obsv(sqrt(Q),Ala))    % Comprobacion de la condicion de observabilidad

% Obtencion de la respuesta del sistema controlado para diferentes q_LQR
q_LQR=[0 1 10 100 500 1000];
t = linspace(0, 10, 6001);
u = zeros(length(t),1);     % Entrada del piloto para calcular respuesta
n = length(Ala);            % Numero de variables de estado
nq = length(q_LQR);         % Numero de valores de q_LQR que se comprueban
y=zeros(length(t),n,nq);    % Respuesta temporal del sistema
u_c=zeros(length(t),nq);    % Correccion comandada por el actuador
K = zeros(n,nq);            % Matrices de ganancias para cada q_LQR probada

for i=1:nq
    if q_LQR(i)==0
        K(:,i) = zeros(1,n);
    else
        K(:,i) = lqr(sys_la,q_LQR(i)*Q,R);
    end
    A_lqr = Ala-Bla*K(:,i)';
    controlado = ss(A_lqr,Bla,Cla,Dla);
    y(:,:,i) = lsim(controlado,u,t,x0);
    u_c(:,i) = u-lsim(ss(0,zeros(1,n),0,K(:,i)'),y(:,:,i),t,0);
end

