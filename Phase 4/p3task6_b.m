clc; clear all; close all;

% In three other figures, one for each A&M car, place four plots into 
% a two-row by two-column format.  These plots are to compare heave, 
% pitch and roll of the axle plane (in a solid red line) against that 
% of the chassis plane (in a solid blue line).  The fourth plot in each 
% figure is for displaying warp of the axle plane (the chassis does not warp). 

%% 2014
figure;
ff_2014_6;
D = ff_data;
FN = @(t, D) get_forcing_function(t, D);
X0 = get_static_deflection(D.model, D.car);
DOF= size(X0, 1);
V0 = zeros(DOF, 1);
M = get_mass_matrix(D.model, D.car);
C = get_damping_matrix(D.model, D.car);
K = get_stiffness_matrix(D.model, D.car);

% integrate
[T_2014, X_2014, V_2014, A_2014] = Beeman(X0, V0, zeros(DOF, 3), M, C, K, FN, D);

% calculate axle plane values
L = D.car.chassis.wheelbase/12;
lf = get_cg(D.car);
lr = L-lf;
rf = D.car.chassis.radius_f/12;
rr = D.car.chassis.radius_r/12;
W = rf + rr;
axle_matrix = [...
    lr/(2*L), lr/(2*L), lf/(2*L), lf/(2*L);...
    -1/(2*L), -1/(2*L), 1/(2*L), 1/(2*L);...
    -1/(2*W), 1/(2*W), 1/(2*W), -1/(2*W);...
    -rr/W, rr/W, -rf/W, rf/W];
