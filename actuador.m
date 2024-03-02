function [actuado, Aa, Ba,Ca,Da] = actuador(avion,tau_a,n)      % n numero de entradas
    % Inputs
        % avion: sma LTI que modela el movimiento del avión
        % tau_a: constante de tiempo del actuador
        % n: número de entradas al sistema que se desea usar (1 o 2)
    % Outputs
        % actuado: sma LTI que incluye el efecto de los actuador(es) en las
        % entradas
        % Aa, Ba, Ca, Da: matrices de "actuado"

    [A,B]=ssdata(avion);        % Obtención de las matrices A, B a partir del sma 
    m = size(A, 1)+n;           % Número de variables de estado
    Aa=[A B(:,1:n);zeros(n, 4) -1/tau_a*eye(n)];
    Ba=[zeros(4, n); 1/tau_a*eye(n)];
    Ca=eye(m);
    Da=zeros(m, n);
    actuado = ss(Aa,Ba,Ca,Da); 

end