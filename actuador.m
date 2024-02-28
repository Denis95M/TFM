function [actuado, Aa, Ba,Ca,Da] = actuador(avion,tau_a,n)      %n numero de entradas
    [A,B]=ssdata(avion);
    m = size(A, 1)+n; %numero de variables de estado
    Aa=[A B(:,1:n);zeros(n, 4) -1/tau_a*eye(n)];
    Ba=[zeros(4, n); 1/tau_a*eye(n)];
    Ca=eye(m);
    Da=zeros(m, n);
    actuado = ss(Aa,Ba,Ca,Da);

end