z_axle_2014 = (axle_matrix * X_2014(:,4:7)')';

% compare heave of the axle plane against the chassis plane
subplot(2,2,1)
plot(T_2014,X_2014(:,1),'blue',...
    T_2014,z_axle_2014(:,1),'red');
title('Heave of Axle and Chassis Planes of 2014 Car Hitting a Speed Bump');
xlabel('Time [s]');
ylabel('Displacement [ft]');
legend('Chassis Plane','Axle Plane');

% compare pitch of the axle plane against the chassis plane
subplot(2,2,2)
plot(T_2014,X_2014(:,2)*180/pi,'blue',...
    T_2014,z_axle_2014(:,2)*180/pi,'red');
title('Pitch of Axle and Chassis Planes of 2014 Car Hitting a Speed Bump');
xlabel('Time [s]');
ylabel('Rotation [deg]');
legend('Chassis Plane','Axle Plane');

% compare roll of the axle plane against the chassis plane
subplot(2,2,3)
plot(T_2014,X_2014(:,3)*180/pi,'blue',...
    T_2014,z_axle_2014(:,3)*180/pi,'red');

title('Roll of Axle and Chassis Planes of 2014 Car Hitting a Speed Bump');
xlabel('Time [s]');
ylabel('Rotation [deg]');
legend('Chassis Plane','Axle Plane');

% plot warp of the axle plane
subplot(2,2,4)
plot(T_2014,z_axle_2014(:,4),'red');
title('Warp of Axle Plane of 2014 Car Hitting a Speed Bump');
xlabel('Time [s]');
ylabel('Warp');

%% 2016
figure;
ff_2016_6;
D = ff_data;
FN = @(t, D) get_forcing_function(t, D);
X0 = get_static_deflection(D.model, D.car);
DOF= size(X0, 1);
V0 = zeros(DOF, 1);
M = get_mass_matrix(D.model, D.car);
C = get_damping_matrix(D.model, D.car);
K = get_stiffness_matrix(D.model, D.car);

% integrate
[T_2016, X_2016, V_2016, A_2016] = Beeman(X0, V0, zeros(DOF, 3), M, C, K, FN, D);

% calculate axle plane values
L = D.car.chassis.wheelbase/12;
lf = get_cg(D.car);
lr = L-lf;
rf = D.car.chassis.radius_f/12;
rr = D.car.chassis.radius_r/12;
W = rf + rr;
axle_matrix = [...
    lr/(2*L), lr/(2*L), lf/(2*L), lf/(2*L);...
    -1/(2*L), -1/(2*L), 1/(2*L), 1/(2*L);...
    -1/(2*W), 1/(2*W), 1/(2*W), -1/(2*W);...
    -rr/W, rr/W, -rf/W, rf/W];
z_axle_2016 = (axle_matrix * X_2016(:,4:7)')';

% compare heave of the axle plane against the chassis plane
subplot(2,2,1)
plot(T_2016,X_2016(:,1),'blue',...
    T_2016,z_axle_2016(:,1),'red');
title('Heave of Axle and Chassis Planes of 2016 Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Displacement [ft]');
legend('Chassis Plane','Axle Plane');

% compare pitch of the axle plane against the chassis plane
subplot(2,2,2)
plot(T_2016,X_2016(:,2)*180/pi,'blue',...
    T_2016,z_axle_2016(:,2)*180/pi,'red');
title('Pitch of Axle and Chassis Planes of 2016 Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Rotation [deg]');
legend('Chassis Plane','Axle Plane');
axis([0 0.1 0.04 0.1]);

% compare roll of the axle plane against the chassis plane
subplot(2,2,3)
plot(T_2016,X_2016(:,3)*180/pi,'blue',...
    T_2016,z_axle_2016(:,3)*180/pi,'red');
title('Roll of Axle and Chassis Planes of 2016 Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Rotation [deg]');
legend('Chassis Plane','Axle Plane');
% axis([0 0.1 -2e-3 6e-3]);

% plot warp of the axle plane
subplot(2,2,4)
plot(T_2016,z_axle_2016(:,4),'red');
title('Warp of Axle Plane of 2016 Car Hitting a Tar Strip');
xlabel('Time [s]');
ylabel('Warp');
axis([0 0.1 -4e-4 4e-4]);

%% 2017
figure;
ff_2017_6;
D = ff_data;
FN = @(t, D) get_forcing_function(t, D);
X0 = get_static_deflection(D.model, D.car);
DOF= size(X0, 1);
V0 = zeros(DOF, 1);
M = get_mass_matrix(D.model, D.car);
C = get_damping_matrix(D.model, D.car);
K = get_stiffness_matrix(D.model, D.car);

% integrate
[T_2017, X_2017, V_2017, A_2017] = Beeman(X0, V0, zeros(DOF, 3), M, C, K, FN, D);

% calculate axle plane values
L = D.car.chassis.wheelbase/12;
lf = get_cg(D.car);
lr = L-lf;
rf = D.car.chassis.radius_f/12;
rr = D.car.chassis.radius_r/12;
W = rf + rr;
axle_matrix = [...
    lr/(2*L), lr/(2*L), lf/(2*L), lf/(2*L);...
    -1/(2*L), -1/(2*L), 1/(2*L), 1/(2*L);...
    -1/(2*W), 1/(2*W), 1/(2*W), -1/(2*W);...
    -rr/W, rr/W, -rf/W, rf/W];
z_axle_2017 = (axle_matrix * X_2017(:,4:7)')';

% compare heave of the axle plane against the chassis plane
subplot(2,2,1)
plot(T_2017,X_2017(:,1),'blue',...
    T_2017,z_axle_2017(:,1),'red');
title('Heave of Axle and Chassis Planes of 2017 Car Driving Agony Road');
xlabel('Time [s]');
ylabel('Displacement [ft]');
legend('Chassis Plane','Axle Plane');

% compare pitch of the axle plane against the chassis plane
subplot(2,2,2)
plot(T_2017,X_2017(:,2)*180/pi,'blue',...
    T_2017,z_axle_2017(:,2)*180/pi,'red');
title('Pitch of Axle and Chassis Planes of 2017 Car Driving Agony Road');
xlabel('Time [s]');
ylabel('Rotation [deg]');
legend('Chassis Plane','Axle Plane');

% compare roll of the axle plane against the chassis plane
subplot(2,2,3)
plot(T_2017,X_2017(:,3)*180/pi,'blue',...
    T_2017,z_axle_2017(:,3)*180/pi,'red');
title('Roll of Axle and Chassis Planes of 2017 Car Driving Agony Road');
xlabel('Time [s]');
ylabel('Rotation [deg]');
legend('Chassis Plane','Axle Plane');

% plot warp of the axle plane
subplot(2,2,4)
plot(T_2017,z_axle_2017(:,4),'red');
title('Warp of Axle Plane of 2017 Car Driving Agony Road');
xlabel('Time [s]');
ylabel('Warp');
