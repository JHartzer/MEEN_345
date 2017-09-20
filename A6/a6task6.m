clc; clear all; close all;
t = 0;

%% The Runge Kutta
theRungeKutta();
figure;

h = 0.05;
x_1 = zeros(3,50/h);
x_1(:,1) = [0.001; 0.001; 0.001];
for i = 2:50/h
    x_1(:,i) = ode_Kutta(Kutta, @Rossler_attractor, h, t, x_1(:,i-1));
end

h = 0.01;
x_2 = zeros(3,50/h);
x_2(:,1) = [0.001; 0.001; 0.001];
for i = 2:50/h
    x_2(:,i) = ode_Kutta(Kutta, @Rossler_attractor, h, t, x_2(:,i-1));
end

suptitle({'The Runge Kutta','',''});

subplot(1,3,1);
plot(x_1(1,:),x_1(2,:),'red',...
    x_2(1,:),x_2(2,:),'blue');
title('X vs. Y plot');
xlabel('X');
ylabel('Y');
legend('{\it h} = 0.05','{\it h} = 0.01');

subplot(1,3,2);
plot(x_1(2,:),x_1(3,:),'red',...
    x_2(2,:),x_2(3,:),'blue');
title('Y vs. Z plot');
xlabel('Y');
ylabel('Z');
legend('{\it h} = 0.05','{\it h} = 0.01');

subplot(1,3,3);
plot(x_1(3,:),x_1(1,:),'red',...
    x_2(3,:),x_2(1,:),'blue');
title('Z vs. X plot');
xlabel('Z');
ylabel('X');
legend('{\it h} = 0.05','{\it h} = 0.01');

%% Kutta Preferred
KuttaPreferred();
figure;

h = 0.05;
x_3 = zeros(3,50/h);
x_3(:,1) = [0.001; 0.001; 0.001];
for i = 2:50/h
    x_3(:,i) = ode_Kutta(Kutta, @Rossler_attractor, h, t, x_3(:,i-1));
end

h = 0.01;
x_4 = zeros(3,50/h);
x_4(:,1) = [0.001; 0.001; 0.001];
for i = 2:50/h
    x_4(:,i) = ode_Kutta(Kutta, @Rossler_attractor, h, t, x_4(:,i-1));
end

suptitle({'Kutta Preferred',' ',' '});

subplot(1,3,1);
plot(x_3(1,:),x_3(2,:),'red',...
    x_4(1,:),x_4(2,:),'blue');
title('X vs. Y plot');
xlabel('X');
ylabel('Y');
legend('{\it h} = 0.05','{\it h} = 0.01');

subplot(1,3,2);
plot(x_3(2,:),x_3(3,:),'red',...
    x_4(2,:),x_4(3,:),'blue');
title('Y vs. Z plot');
xlabel('Y');
ylabel('Z');
legend('{\it h} = 0.05','{\it h} = 0.01');

subplot(1,3,3);
plot(x_3(3,:),x_3(1,:),'red',...
    x_4(3,:),x_4(1,:),'blue');
title('Z vs. X plot');
xlabel('Z');
ylabel('X');
legend('{\it h} = 0.05','{\it h} = 0.01');
