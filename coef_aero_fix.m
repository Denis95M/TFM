
function  [CX,CY,CZ,Cl,Cm,Cn] = coef_aero_fix(x,u,geom,xcg,A)

    % x=[Vt, alpha, q, theta, beta, p, r, phi, h, pow]
    % u=[delta_e, delta_a, delta_r, delta_t]
    % geom =[mass, S, b, c, XCGR, HX]
    % D = [CXq, CYr, CYp, CZq, Clr, Clp, Cmq, Cnr, Cnp]
   
   D = dampf(x(2));
   
   CX = CXf(x(2), u(1)) + geom(4)/(2*x(1))*x(3)*D(1);
   CY = CYf(x(5), u(2)*A(1), u(3)*A(2)) + (D(2)*x(7)+D(3)*x(6))*geom(3)/(2*x(1));
   CZ = CZf(x(2),x(5), u(1)) + geom(4)/(2*x(1))*x(3)*D(4);
   Cl = Clf(x(2),x(5)) + dldaf(x(2),x(5))*u(2)*A(5)/20 + dldrf(x(2),x(5))*u(3)*A(3)/30 + (D(5)*x(7)+D(6)*x(6))*geom(3)/(2*x(1));
   Cm = Cmf(x(2), u(1)) + geom(4)/(2*x(1))*x(3)*D(7) + CZ*(geom(5)-xcg);
   Cn = Cnf(x(2),x(5)) + dndaf(x(2),x(5))*u(2)*A(6)/20 + dndrf(x(2),x(5))*u(3)*A(4)/30 + (D(8)*x(7)+D(9)*x(6))*geom(3)/(2*x(1)) - CY*(geom(5)-xcg) * geom(4)/geom(3);
    
end



