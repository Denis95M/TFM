clear

% Condición de vuelo para el análisis dinámico
vt    = 502*0.3048;
h     = 0;
gamma = 0;
TR    = 0;
xcg   = 0.3;

[geom, I] = F16();

[A, B] = jacob(geom, I, xcg, h, vt, gamma, TR);


% Longitudinal
Al = A(1:4, 1:4);
Bl = [B(1:4,1), B(1:4,4)];

[Vl,Dl] = eig(Al);

mod_1_l = Vl(:,1);
mod_2_l = Vl(:,3);

n_1_l = real(Dl(1,1));
n_2_l = real(Dl(3,3));

w_1_l = abs(imag(Dl(1,1)));
w_2_l = abs(imag(Dl(3,3)));

T_1_l = 2*pi/w_1_l;
T_2_l = 2*pi/w_2_l;

if T_1_l>T_2_l
    phug_mod = mod_1_l;
    phug_n = n_1_l;
    phug_w = w_1_l;
    phug_T = T_1_l;
    short_mod = mod_2_l;
    short_n = n_2_l;
    short_w = w_2_l;
    short_T = T_2_l;
else
    phug_mod = mod_2_l;
    phug_n = n_2_l;
    phug_w = w_2_l;
    phug_T = T_2_l;
    short_mod = mod_1_l;
    short_n = n_1_l;
    short_w = w_1_l;
    short_T = T_1_l;
end

phug_wn = sqrt(phug_n^2+phug_w^2);
short_wn = sqrt(short_n^2+short_w^2);

phug_xi = -phug_n/phug_wn;
short_xi = -short_n/short_wn;


%lateral-direccional
Ald = A(5:8, 5:8);
Bld = B(5:8, 2:3);
[Vld,Dld] = eig(Ald);

mod_1_ld = Vld(:,1);
mod_2_ld = Vld(:,2);
mod_3_ld = Vld(:,3);
mod_4_ld = Vld(:,4);

eig_1 = Dld(1,1);
eig_2 = Dld(2,2);
eig_3 = Dld(3,3);
eig_4 = Dld(4,4);

if not(isreal(eig_1)) 
    dutch_mod = mod_1_ld;
    dutch_n = real(eig_1);
    dutch_w = imag(eig_1);
    
    roll_mod = mod_3_ld;
    roll_n = real(eig_3);
    roll_w = imag(eig_3); 
    
    spiral_mod = mod_4_ld;
    spiral_n = real(eig_4);
    spiral_w = imag(eig_4);
    
    
elseif not(isreal(eig_2))
    dutch_mod = mod_2_ld;
    dutch_n = real(Dld(2,2));
    dutch_w = imag(Dld(2,2));
    
    roll_mod = mod_1_ld;
    roll_n = real(eig_1);
    roll_w = imag(eig_1); 
    
    spiral_mod = mod_4_ld;
    spiral_n = real(eig_4);
    spiral_w = imag(eig_4);
    
else
    dutch_mod = mod_3_ld;
    dutch_n = real(Dld(3,3));
    dutch_w = imag(Dld(3,3));
    
    roll_mod = mod_1_ld;
    roll_n = real(eig_1);
    roll_w = imag(eig_1); 
    
    spiral_mod = mod_2_ld;
    spiral_n = real(eig_2);
    spiral_w = imag(eig_2);
    
end

dutch_T = 2*pi/dutch_w;
dutch_wn = sqrt(dutch_n^2+dutch_w^2);
dutch_xi = -dutch_n/dutch_wn;

roll_tau = abs(1/roll_n);
spiral_tau = abs(1/spiral_n);


















