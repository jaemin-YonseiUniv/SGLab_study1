%%% delta-deltaPrime curve without filter
function [d,dp,V] = wofilter(d_range,Tpoint,Kp,Kq,Po,Qo,Vo,E,Xg,wo)

    d = (d_range(1):(d_range(2)-d_range(1))/Tpoint:d_range(2))';
    V = (1.5*Kq*E*cos(d) - Xg + sqrt((Xg-1.5*Kq*E*cos(d)).^2 + 6*Kq*Xg*(Vo + Kq*Qo)))/3/Kq;
    dp = wo*Kp*(Po - 1.5*E*V.*sin(d)/Xg);
    
end