function [phug, phug_mod, short, short_mod, Dl, Vl] = modos_propios_long(A)
 
    Al = A(1:4, 1:4);
        
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
        short_mod = mod_2_l;
        short_n = n_2_l;
        short_w = w_2_l;
    else
        phug_mod = mod_2_l;
        phug_n = n_2_l;
        phug_w = w_2_l;
        short_mod = mod_1_l;
        short_n = n_1_l;
        short_w = w_1_l;
    end
    
    phug_T = 2*pi/phug_w;
    phug_wn  = sqrt(phug_n^2+phug_w^2);    
    phug_xi  = -phug_n/phug_wn;
    phug  = [phug_T  phug_xi  phug_wn];
    
    short_T = 2*pi/short_w;
    short_wn = sqrt(short_n^2+short_w^2);
    short_xi = -short_n/short_wn;
    short = [short_T short_xi short_wn];
    
end














