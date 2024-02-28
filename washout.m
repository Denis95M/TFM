function [filtrado, Aldf, Bldf,Cldf,Dldf] = washout(avion,tauw)
    A_avion = ssdata(avion);
    n=length(A_avion);
    aw = -1/tauw;
    bw = [0 0 1/tauw zeros(1,n-3)];
    cw = [0; 0; -1; 0; 1; zeros(n-4,1)];
    dw = [eye(n); zeros(1,n)];
    washout = ss(aw, bw, cw, dw);
    filtrado = series(avion, washout);
    [Aldf,Bldf,Cldf,Dldf] = ssdata(filtrado);
    
    % Reordenacion para poner xw el ultimo estado
    Aldf = Aldf([2:length(Aldf) 1],[2:length(Aldf) 1]);
    Bldf = Bldf([2:length(Aldf) 1],:);
    Cldf = Cldf(:,[2:length(Aldf) 1]);
    filtrado = ss(Aldf,Bldf,Cldf,Dldf);

end