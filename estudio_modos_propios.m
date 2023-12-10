clear
clc

% Condición de vuelo para el análisis dinámico
vt    = [130:10:180];
h     = [0:5000:25000]*0.3048;
gamma = [0:2:10]*pi/180;
TR    = 0;
xcg   = [-0.35:0.35:0.70];
psi   = 0;

[geom, I] = F16();

phug_vt  = zeros(length(vt),3);
short_vt = zeros(length(vt),3);
dutch_vt = zeros(length(vt),3);
roll_tau_vt = zeros(length(vt),1);
spiral_tau_vt = zeros(length(vt),1);


for i=1:length(vt)
    [xtrim, utrim] = trim(vt(i), h(end), gamma(1), TR, psi, xcg(2), geom, I);
    A = jacob(xtrim, utrim, geom, I, xcg(2));
    
    [phug_vt(i,:),  ~, short_vt(i,:),  ~] = modos_propios_long(A);
    [dutch_vt(i,:), ~, roll_tau_vt(i), ~, spiral_tau_vt(i), ~] = modos_propios_lat_dir(A);
end


phug_h  = zeros(length(h),3);
short_h = zeros(length(h),3);
dutch_h = zeros(length(h),3);
roll_tau_h = zeros(length(h),1);
spiral_tau_h = zeros(length(h),1);

for i=1:length(h)
    [xtrim, utrim] = trim(vt(end), h(i), gamma(1), TR, psi, xcg(2), geom, I);
    A = jacob(xtrim, utrim, geom, I, xcg(2));
    
    [phug_h(i,:),  ~, short_h(i,:),  ~] = modos_propios_long(A);
    [dutch_h(i,:), ~, roll_tau_h(i), ~, spiral_tau_h(i), ~] = modos_propios_lat_dir(A);
end

phug_gamma  = zeros(length(gamma),3);
short_gamma = zeros(length(gamma),3);
dutch_gamma = zeros(length(gamma),3);
roll_tau_gamma = zeros(length(gamma),1);
spiral_tau_gamma = zeros(length(gamma),1);

for i=1:length(gamma)
    [xtrim, utrim] = trim(vt(end), h(end), gamma(i), TR, psi, xcg(2), geom, I);
    A = jacob(xtrim, utrim, geom, I, xcg(2));
    
    [phug_gamma(i,:),  ~, short_gamma(i,:),  ~] = modos_propios_long(A);
    [dutch_gamma(i,:), ~, roll_tau_gamma(i), ~, spiral_tau_gamma(i), ~] = modos_propios_lat_dir(A);
end

phug_xcg  = zeros(length(xcg),3);
short_xcg = zeros(length(xcg),3);
dutch_xcg = zeros(length(xcg),3);
roll_tau_xcg = zeros(length(xcg),1);
spiral_tau_xcg = zeros(length(xcg),1);

for i=1:length(xcg)
    [xtrim, utrim] = trim(vt(end), h(end), gamma(1), TR, psi, xcg(i), geom, I);
    A = jacob(xtrim, utrim, geom, I, xcg(i));
    
    [phug_xcg(i,:),  ~, short_xcg(i,:),  ~] = modos_propios_long(A);
    [dutch_xcg(i,:), ~, roll_tau_xcg(i), ~, spiral_tau_xcg(i), ~] = modos_propios_lat_dir(A);
end
