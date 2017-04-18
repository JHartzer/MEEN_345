clc; clear all; close all;

%% 2014 Quarter Car 1 DOF
ff_2014_1;
D = ff_data;
FN = @(t, D) get_forcing_function(t, D);
X0 = get_static_deflection(D.model, D.car);
DOF= size(X0, 1);
V0 = zeros(DOF, 1);
A0 = zeros(DOF, 1);
M = get_mass_matrix(D.model, D.car);
C = get_damping_matrix(D.model, D.car);
K = get_stiffness_matrix(D.model, D.car);

[T_1N, X_1N, V_1N, A_1N] = Newmark(X0, V0, A0, M, C, K, FN, D);
[T_1B, X_1B, V_1B, A_1B] = Beeman(X0, V0, zeros(DOF, 3), M, C, K, FN, D);

%% 2014 Quarter Car 2 DOF
ff_2014_2;
D = ff_data;
FN = @(t, D) get_forcing_function(t, D);
X0 = get_static_deflection(D.model, D.car);
DOF= size(X0, 1);
V0 = zeros(DOF, 1);
A0 = zeros(DOF, 1);
M = get_mass_matrix(D.model, D.car);
C = get_damping_matrix(D.model, D.car);
K = get_stiffness_matrix(D.model, D.car);

[T_2N, X_2N, V_2N, A_2N] = Newmark(X0, V0, A0, M, C, K, FN, D);
[T_2B, X_2B, V_2B, A_2B] = Beeman(X0, V0, zeros(DOF, 3), M, C, K, FN, D);

%% 2014 Half Car 2 DOF
ff_2014_3;
D = ff_data;
FN = @(t, D) get_forcing_function(t, D);
X0 = get_static_deflection(D.model, D.car);
DOF= size(X0, 1);
V0 = zeros(DOF, 1);
A0 = zeros(DOF, 1);
M = get_mass_matrix(D.model, D.car);
C = get_damping_matrix(D.model, D.car);
K = get_stiffness_matrix(D.model, D.car);

[T_3N, X_3N, V_3N, A_3N] = Newmark(X0, V0, A0, M, C, K, FN, D);
[T_3B, X_3B, V_3B, A_3B] = Beeman(X0, V0, zeros(DOF, 3), M, C, K, FN, D);

%% 2014 Half Car 4 DOF
ff_2014_4;
D = ff_data;
FN = @(t, D) get_forcing_function(t, D);
X0 = get_static_deflection(D.model, D.car);
DOF= size(X0, 1);
V0 = zeros(DOF, 1);
A0 = zeros(DOF, 1);
M = get_mass_matrix(D.model, D.car);
C = get_damping_matrix(D.model, D.car);
K = get_stiffness_matrix(D.model, D.car);


[T_4N, X_4N, V_4N, A_4N] = Newmark(X0, V0, A0, M, C, K, FN, D);
[T_4B, X_4B, V_4B, A_4B] = Beeman(X0, V0, zeros(DOF, 3), M, C, K, FN, D);

%% 2014 Full Car 3 DOF
ff_2014_5;
D = ff_data;
FN = @(t, D) get_forcing_function(t, D);
X0 = get_static_deflection(D.model, D.car);
DOF= size(X0, 1);
V0 = zeros(DOF, 1);
A0 = zeros(DOF, 1);
M = get_mass_matrix(D.model, D.car);
C = get_damping_matrix(D.model, D.car);
K = get_stiffness_matrix(D.model, D.car);


[T_5N, X_5N, V_5N, A_5N] = Newmark(X0, V0, A0, M, C, K, FN, D);
[T_5B, X_5B, V_5B, A_5B] = Beeman(X0, V0, zeros(DOF, 3), M, C, K, FN, D);

%% 2014 Full Car 7 DOF
ff_2014_6;
D = ff_data;
FN = @(t, D) get_forcing_function(t, D);
X0 = get_static_deflection(D.model, D.car);
DOF= size(X0, 1);
V0 = zeros(DOF, 1);
A0 = zeros(DOF, 1);
M = get_mass_matrix(D.model, D.car);
C = get_damping_matrix(D.model, D.car);
K = get_stiffness_matrix(D.model, D.car);


[T_6N, X_6N, V_6N, A_6N] = Newmark(X0, V0, A0, M, C, K, FN, D);
[T_6B, X_6B, V_6B, A_6B] = Beeman(X0, V0, zeros(DOF, 3), M, C, K, FN, D);

%% Display heave (in feet) in your first figure (cars 1, 2, 3, 4, 5, 6) - Newmark
figure;
subplot(3,1,1)
plot(T_1N,X_1N(:,1),'black',...
    T_2N,X_2N(:,1),'red',...
    T_3N,X_3N(:,1),'blue',...
    T_4N,X_4N(:,1),'green',...
    T_5N,X_5N(:,1),'cyan',...
    T_6N,X_6N(:,1),'magenta');
title('Displacements: Heave of 2014 Car Hitting a Speed Bump - Newmark');
xlabel('Time [s]');
ylabel('Displacement [ft]');
legend('1/4 car 1 DOF','1/4 car 2 DOF',...
    '1/2 car 2 DOF','1/2 car 4 DOF',...
    'Full car 3 DOF','Full car 7 DOF');

