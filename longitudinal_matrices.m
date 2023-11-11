function [Al, Bl] = longitudinal_matrices(CX,CZ,Cm,Iy,mu,thetas,CZs)

    %X=[u,alpha,q,theta]
    %U=[delta_e]
    %Ci=[d/du, d/dalpha, d/dq, d/ddeltae, d/ddalphap]

    Al = zeros(4);
    Bl = zeros(4,1);

    Al(1,1) = (CX(1)-2*CZs*tan(thetas))/(2*mu);
    Al(1,2) = CX(2)/(2*mu);
    Al(1,4) = CZs/(2*mu);
    Al(2,1) = (CZ(1)+2*CZs)/(2*mu-CZ(5));
    Al(2,2) = CZ(2)/(2*mu-CZ(5));
    Al(2,3) = (2*mu+CZ(3))/(2*mu-CZ(5));
    Al(2,4) = CZs*tan(thetas)/(2*mu-CZ(5));
    Al(3,1) = Cm(1)/Iy+Cm(5)*(CZ(1)+2*CZs)/(2*mu-CZ(5));
    Al(3,2) = Cm(2)/Iy+Cm(5)*CZ(2)/(2*mu-CZ(5));
    Al(3,3) = Cm(3)/Iy+Cm(5)*(2*mu+CZ(3))/(2*mu-CZ(5));
    Al(3,4) = Cm(5)*CZs*tan(thetas)/(2*mu-CZ(5));
    Al(4,3) = 1;

    Bl(1) = CX(4)/(2*mu);
    Bl(2) = CZ(4)/(2*mu-CZ(5));
    Bl(3) = Cm(4)/Iy+Cm(5)*CZ(4)/(2*mu-CZ(5));

end