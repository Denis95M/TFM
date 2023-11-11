function [Ald, Bld] = lateral_matrices(CX,CY,Cl,Cn,Ix,Iz,Ixz,mu,thetas,CZs)

    %X=[beta,p,r,phi]
    %U=[delta_a,delta_r]
    %Ci=[d/dbeta, d/dp, d/dr, d/ddeltaa, d/ddeltar] i=Y,l,n
    %Cj=[d/du, d/dalpha, d/dq, d/ddeltae, d/ddalphap] j=X

    Ald = zeros(4);
    Bld = zeros(4,2);

    Ald(1,1) = CY(1)/(2*mu);
    Ald(1,2) = CX(1)/(2*mu);
    Ald(1,2) = -(2*mu-CY(3))/(2*mu);
    Ald(1,4) = -CZs/(2*mu);
    Ald(2,1) = (Cl(1)*Iz+Cn(1)*Ixz)/(Ix*Iz-Ixz^2);
    Ald(2,2) = (Cl(2)*Iz+Cn(2)*Ixz)/(Ix*Iz-Ixz^2);
    Ald(2,3) = (Cl(3)*Iz+Cn(3)*Ixz)/(Ix*Iz-Ixz^2);
    Ald(3,1) = (Cn(1)*Ix+Cl(1)*Ixz)/(Ix*Iz-Ixz^2);
    Ald(3,2) = (Cn(2)*Ix+Cl(2)*Ixz)/(Ix*Iz-Ixz^2);
    Ald(3,3) = (Cn(3)*Ix+Cl(3)*Ixz)/(Ix*Iz-Ixz^2);
    Ald(4,2) = 1;
    Ald(4,3) = tan(thetas);

    Bld(1,2) = CY(5)/(2*mu);
    Bld(2,1) = (Cl(4)*Iz+Cn(4)*Ixz)/(Ix*Iz-Ixz^2);
    Bld(2,2) = (Cl(5)*Iz+Cn(5)*Ixz)/(Ix*Iz-Ixz^2);
    Bld(3,1) = (Cn(4)*Ix+Cl(4)*Ixz)/(Ix*Iz-Ixz^2);
    Bld(3,2) = (Cn(5)*Ix+Cl(5)*Ixz)/(Ix*Iz-Ixz^2);

end