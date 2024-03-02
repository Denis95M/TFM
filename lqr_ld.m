espacio_estado_cr       % Se cargan los smas LTI del movimiento del avion

% Se obtiene el sma actuado correspondiente al mov. lateral-direccional
[sys_lda, Alda, Blda, Clda, Dlda] = actuador(sys_ld,1/20.2,2);


% Definicion de la estructura de Q y de R
Q=diag([5 1 10 1 zeros(1,2)]);
R=[1 0;0 2];

% Definicion de la condicion inicial
x0 = [30*pi/180 zeros(1,5)];

rank(obsv(sqrt(Q),Alda)) % Comprobacion de la condicion de observabilidad

% Obtencion de la respuesta del sistema controlado para diferentes q
q=[0 100 200 300 400 500];
t = linspace(0, 6, 6001);
u = zeros(length(t),2);       % Entrada del piloto para calcular respuesta
n = length(Alda);             % Numero de variables de estado
nq = length(q);               % Numero de valores de q que se comprueban
y=zeros(length(t),n,nq);      % Respuesta temporal del sistema
u_c=zeros(length(t),2,nq);    % Correccion comandada por el actuador
K = zeros(2,n,nq);            % Matrices de ganancias para cada q probada

for i=1:nq
    if q(i)==0
        K(:,:,i) = zeros(2,n);
    else
        K(:,:,i) = lqr(sys_lda,q(i)*Q,R);
    end
    A_lqr = Alda-Blda*K(:,:,i);
    controlado = ss(A_lqr,Blda,Clda,Dlda);
    y(:,:,i) = lsim(controlado,u,t,x0);
    u_c(:,:,i) = -lsim(ss(0,zeros(1,n),[0; 0],K(:,:,i)),y(:,:,i),t,0);
end





