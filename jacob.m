function [A,B,dt_conv_A,dt_conv_B,err_A,err_B] = jacob(geom, I, xcg, h, vt, gamma, TR)

    s0 = 0.1*ones(1,6);

    f = @(y) cost(y, geom, I, xcg, h, vt, gamma, TR);
    [strim,~]=fsolve(f,s0);
    [xtrim, utrim]  = s_to_x_u(strim, h, vt, gamma, TR);

    A=zeros(8,8);
    B=zeros(8,4);
    dt_conv_A = zeros(8,8);
    dt_conv_B = zeros(8,4);
    err_A = ones(8,8);
    err_B = ones(8,4);
    dt0 = 0.1; 
    dtmin = 0.1/2^25;
    tol = 3.3e-10;
    
    for i=1:8
        %Calculamos A
        for j=1:8
            dt = dt0;
            Aij=1e10;
            while err_A(i,j)>tol && dt>dtmin
                Aij_old = Aij;
                xtrim_plus     = xtrim;
                xtrim_plus(j)  = xtrim(j) + dt;
                xtrim_minus    = xtrim;
                xtrim_minus(j) = xtrim(j) - dt;
                xd_plus  = xdf(xtrim_plus,  utrim, geom, I, xcg);
                xd_minus = xdf(xtrim_minus, utrim, geom, I, xcg);
                Aij = (xd_plus(i)-xd_minus(i))/(2*dt);
                dt_conv_A(i,j) = dt;
                if min(Aij_old,Aij) == 0
                    err_A(i,j) = 0;
                    break
                end
                err_A(i,j) = abs((Aij_old-Aij)/min(Aij_old,Aij));
                dt = dt/2;
             end
            if dt<dtmin
                disp("A("+i+","+j+") no converge")
            else
                A(i,j) = Aij;
            end
        end
        %Calculamos B
        for j=1:4
            dt = dt0;
            Bij=1e10;
            while err_B(i,j)>tol && dt>dtmin
                Bij_old = Bij;
                utrim_plus     = utrim;
                utrim_plus(j)  = utrim(j) + dt;
                utrim_minus    = utrim;
                utrim_minus(j) = utrim(j) - dt;
                xd_plus  = xdf(xtrim, utrim_plus,  geom, I, xcg);
                xd_minus = xdf(xtrim, utrim_minus, geom, I, xcg);
                Bij = (xd_plus(i)-xd_minus(i))/(2*dt);
                dt_conv_B(i,j) = dt;
                if min(Bij_old,Bij) == 0
                    err_B(i,j) = 0;
                    break
                end
                err_B(i,j) = abs((Bij_old-Bij)/min(Bij_old,Bij));
                dt = dt/2;
            end
            if dt<dtmin
                disp("B("+i+","+j+") no converge")
            else
                B(i,j) = Bij;
            end
        end
    end
end