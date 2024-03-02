tauw = 1.13;
kp = 3.73;
aw = -1/tauw;
bw = [0 1/tauw];
cw = [0;-1]; 
dw = [1 0; 0 1];
washout = ss(aw, bw, cw, dw);
Cld = [0 -1 0 0; 0 0 -1 0];
Dld = zeros(2);
avion = ss(Ald, Bld, Cld, Dld);
filtrado = series(avion, washout);
[Aldf,Bldf,Cldf,Dldf] = ssdata(filtrado);
Aldr = Aldf - Bldf(:,1)*kp*Cldf(1,:);
rlocus(Aldr, Bldf(:,2), Cldf(2,:), Dldf(2,2));