subplot(3,1,2)
plot(T_1N,V_1N(:,1),'black',...
    T_2N,V_2N(:,1),'red',...
    T_3N,V_3N(:,1),'blue',...
    T_4N,V_4N(:,1),'green',...
    T_5N,V_5N(:,1),'cyan',...
    T_6N,V_6N(:,1),'magenta');
title('Velocities: Heave of 2014 Car Hitting a Speed Bump - Newmark');
xlabel('Time [s]');
ylabel('Velocity [ft/s]');
legend('1/4 car 1 DOF','1/4 car 2 DOF',...
    '1/2 car 2 DOF','1/2 car 4 DOF',...
    'Full car 3 DOF','Full car 7 DOF');

subplot(3,1,3)
plot(T_1N,A_1N(:,1),'black',...
    T_2N,A_2N(:,1),'red',...
    T_3N,A_3N(:,1),'blue',...
    T_4N,A_4N(:,1),'green',...
    T_5N,A_5N(:,1),'cyan',...
    T_6N,A_6N(:,1),'magenta');
title('Accelerations: Heave of 2014 Car Hitting a Speed Bump - Newmark');
xlabel('Time [s]');
ylabel('Acceleration [ft/s^2]');
legend('1/4 car 1 DOF','1/4 car 2 DOF',...
    '1/2 car 2 DOF','1/2 car 4 DOF',...
    'Full car 3 DOF','Full car 7 DOF');

%% Display pitch (in degrees) in your second figure (cars 3, 4, 5, 6) - Newmark
figure;
subplot(3,1,1)
plot(T_3N,X_3N(:,2)*180/pi,'blue',...
    T_4N,X_4N(:,2)*180/pi,'green',...
    T_5N,X_5N(:,2)*180/pi,'cyan',...
    T_6N,X_6N(:,2)*180/pi,'magenta');
title('Rotation: Pitch of 2014 Car Hitting a Speed Bump - Newmark');
xlabel('Time [s]');
ylabel('Rotation [deg]');
legend('1/2 car 2 DOF','1/2 car 4 DOF',...
    'Full car 3 DOF','Full car 7 DOF');

subplot(3,1,2)
plot(T_3N,V_3N(:,2)*180/pi,'blue',...
    T_4N,V_4N(:,2)*180/pi,'green',...
    T_5N,V_5N(:,2)*180/pi,'cyan',...
    T_6N,V_6N(:,2)*180/pi,'magenta');
title('Spin: Pitch of 2014 Car Hitting a Speed Bump - Newmark');
xlabel('Time [s]');
ylabel('Spin [deg/s]');
legend('1/2 car 2 DOF','1/2 car 4 DOF',...
    'Full car 3 DOF','Full car 7 DOF');

subplot(3,1,3)
plot(T_3N,A_3N(:,2)*180/pi,'blue',...
    T_4N,A_4N(:,2)*180/pi,'green',...
    T_5N,A_5N(:,2)*180/pi,'cyan',...
    T_6N,A_6N(:,2)*180/pi,'magenta');
title('Rate of Spin: Pitch of 2014 Car Hitting a Speed Bump - Newmark');
xlabel('Time [s]');
ylabel('Rate of Spin [deg/s^2]');
legend('1/2 car 2 DOF','1/2 car 4 DOF',...
    'Full car 3 DOF','Full car 7 DOF');

%% Display roll (in degrees) in your second figure (cars 5, 6) - Newmark
figure;
subplot(3,1,1)
plot(T_5N,X_5N(:,3)*180/pi,'cyan',...
    T_6N,X_6N(:,3)*180/pi,'magenta');
title('Rotation: Roll of 2014 Car Hitting a Speed Bump - Newmark');
xlabel('Time [s]');
ylabel('Rotation [deg]');
legend('Full car 3 DOF','Full car 7 DOF');

subplot(3,1,2)
plot(T_5N,V_5N(:,3)*180/pi,'cyan',...
    T_6N,V_6N(:,3)*180/pi,'magenta');
title('Spin: Roll of 2014 Car Hitting a Speed Bump - Newmark');
xlabel('Time [s]');
ylabel('Spin [deg/s]');
legend('Full car 3 DOF','Full car 7 DOF');

subplot(3,1,3)
plot(T_5N,A_5N(:,3)*180/pi,'cyan',...
    T_6N,A_6N(:,3)*180/pi,'magenta');
title('Rate of Spin: Roll of 2014 Car Hitting a Speed Bump - Newmark');
xlabel('Time [s]');
ylabel('Rate of Spin [deg/s^2]');
legend('Full car 3 DOF','Full car 7 DOF');

%% Display heave (in feet) in your first figure (cars 1, 2, 3, 4, 5, 6) - Beeman
figure;
subplot(3,1,1)
plot(T_1B,X_1B(:,1),'black',...
    T_2B,X_2B(:,1),'red',...
    T_3B,X_3B(:,1),'blue',...
    T_4B,X_4B(:,1),'green',...
    T_5B,X_5B(:,1),'cyan',...
    T_6B,X_6B(:,1),'magenta');
