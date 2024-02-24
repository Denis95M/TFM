function dis = P(K, lambda_d)
    pol = zeros(5,1);
    Kal=K(1);
    Kq=K(2);
    pol(1) = 1;
    pol(2) = 2.0226-0.0018*Kal-0.1383*Kq;
    pol(3) = 2.7503-0.12828*Kal-0.116292*Kq;
    pol(4) = 0.05301-0.00259614*Kal-0.00208388*Kq;
    pol(5) = 0.0185011-0.00134668*Kal ;
    r = roots(pol);
    dis = abs(min(r-lambda_d));

end