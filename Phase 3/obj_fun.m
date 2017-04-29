function [phi] = obj_fun(D)
    FN  = @(t, D) get_forcing_function(t, D);
    X0  = get_static_deflection(D.model, D.car);
    DOF = size(X0, 1);
    V0  = zeros(DOF, 1);
    M   = get_mass_matrix(D.model, D.car);
    C   = get_damping_matrix(D.model, D.car);
    K   = get_stiffness_matrix(D.model, D.car);

    % integrate
    [~, X, ~, ~] = Newmark(X0, V0, zeros(DOF, 3), M, C, K, FN, D);

    % calculate axle plane values
    lf = D.car.chassis.radius_f;
    lr = D.car.chassis.radius_r;
    L = lf + lr;
    rf = D.car.chassis.wheelbase/2;
    rr = rf;
    W = rf + rr;
    axle_matrix = [lr/(2*L), lr/(2*L), lf/(2*L), lf/(2*L);...
        -1/(2*L), -1/(2*L), 1/(2*L), 1/(2*L);...
        -1/(2*W), 1/(2*W), 1/(2*W), -1/(2*W);...
        -rr/W, rr/W, -rf/W, rf/W];
    z_axle = (axle_matrix * X(:,4:7)')';
    
    target_heave = 8 - 5.11 + 0.0195;
    target_pitch = 6 - 4.91;
    target_roll = 3 - 1.55;
    
    phi1 = norm(z_axle(:,1))/max([10^-16,abs(norm(X(:,1) - z_axle(:,1)) - target_heave)]);
    phi2 = norm(z_axle(:,2))/max([10^-16,abs(norm(X(:,2) - z_axle(:,2)) - target_pitch)]);
    phi3 = norm(z_axle(:,3))/max([10^-16,abs(norm(X(:,3) - z_axle(:,3)) - target_roll)]);

    phi = -(phi1 + phi2 + phi3)/ max([phi1,phi2,phi3]);
end