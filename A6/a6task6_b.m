clc; clear all; close all;
theRungeKutta();
figure;

h = 0.01;
x_1 = zeros(3,100/h);
x_1(:,1) = [0.001; 0.001; 0.001];
for i = 2:100/h
    x_1(:,i) = ode_Kutta(Kutta, @Rossler_attractor, h, 0, x_1(:,i-1));
end

plot3(x_1(1,:),x_1(2,:),x_1(3,:))
