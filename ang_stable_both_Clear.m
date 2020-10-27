function [t,z] = ang_stable_both_Clear(wp,wq,Kp,Kq,Po,Qo,Vo,E,Xg,wo,E2,E3,tfault,tclear,tspan,z0)

    tspan1 = [tspan(1) tfault];
    tspan2 = [tfault tclear];
    tspan3 = [tclear tspan(2)];
    x01 = z0;
    [t1,x1] = ode45(@(t,x) ang_stable_both(t,x,wp,wq,Kp,Kq,Po,Qo,Vo,E,Xg,wo), tspan1, x01);
    
    x1size = size(x1);
    x02 = x1(x1size(1),:);
    [t2,x2] = ode45(@(t,x) ang_stable_both(t,x,wp,wq,Kp,Kq,Po,Qo,Vo,E2,Xg,wo), tspan2, x02);
    
    x2size = size(x2);
    x03 = x2(x2size(1),:);
    [t3,x3] = ode45(@(t,x) ang_stable_both(t,x,wp,wq,Kp,Kq,Po,Qo,Vo,E3,Xg,wo), tspan3, x03);
    
    t = [t1;t2;t3];
    z = [x1;x2;x3];
    
end