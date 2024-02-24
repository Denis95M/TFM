figure(30)
hold on
maxi = -50; 
pi = -0.5;
maxj= -50;
pj= -0.5;
ni=maxi/pi+1;
nj=maxj/pj+1;
is = 0:pi:maxi;
js = 0:pj:maxj;
poles = zeros(4*nj,1);
for i=1:ni              %i es el índice que cambiará color
    for j=1:nj
        pole4=P2(js(j),is(i));
        poles(j) = pole4(1);
        poles(nj+j) = pole4(2);
        poles(2*nj+j) = pole4(3);
        poles(3*nj+j) = pole4(4);
    end
    plot(real(poles), imag(poles),"o")
end
axis equal
grid on
xlabel("Re(z)")
ylabel("Im(z)")