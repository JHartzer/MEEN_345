clc; clear all; close all;

t_amb = 23;
t = 0:5:50;
T = [200, 120, 80, 60, 50, 45, 40, 35, 30, 27.5, 27.5];

dTdt = forwarddiff(t,T);

diff = T - t_amb;

scatter(diff(2:end-2),dTdt);
title('dT/dt versus T-T_{amb}');
xlabel('T-T_{amb}');
ylabel('dT/dt');
