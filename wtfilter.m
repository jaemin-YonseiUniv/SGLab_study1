function [d,dp,dpp,V] = wtfilter(d_range,dp_range,Tpoint,wp,Kp,Kq,Po,Qo,Vo,E,Xg,wo)
    
    itv1 = (d_range(2) - d_range(1))/Tpoint;
    itv2 = (dp_range(2)-dp_range(1))/Tpoint;
    [d,dp] = meshgrid(d_range(1):itv1:d_range(2),dp_range(1):itv2:dp_range(2));
    V = (1.5*Kq*E*cos(d) - Xg + sqrt((Xg-1.5*Kq*E*cos(d)).^2 + 6*Kq*Xg*(Vo + Kq*Qo)))/3/Kq;
    dpp = -wp*dp + wp*wo*Kp*(Po - 1.5*E*V.*sin(d)/Xg);

end