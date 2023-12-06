function [out] = xdf(x, u, geom, I, xcg)


%x=[Vt, alpha, q, theta, beta, p, r, phi, h, pow]
%u=[delta_e, delta_a, delta_r, delta_t]
%geom =[mass, S, b, c, XCG, HX]

%  [ Ixx Ixy Ixz ]
%I=[ Ixy Iyy Iyz ]
%  [ Ixz Iyz Izz ]

I_aux1 = I(1,3)*(I(1,1)-I(2,2)+I(3,3));   % XPQ
I_aux2 = I(3,3)*(I(3,3)-I(2,2))+I(1,3)^2; % XQR
I_aux3 = I(1,1)*(I(1,1)-I(2,2))+I(1,3)^2; % ZPQ
I_aux4 = I(1,1)*I(3,3)-I(1,3)^2;          % GAM
I_aux5 = I(3,3)-I(1,1);                   % YPR

[CX,CY,CZ,Cl,Cm,Cn] = coef_aero(x, u, geom, xcg);

U = x(1)*cos(x(2))*cos(x(5));
V = x(1)*sin(x(5)); 
W = x(1)*sin(x(2))*cos(x(5));

[~,a,~,rho] = atmosisa(x(9));
g = 9.81;
M=x(1)/a;
p_din = 0.5*rho*x(1)^2;

%Ecuaciones de fuerza
ud = x(7)*V - x(3)*W - g*sin(x(4)) + (p_din*geom(2)*CX + thrust(x(10),x(9),M))/geom(1);
vd = x(6)*W - x(7)*U + g*cos(x(4))*sin(x(8)) + p_din*geom(2)/geom(1)*CY;
wd = x(3)*U - x(6)*V + g*cos(x(4))*cos(x(8)) + p_din*geom(2)/geom(1)*CZ;

out(1) = (U*ud + V*vd + W*wd)/x(1); %Vt dot
out(2) = (U*wd - W*ud) / (U^2 + W^2); %alpha dot
out(5) = (x(1)*vd- V*out(1)) * cos(x(5)) / (U^2 + W^2); %Beta dot

%Ecuaciones de momento
out(3) = (I_aux5*x(6)*x(7) - I(1,3)*(x(6)^2 - x(7)^2) + p_din*geom(2)*geom(4)*Cm - x(7)*geom(6))/I(2,2); %q dot
out(6) = ( I_aux1*x(6)*x(3) - I_aux2*x(3)*x(7) + I(3,3)*p_din*geom(2)*geom(3)*Cl + I(1,3)*(p_din*geom(2)*geom(3)*Cn + x(3)*geom(6)) )/I_aux4; %p dot
out(7) = ( I_aux3*x(6)*x(3) - I_aux1*x(3)*x(7) + I(1,3)*p_din*geom(2)*geom(3)*Cl + I(1,1)*(p_din*geom(2)*geom(3)*Cn + x(3)*geom(6)) )/I_aux4; %r dot

%Relaciones angulares
out(4) = x(3)*cos(x(8)) - x(7)*sin(x(8)); %theta dot
out(8) = x(6) + tan(x(4))*(x(3)*sin(x(8)) + x(7)*cos(x(8))); %phi dot

%Relaciones lineales
out(9) = U * sin(x(4)) - V * sin(x(8))*cos(x(4)) - W * cos(x(8))*cos(x(4)); %h dot

%Potencia
out(10) = dpow(x(10), u(4)); %pow dot

end
