function [A,B,delta_conv_A,delta_conv_B,err_A,err_B] = jacob(xtrim, utrim, geom, I, xcg)
% Linealizacion del sistema alrededor de la condicion de referencia
% xtrim, utrim
    A=zeros(8,8);
    B=zeros(8,4);
    delta_conv_A = zeros(8,8);
    delta_conv_B = zeros(8,4);
    err_A = ones(8,8);
    err_B = ones(8,4);
    delta_0 = 0.05; 
    delta_min = delta_0/2^15;
    tol = 1e-8;
    
    for i=1:8
        %Calculamos A
        for j=1:8
            delta = delta_0;
            Aij=1e10;
            while err_A(i,j)>tol && delta>delta_min
                Aij_old = Aij;
                xtrim_plus     = xtrim;
                xtrim_plus(j)  = xtrim(j) + delta;
                xtrim_minus    = xtrim;
                xtrim_minus(j) = xtrim(j) - delta;
                xd_plus  = xdf(xtrim_plus,  utrim, geom, I, xcg);
                xd_minus = xdf(xtrim_minus, utrim, geom, I, xcg);
                Aij = (xd_plus(i)-xd_minus(i))/(2*delta);
                delta_conv_A(i,j) = delta;
                if min(Aij_old,Aij) == 0
                    err_A(i,j) = 0;
                    break
                end
                err_A(i,j) = abs((Aij_old-Aij)/min(Aij_old,Aij));
                delta = delta/2;
             end
            if delta<delta_min
                disp("A("+i+","+j+") no converge")
            else
                A(i,j) = Aij;
            end
        end
        %Calculamos B
        for j=1:4
            delta = delta_0;
            Bij=1e10;
            while err_B(i,j)>tol && delta>delta_min
                Bij_old = Bij;
                utrim_plus     = utrim;
                utrim_plus(j)  = utrim(j) + delta;
                utrim_minus    = utrim;
                utrim_minus(j) = utrim(j) - delta;
                xd_plus  = xdf(xtrim, utrim_plus,  geom, I, xcg);
                xd_minus = xdf(xtrim, utrim_minus, geom, I, xcg);
                Bij = (xd_plus(i)-xd_minus(i))/(2*delta);
                delta_conv_B(i,j) = delta;
                if min(Bij_old,Bij) == 0
                    err_B(i,j) = 0;
                    break
                end
                err_B(i,j) = abs((Bij_old-Bij)/min(Bij_old,Bij));
                delta = delta/2;
            end
            if delta<delta_min
                disp("B("+i+","+j+") no converge")
            else
                B(i,j) = Bij;
            end
        end
    end
end