clc; clear all; close all;

%% 2016 Quarter Car 1 DOF
ff_2016_1;
D = ff_data;
FN = @(t, D) get_forcing_function(t, D);
X0 = get_static_deflection(D.model, D.car);
DOF= size(X0, 1);
V0 = zeros(DOF, 1);
A0 = zeros(DOF, 1);
M = get_mass_matrix(D.model, D.car);
C = get_damping_matrix(D.model, D.car);
K = get_stiffness_matrix(D.model, D.car);

[T_1, X_1, V_1, A_1] = Newmark(X0, V0, A0, M, C, K, FN, D);

%% 2016 Quarter Car 2 DOF
ff_2016_2;
D = ff_data;
FN = @(t, D) get_forcing_function(t, D);
X0 = get_static_deflection(D.model, D.car);
DOF= size(X0, 1);
V0 = zeros(DOF, 1);
A0 = zeros(DOF, 1);
M = get_mass_matrix(D.model, D.car);
C = get_damping_matrix(D.model, D.car);
K = get_stiffness_matrix(D.model, D.car);

[T_2, X_2, V_2, A_2] = Newmark(X0, V0, A0, M, C, K, FN, D);

%% 2016 Half Car 2 DOF
ff_2016_3;
D = ff_data;
FN = @(t, D) get_forcing_function(t, D);
X0 = get_static_deflection(D.model, D.car);
DOF= size(X0, 1);
V0 = zeros(DOF, 1);
A0 = zeros(DOF, 1);
M = get_mass_matrix(D.model, D.car);
C = get_damping_matrix(D.model, D.car);
K = get_stiffness_matrix(D.model, D.car);

[T_3, X_3, V_3, A_3] = Newmark(X0, V0, A0, M, C, K, FN, D);

%% 2016 Half Car 4 DOF
ff_2016_4;
D = ff_data;
FN = @(t, D) get_forcing_function(t, D);
X0 = get_static_deflection(D.model, D.car);
DOF= size(X0, 1);
V0 = zeros(DOF, 1);
A0 = zeros(DOF, 1);
M = get_mass_matrix(D.model, D.car);
C = get_damping_matrix(D.model, D.car);
K = get_stiffness_matrix(D.model, D.car);


[T_4, X_4, V_4, A_4] = Newmark(X0, V0, A0, M, C, K, FN, D);

%% Display heave (in feet) in your first figure (cars 1, 2, 3, 4)
figure;
subplot(3,1,1)
plot(T_1,X_1(:,1),'black',...
    T_2,X_2(:,1),'red',...
    T_3,X_3(:,1),'blue',...
    T_4,X_4(:,1),'green');
title('Displacements: Heave of Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Displacement [ft]');
legend('1/4 car 1 DOF','1/4 car 2 DOF','1/2 car 2 DOF','1/2 car 4 DOF');

subplot(3,1,2)
plot(T_1,V_1(:,1),'black',...
    T_2,V_2(:,1),'red',...
    T_3,V_3(:,1),'blue',...
    T_4,V_4(:,1),'green');
title('Velocities: Heave of Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Velocity [ft/s]');
legend('1/4 car 1 DOF','1/4 car 2 DOF','1/2 car 2 DOF','1/2 car 4 DOF');

subplot(3,1,3)
plot(T_1,A_1(:,1),'black',...
    T_2,A_2(:,1),'red',...
    T_3,A_3(:,1),'blue',...
    T_4,A_4(:,1),'green');
title('Accelerations: Heave of Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Acceleration [ft/s^2]');
legend('1/4 car 1 DOF','1/4 car 2 DOF','1/2 car 2 DOF','1/2 car 4 DOF');

%% Display pitch (in degrees) in your second figure (cars 3, 4)
figure;
subplot(3,1,1)
plot(T_3,X_3(:,2)*180/pi,'blue',...
    T_4,X_4(:,2)*180/pi,'green');
title('Rotation: Pitch of Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Rotation [deg]');
legend('1/2 car 2 DOF','1/2 car 4 DOF');

subplot(3,1,2)
plot(T_3,V_3(:,2)*180/pi,'blue',...
    T_4,V_4(:,2)*180/pi,'green');
title('Spin: Pitch of Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Spin [deg/s]');
legend('1/2 car 2 DOF','1/2 car 4 DOF');

subplot(3,1,3)
plot(T_3,A_3(:,2)*180/pi,'blue',...
    T_4,A_4(:,2)*180/pi,'green');
title('Rate of Spin: Pitch of Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Rate of Spin [deg/s^2]');
legend('1/2 car 2 DOF','1/2 car 4 DOF');

%% Display front axle motion in your third figure (cars 2, 4)
figure;
subplot(3,1,1)
plot(T_2,X_2(:,2),'red',...
    T_4,X_4(:,3),'green');
title('Displacements: Front Axle of Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Displacement [ft]');
legend('1/4 car 2 DOF','1/2 car 4 DOF');

subplot(3,1,2)
plot(T_2,V_2(:,2),'red',...
    T_4,V_4(:,3),'green');
title('Velocities: Front Axle of Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Velocity [ft/s]');
legend('1/4 car 2 DOF','1/2 car 4 DOF');

subplot(3,1,3)
plot(T_2,A_2(:,2),'red',...
    T_4,A_4(:,3),'green');
title('Accelerations: Front Axle of Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Acceleration [ft/s^2]');
legend('1/4 car 2 DOF','1/2 car 4 DOF');

%% Display rear axle motion in your fourth figure (car 4)
figure;
subplot(3,1,1)
plot(T_4,X_4(:,4),'green');
title('Displacements: Rear Axle of Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Displacement [ft]');
legend('1/2 car 4 DOF');

subplot(3,1,2)
plot(T_4,V_4(:,4),'green');
title('Velocities: Rear Axle of Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Velocity [ft/s]');
legend('1/2 car 4 DOF');

subplot(3,1,3)
plot(T_4,A_4(:,4),'green');
title('Accelerations: Rear Axle of Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Acceleration [ft/s^2]');
legend('1/2 car 4 DOF');