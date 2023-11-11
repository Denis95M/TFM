
%%%%%%% Datos vuelo de referencia%%%%%%%%
Mach_s = 0.6;                   % Mach de vuelo en la condición de referencia [-]
rho = 1.225;                    % Densidad en la condición de vuelo de referencia [kg/m2]
Ts  = 130E3;                    % Empuje en la condición de referencia [N]
T = 273.15;                     % Temperatura estática en la condición de vuelo de referencia;
V = Ms/sqrt(1.4*287*T);         % Velocidada aerodinámica del avión [m/s]

%%%%%%% Datos geométricos del avión%%%%%%%%
S = 300;                        % Superficie alar, [m2]
b = 50;                         % Envergadura alar [m]
c = 0.5;                        % Cuerda 
St = 65;                        % Superficie cola horizontal, [m2]
Sv = 106;                       % Superficie cola vertical, [m2]
tau_e = 1;                      % Efectividad timón de profundidad [-]
tau_a =1;                       % Efectividad timón lateral [-]
tau_r = 1;                      % Efectividad timón direccional [-]
lt = 30;


eta_t = 1;                   % Eficiencia aerodinámica de la cola horizontal, qt/q [-]
eta_v = 1;                   % Eficiencia aerodinámica de la cola vertical, qv/q [-]
V_t = St*lt/(S*c);

xT = 15;                     % Posición de 
zT = 5; 
eps=20*pi/180;               % Ángulo de ataque del empuje

CD0 = 0.02;
ks= 0.2;
