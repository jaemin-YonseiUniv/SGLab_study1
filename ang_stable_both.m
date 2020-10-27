function dfdt = ang_stable_both(t,x,wp,wq,Kp,Kq,Po,Qo,Vo,E,Xg,wo)

    dfdt = zeros(3,1);
    dfdt(1) = x(2);
    dfdt(2) = -wp*x(2) + wo*wp*Kp*(Po-3/2*E*x(3)*sin(x(1))/Xg);
    dfdt(3) = -wq*x(3) + wq*Vo + Vo*wq*Kq*(Qo - 3/2*(x(3)^2-E*x(3)*cos(x(1)))/Xg);
    
end