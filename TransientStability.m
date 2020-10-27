clc;
close all;
clear;

%% 파라미터 설정
% V,W,A value
wo = 314;
Po_r = 2e3;
Vo_r = 100;
E_r = 100;
Qo_r = 0;
Lf_r = 1.5e-3;
Cf_r = 20e-6;
Lg_r = 12e-3;
Xg_r = wo*Lg_r;

% pu base Transform
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
% wofilter is calculate dp value with linspace d
% wofilter's input format = ([lb ub],Total_point,Kp,Kq,Po,Qo,Vo,E,Xg,wo)
% wofilter input unit => lb,ub in radian, Kp~wo in pu base
% wofilter output unit => d in radian, dp in rad/s

% y_cal = ang_init(Kp,Po,Vo,E,Xg,wo); Didn't Completed yet

% E = 1.0pu case
[d,dp,V] = wofilter([0 pi],1000,Kp,Kq,Po,Qo,Vo,E,Xg,wo);

figure(1)
plot(d,dp,'Color','k','Linewidth',1.5);
figure(2)
plot(d,V,'Color','k','Linewidth',1.5);

% E = 0.6pu case
[d,dp,V] = wofilter([0 pi],1000,Kp,Kq,Po,Qo,Vo,0.6,Xg,wo);

figure(1)
hold all
plot(d,dp,'Color','r','Linewidth',1.5);
figure(2)
hold all;
plot(d,V,'Color','r','Linewidth',1.5);

% add y(or delta_prime)=0 line
figure(1)
plot(d,zeros(1,max(size(d))),'--');

%% wp -> finite Value(filter exist only for P)
% wtfilter is calculate dpp value with meshgrid(d,dp)
% wtfilter's input format = ([lb ub],Total_point,Kp,Kq,Po,Qo,Vo,E,Xg,wo)
% wtfilter input unit => lb,ub in radian, wp in rad/s, Kp~wo in pu base
% wtfilter output unit => d in radian, dp in rad/s

% E = 1.0 pu case
wp = 2*pi*0.4;%[rad/s]
[d,dp,dpp,V] = wtfilter([0 pi],[-10,10],50,wp,Kp,Kq,Po,Qo,Vo,E,Xg,wo);

figure(3)
surf(d,dp,dpp,'FaceColor','flat');

% E = 0.6 pu case
[d,dp,dpp,V] = wtfilter([0 pi],[-10,10],50,wp,Kp,Kq,Po,Qo,Vo,0.6,Xg,wo);

figure(3)
hold all;
surf(d,dp,dpp,'FaceColor','flat');

% add xy plane(delta_double_prime = 0)
surf(d,dp,zeros(size(d)),'FaceColor','r');

%% Caculate "Response Trajectory"
% Only wp exist
tspan = [0 5];
y0 = [0.54; 0];
[t,y] = ode45(@(t,y) ang_stable(t,y,wp,Kp,Kq,Po,Qo,Vo,0.6,Xg,wo), tspan, y0);

figure(1)
hold all;
plot(y(:,1),y(:,2),'Color','b','Linewidth',2)

% Both wp, wq exist
wq = 2*pi*0.3;
tspan = [0 5];
x0 = [0.54; 0; 1.0];
[t,x] = ode45(@(t,x) ang_stable_both(t,x,wp,wq,Kp,Kq,Po,Qo,Vo,0.6,Xg,wo), tspan, x0);

figure(1)
hold all;
plot(x(:,1),x(:,2),'Color','r','Linewidth',2)

% Contingency clear event
tspan = [0 5];
z0 = [0.54; 0; 1.0];
E2 = 0.5;
E3 = 0.6;
tfault = 1.0;
tclear = 1.5;
[t,z] = ang_stable_both_Clear(wp,wq,Kp,Kq,Po,Qo,Vo,E,Xg,wo,E2,E3,tfault,tclear,tspan,z0);

figure(1)
hold all;
plot(z(:,1),z(:,2),'Color','g','Linewidth',2)


figure(3)
hold all;
plot3(d(1,:),zeros(size(d(1,:))),zeros(size(d(1,:))),'Linewidth',2,'Color','k');
