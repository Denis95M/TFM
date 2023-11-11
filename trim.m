clear
global x u gamma
x(1)=input("Introduce Vt : ");
x(5)= input("Introduce h : ");
gamma=input("Introduce Gamma (deg.) : ")/57.29578;
output_filename= input("¿Nombre del archivo de salida? : ", "s") ;

cg= 0.25;
u=[0.1 -10 cg land];
x(2)=.1;                        % Alpha, initial guess
x(3)=x(2) +gamma;               % Theta
x(4)=0;                         % Pitch rate
x(6)=0;
s0=[u(1) u(2) x(2)];
[s,fval]=fminsearch(objetivo,s0) ;
x(2)=s(3); x(3)=s(3)+gamma;
u(1)=s(1); u(2)=s(2) ;
trim_solution=[length(x),length(u),x,u];
dlmwrite(output_filename,trim_solution);



function out = objetivo(s, filtro)
    parameter (nn=20)
    real s(*)
    common/state/x(nn),xd(nn)
    common/controls/thtl,el,ail,rdr
    thtl = s(1)
    el = s(2)
    x(2) = s(3)
    ail = s(4)
    rdr = s(5)
    x(3) = s(6)
    x(13)= tgear(thtl)
    x = ligaduras(x);
    xd = sistema(x, u);
    out = dot(xd.*filtro, xd);
end