title('Displacements: Heave of 2014 Car Hitting a Speed Bump - Beeman');
xlabel('Time [s]');
ylabel('Displacement [ft]');
legend('1/4 car 1 DOF','1/4 car 2 DOF',...
    '1/2 car 2 DOF','1/2 car 4 DOF',...
    'Full car 3 DOF','Full car 7 DOF');

subplot(3,1,2)
plot(T_1B,V_1B(:,1),'black',...
    T_2B,V_2B(:,1),'red',...
    T_3B,V_3B(:,1),'blue',...
    T_4B,V_4B(:,1),'green',...
    T_5B,V_5B(:,1),'cyan',...
    T_6B,V_6B(:,1),'magenta');
title('Velocities: Heave of 2014 Car Hitting a Speed Bump - Beeman');
xlabel('Time [s]');
ylabel('Velocity [ft/s]');
legend('1/4 car 1 DOF','1/4 car 2 DOF',...
    '1/2 car 2 DOF','1/2 car 4 DOF',...
    'Full car 3 DOF','Full car 7 DOF');

subplot(3,1,3)
plot(T_1B,A_1B(3:end,1),'black',...
    T_2B,A_2B(3:end,1),'red',...
    T_3B,A_3B(3:end,1),'blue',...
    T_4B,A_4B(3:end,1),'green',...
    T_5B,A_5B(3:end,1),'cyan',...
    T_6B,A_6B(3:end,1),'magenta');
title('Accelerations: Heave of 2014 Car Hitting a Speed Bump - Beeman');
xlabel('Time [s]');
ylabel('Acceleration [ft/s^2]');
legend('1/4 car 1 DOF','1/4 car 2 DOF',...
    '1/2 car 2 DOF','1/2 car 4 DOF',...
    'Full car 3 DOF','Full car 7 DOF');

%% Display pitch (in degrees) in your second figure (cars 3, 4, 5, 6) - Beeman
figure;
subplot(3,1,1)
plot(T_3B,X_3B(:,2)*180/pi,'blue',...
    T_4B,X_4B(:,2)*180/pi,'green',...
    T_5B,X_5B(:,2)*180/pi,'cyan',...
    T_6B,X_6B(:,2)*180/pi,'magenta');
title('Rotation: Pitch of 2014 Car Hitting a Speed Bump - Beeman');
xlabel('Time [s]');
ylabel('Rotation [deg]');
legend('1/2 car 2 DOF','1/2 car 4 DOF',...
    'Full car 3 DOF','Full car 7 DOF');

subplot(3,1,2)
plot(T_3B,V_3B(:,2)*180/pi,'blue',...
    T_4B,V_4B(:,2)*180/pi,'green',...
    T_5B,V_5B(:,2)*180/pi,'cyan',...
    T_6B,V_6B(:,2)*180/pi,'magenta');
title('Spin: Pitch of 2014 Car Hitting a Speed Bump - Beeman');
xlabel('Time [s]');
ylabel('Spin [deg/s]');
legend('1/2 car 2 DOF','1/2 car 4 DOF',...
    'Full car 3 DOF','Full car 7 DOF');

subplot(3,1,3)
plot(T_3B,A_3B(3:end,2)*180/pi,'blue',...
    T_4B,A_4B(3:end,2)*180/pi,'green',...
    T_5B,A_5B(3:end,2)*180/pi,'cyan',...
    T_6B,A_6B(3:end,2)*180/pi,'magenta');
title('Rate of Spin: Pitch of 2014 Car Hitting a Speed Bump - Beeman');
xlabel('Time [s]');
ylabel('Rate of Spin [deg/s^2]');
legend('1/2 car 2 DOF','1/2 car 4 DOF',...
    'Full car 3 DOF','Full car 7 DOF');

%% Display roll (in degrees) in your second figure (cars 5, 6) - Beeman
figure;
subplot(3,1,1)
plot(T_5B,X_5B(:,3)*180/pi,'cyan',...
    T_6B,X_6B(:,3)*180/pi,'magenta');
title('Rotation: Roll of 2014 Car Hitting a Speed Bump - Beeman');
xlabel('Time [s]');
ylabel('Rotation [deg]');
legend('Full car 3 DOF','Full car 7 DOF');

subplot(3,1,2)
plot(T_5B,V_5B(:,3)*180/pi,'cyan',...
    T_6B,V_6B(:,3)*180/pi,'magenta');
title('Spin: Roll of 2014 Car Hitting a Speed Bump - Beeman');
xlabel('Time [s]');
ylabel('Spin [deg/s]');
legend('Full car 3 DOF','Full car 7 DOF');

subplot(3,1,3)
plot(T_5B,A_5B(3:end,3)*180/pi,'cyan',...
    T_6B,A_6B(3:end,3)*180/pi,'magenta');
title('Rate of Spin: Roll of 2014 Car Hitting a Speed Bump - Beeman');
xlabel('Time [s]');
ylabel('Rate of Spin [deg/s^2]');
legend('Full car 3 DOF','Full car 7 DOF');