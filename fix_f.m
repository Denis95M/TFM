function out = fix_f(A_in)
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

xd = xdf_fix(x,u,geom,I,0.4,A_in);
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

ref = zeros(12,1);
ref(1) = -75.23724;
ref(2) = -0.8813491;
ref(3) = -0.4759990;
ref(4) = 2.505734;
ref(5) = 0.3250820;
ref(6)  = 2.145926;
ref(7) = 12.62679;
ref(8) = 0.9649671;
ref(9) = 0.5809759;
ref(10) = 342.4439;
ref(11) = -266.7707;
ref(12) = 248.1241;

out = ref-xdl;

end