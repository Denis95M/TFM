function [geom, I] = F16()

    mass = 91188/9.81;      %[kg]
    b = 9.144;              %[m]
    S = 27.87;              %[m2]
    cma = 3.45;             %[m]
    xcgr = 0.35*1;
    HX = 216.9309;          %[kg/m2 s]

    geom =[mass, S, b, cma, xcgr, HX];

    Ixx = 12875;            %[kg/m2]
    Ixz = 1331;
    Iyy = 75674;            %[kg/m2]
    Izz = 85552;            %[kg/m2]

    I = [Ixx,       0,          Ixz;...
         0,         Iyy,        0;...
         Ixz,       0,          Izz];
 end