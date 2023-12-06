function [geom, I] = F16_imperial()

    mass = 20500/32.17;      %[slug]
    b = 30;  %[ft]
    S = 300;   %[ft]
    cma = 11.32; %[ft]
    xcgr = 0.35*1;
    HX = 160;  %[slug ft2/ s]

    geom =[mass, S, b, cma, xcgr, HX];

    Ixx = 9496;   %[slug/ft2]
    Ixz = 982;    %[slug/ft2]
    Iyy = 55814;  %[slug/ft2]
    Izz = 63100;  %[slug/ft2]

    I = [Ixx,       0,          Ixz;...
         0,         Iyy,        0;...
         Ixz,       0,          Izz];
 end