clc
clear

Vt = 500*0.3048; 
alpha = 0.5;
beta = -0.2;
phi = -1;
theta = 1;
psi = -1;
p = 0.7;
q = -0.8;
r = 0.9;
xe = 1000*0.3048;
ye = 900*0.3048;
h = 10000*0.3048;

delta_e = 20;
delta_a = -15;
delta_r = -20;
delta_t = 0.9;

x = [Vt, alpha, q, theta, beta, p, r, phi, psi, xe, ye, h];
u = [delta_e, delta_a, delta_r, delta_t];

[geom, I] = F16();

xd = xdf(x,u,geom,I,0.4);
xdl = zeros(12,1);
xdl(1) = xd(1)/0.3048;
xdl(2) = xd(2);
xdl(3) = xd(5);
xdl(4) = xd(8);
xdl(5) = xd(4);
xdl(7) = xd(6);
xdl(8) = xd(3);
xdl(9) = xd(7);
xdl(6)  = xd(9);
xdl(10) = xd(10)/0.3048;
xdl(11) = xd(11)/0.3048;
xdl(12) = xd(12)/0.3048;

xl = zeros(12,1);
xl(1) = x(1)/0.3048;
xl(2) = x(2);
xl(3) = x(5);
xl(4) = x(8);
xl(5) = x(4);
xl(7) = x(6);
xl(8) = x(3);
xl(9) = x(7);
xl(6)  = x(9);
xl(10) = x(10)/0.3048;
xl(11) = x(11)/0.3048;
xl(12) = x(12)/0.3048;

% xdl(1,2) = "vt";
% xdl(2,2) = "alpha";
% xdl(3,2) = "beta";
% xdl(4,2) = "phi";
% xdl(5,2) = "theta";
% xdl(7,2) = "p";
% xdl(8,2) = "q";
% xdl(9,2) = "r";
% xdl(12,2) = "h";
% xdl(13,2) = "pow";