espacio_estado_cr
[sys_lda, Alda, Blda, Clda, Dlda] = actuador(sys_ld,1/20.2);


% Definicion de la estructura de Q y de R
Q=diag([5 1 10 1 zeros(1,length(Alda)-4)]);
R=[1 0;0 1];
rank(obsv(sqrt(Q),Alda))

% Obtencion de la respuesta del sistema controlado para diferentes q
q=[0 100 200 300 400 500];
t = linspace(0, 6, 6001);
u = zeros(length(t),2);
x0 = [30*pi/180 zeros(1,length(Alda)-1)];
y=zeros(length(t),length(Alda),length(q));
y_controles=zeros(length(t),2,length(q));
K = zeros(2,length(Alda),length(q));
for i=1:length(q)
    if q(i)==0
        K(:,:,i) = zeros(2,length(Alda));
    else
        K(:,:,i) = lqr(sys_lda,q(i)*Q,R);
    end
    A_lqr = Alda-Blda*K(:,:,i);
    controlado = ss(A_lqr,Blda,Clda,Dlda);
    y(:,:,i) = lsim(controlado,u,t,x0);
    y_controles(:,:,i) = lsim(ss(0,zeros(1,length(Alda)),[0; 0],K(:,:,i)),y(:,:,i),t,0);
end





