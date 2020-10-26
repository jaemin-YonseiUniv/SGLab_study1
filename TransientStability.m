clc;
close all;
clear;

%% 파라미터 선언
wo = 314;
Po_r = 2e3;
Vo_r = 100;
E_r = 100;
Qo_r = 0;
Lf_r = 1.5e-3;
Cf_r = 20e-6;
Lg_r = 12e-3;
Xg_r = wo*Lg_r;

Vbase = 100;
Sbase = 2e3;
Zbase = Vbase^2/Sbase;
Kp = 0.04;
Kq = 0.1;
d = 0:0.001:pi;
Po = Po_r/Sbase;
Qo = Qo_r/Sbase;
Vo = Vo_r/Vbase;
E = E_r/Vbase;
Xg = Xg_r/Zbase;

%% wp -> infinite(No filter)
E = 1.0;
V = (1.5*Kq*E*cos(d) - Xg + sqrt((Xg-1.5*Kq*E*cos(d)).^2 + 6*Kq*Xg*(Vo + Kq*Qo)))/3/Kq;
dp = wo*Kp*(Po - 1.5*E*V.*sin(d)/Xg);

plot(d,dp,'Color','k','Linewidth',1.5);
hold all;

E = 0.6;
V = (1.5*Kq*E*cos(d) - Xg + sqrt((Xg-1.5*Kq*E*cos(d)).^2 + 6*Kq*Xg*(Vo + Kq*Qo)))/3/Kq;
dp = wo*Kp*(Po - 1.5*E*V.*sin(d)/Xg);
plot(d,dp,'Color','r','Linewidth',1.5);

plot(d,zeros(1,max(size(d))),':');

%% wp -> finite Value(filter exist only for P)
% E = 1.0 pu case
E = 1.0;
wp = 2*pi*0.4;
[d2,dp2] = meshgrid(0:0.1:pi,-10:0.1:10);
V2 = (1.5*Kq*E*cos(d2) - Xg + sqrt((Xg-1.5*Kq*E*cos(d2)).^2 + 6*Kq*Xg*(Vo + Kq*Qo)))/3/Kq;
dpp = -wp*dp2 + wp*wo*Kp*(Po - 1.5*E*V2.*sin(d2)/Xg);

figure(2)
surf(d2,dp2,dpp);
figure(4)
surf(d2,dp2,dpp);
hold all;
plot3(d2(1,:),zeros(size(d2(1,:))),zeros(size(d2(1,:))),'Linewidth',2,'Color','black');

% E = 0.6 pu case
E = 0.6;
wp = 2*pi*0.4;
[d2,dp2] = meshgrid(0:0.1:pi,-10:0.1:10);
V2 = (1.5*Kq*E*cos(d2) - Xg + sqrt((Xg-1.5*Kq*E*cos(d2)).^2 + 6*Kq*Xg*(Vo + Kq*Qo)))/3/Kq;
dpp = -wp*dp2 + wp*wo*Kp*(Po - 1.5*E*V2.*sin(d2)/Xg);

tspan = [0 5];
y0 = [0.54; 0];
[t,y] = ode45(@(t,y) ang_stable(t,y,wp,Kp,Kq,Po,Qo,Vo,E,Xg,wo), tspan, y0);

figure(1)
plot(y(:,1),y(:,2),'Color','b','Linewidth',2)
figure(2)
hold all;
surf(d2,dp2,dpp);
dp2_size = size(dp2);
surf(d2,dp2,0.*d2+0.*dp2,'FaceColor','red');

ysize = size(y);
plot3(y(:,1),y(:,2),zeros(ysize(1),ysize(1)),'Color','b','Linewidth',2)

d2 = y(:,1);
dp2 = y(:,2);
V2 = (1.5*Kq*E*cos(d2) - Xg + sqrt((Xg-1.5*Kq*E*cos(d2)).^2 + 6*Kq*Xg*(Vo + Kq*Qo)))/3/Kq;
dpp = -wp*dp2 + wp*wo*Kp*(Po - 1.5*E*V2.*sin(d2)/Xg);
figure(4)
hold all;
plot3(d2,dp2,dpp);

% E = E/0.6;
% wp = 2*pi*0.2;
% [d2,dp2] = meshgrid(0:0.1:pi,-10:0.1:10);
% V2 = (1.5*Kq*E*cos(d2) - Xg + sqrt((Xg-1.5*Kq*E*cos(d2)).^2 + 6*Kq*Xg*(Vo + Kq*Qo)))/3/Kq;
% dpp = -wp*dp2 + wp*wo*Kp*(Po - 1.5*E*V2.*sin(d2)/Xg);
% 
% figure(3)
% hold all;
% surf(d2,dp2,dpp);

function dydt = ang_stable(t,y,wp,Kp,Kq,Po,Qo,Vo,E,Xg,wo)

dydt = zeros(2,1);
dydt(1) = y(2);
A = E/2*sin(y(1))/Xg/Kq;
B = 1.5*Kq*E*cos(y(1));
C = B - Xg +sqrt((Xg-B)^2+6*Kq*Xg*(Vo+Kq*Qo));
dydt(2) = -wp*y(2) + wp*wo*Kp*(Po-A*C);
 
end