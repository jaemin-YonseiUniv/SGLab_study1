function dydt = ang_stable(t,y,wp,Kp,Kq,Po,Qo,Vo,E,Xg,wo)

dydt = zeros(2,1);
dydt(1) = y(2);
A = E/2*sin(y(1))/Xg/Kq;
B = 1.5*Kq*E*cos(y(1));
C = B - Xg +sqrt((Xg-B)^2+6*Kq*Xg*(Vo+Kq*Qo));
dydt(2) = -wp*y(2) + wp*wo*Kp*(Po-A*C);
 
end