function [filtrado, Aldf, Bldf,Cldf,Dldf] = washout(avion,tauw)
    aw = -1/tauw;
    bw = [0 0 1/tauw 0];
    cw = [0; 0; -1; 0; 1];
    dw = [eye(4); 0 0 0 0];
    washout = ss(aw, bw, cw, dw);
    filtrado = series(avion, washout);
    [Aldf,Bldf,Cldf,Dldf] = ssdata(filtrado);
    
    % Reordenacion para poner xw el ultimo estado
    Aldf = Aldf([2 3 4 5 1],[2 3 4 5 1]);
    Bldf = Bldf([2 3 4 5 1],:);
    Cldf = Cldf(:,[2 3 4 5 1]);
    filtrado = ss(Aldf,Bldf,Cldf,Dldf);

end