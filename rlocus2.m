function [Kq,Kal] = rlocus2(lambda_d)
    Kq0 = 0;
    Kal0 = 0;
    f = @(y) P(y, lambda_d);
    sol = fsolve(f,[Kq0 Kal0]);
    Kq = sol(1);
    Kal = sol(2);
    
end