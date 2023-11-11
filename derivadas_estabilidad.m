function  [CX,CY,CZ,Cl,Cm,Cn] = derivadas_estabilidad(archivo_datos)

    %Ci=[d/dbeta, d/dp,     d/dr, d/ddeltaa, d/ddeltar ] i=Y,l,n
    %Cj=[d/du,    d/dalpha, d/dq, d/ddeltae, d/ddalphap] j=X,Z,m
    
    %%%%%%Valores en la condición de referencia%%%%%%%%%%%
    CLs = 1.2;
    CDs = 0.4;

    %%%%%%Derivadas auxiliares%%%%%%%%%%%

    dT_dM = 0;
    dCD_dM = 0;
    dCL_dM = 0;
    dCmA_dM = 0;
    dChe_dM = 0;
    dChe_dalpha = 0;
    deps_dalpha = 0; 
    C_Ts = 2*Ts/(rho*V^2*S);
    C_Tu = (Ms*2/(rho*S)*dT_dM-2C_Ts);
    C_Talpha = 0;
    CDu = Ms*dCD_dM;
    CDalpha = 2*ks*CLs*CLalpha;
    CLalpha = a_wb + at*eta_t*St/S*(1-deps_dalpha);
    CmuA = Ms*dCmA_dM;

    %%%%%%Derivadas de estabilidad longitudinales%%%%%%%%%%%

    C_Xu = C_Tu*cos(eps) - Ms*(dCD_dM);
    C_Zu = -C_Tu*sin(eps) - Ms*(dCL_dM);
    C_mu = CmuA - C_Tu*(zT*cos(eps)-xT*sin(eps));
    % C_heu = Ms * dChe_dM;

    C_Xalpha = CLs*(a-2*ks*CLalpa);
    C_Zalpha = - CLalpla - CDs;
    % C_healpha = C_healpa_prim * dChe_dalpha;

    C_Xalpha_prim = 0;
    C_Zalpha_prim = -2*eta_t*at*

    CX=[C_Xu,    C_Xalpha, 0,    C_Xdeltae, C_Xalpha_prim];
    CY=[C_Ybeta, C_Yp,     C_Yr, 0        , CY_deltar    ];
    CZ=[C_Zu,    C_Zalpha, C_Zq, C_Zdeltae, CZ_alpha_prim];
    Cl=[C_lbeta, C_lp,     C_lr, C_ldeltaa, Cl_deltar    ];
    Cm=[C_mu,    C_malpha, C_mq, C_mdeltae, Cm_alpha_prim];
    Cn=[C_nbeta, C_np,     C_nr, C_ndeltaa, Cn_deltar    ];
end



