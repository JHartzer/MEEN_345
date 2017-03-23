function [ z0 ] = get_static_deflection(vibration_model,FSAE_Race_Car)
    % get_static_deflection - A function for calculating the static
    %   deflection of the given car and vibration model
    %
    %   USAGE
    % [ z0 ] = get_static_deflection(vibration_model,FSAE_Race_Car)
    %
    %   INPUT
    % vibration_model    a char defining which type of model is being
    %                   used. Can be either "quarter_car_1_DOF",
    %                   "quarter_car_2_DOF", "half_car_2_DOF",
    %                   or "half_car_4_DOF".
    % FSAE_Race_Car      a struct defining which car to do analysis on
    %
    %   OUTPUT
    % z0                 the static deflection matrix for the given 
    %                   vehicle and vibration model type
    
    if ischar(vibration_model) == 0 
        error(['Error: Input type.',...
            '\n\tvibration_model must be a char, not a %s'],class(vibration_model));        
    
    elseif isstruct(FSAE_Race_Car) == 0
        error(['Error: Input type.',...
            '\n\tFSAE_Race_Car must be a struct, not a %s'],class(FSAE_Race_Car));
    
    elseif strcmp(vibration_model,'quarter_car_1_DOF') == 0 && strcmp(vibration_model,'quarter_car_2_DOF') == 0 && strcmp(vibration_model,'half_car_2_DOF') == 0 && strcmp(vibration_model,'half_car_4_DOF') == 0
        error('Error: invalid vibration model. Acceptable formats are:\n"quarter_car_1_DOF"\n"quarter_car_2_DOF"\n"half_car_2_DOF"\n"half_car_4_DOF"');
    end
    
    K = get_stiffness_matrix(vibration_model, FSAE_Race_Car);
    M = get_mass_matrix(vibration_model, FSAE_Race_Car);

    if strcmp(vibration_model, 'quarter_car_1_DOF') == 1
        z0 = K \ (M * 32.174);
        % Static deflection for 1/4 car, 1 DOF
        
    elseif strcmp(vibration_model, 'quarter_car_2_DOF') == 1
        ff = [M(1,1); M(2,2)] * 32.174;
        z0 = K \ ff;
        % Static deflection for 1/4 car, 2 DOF
        
    elseif strcmp(vibration_model, 'half_car_2_DOF') == 1
        ff = [M(1,1) * 32.174 - FSAE_Race_Car.wheel_front.c * dRdt_f_d - FSAE_Race_Car.wheel_rear.c * dRdt_r_d - FSAE_Race_Car.wheel_front.k * R_f_d - FSAE_Race_Car.wheel_rear.k * R_r_d;...
            FSAE_Race_Car.wheel_front.c * FSAE_Race_Car.chassis.radius_f * dRdt_f_d - FSAE_Race_Car.wheel_rear.c * FSAE_Race_Car.chassis.radius_r * dRdt_r_d - FSAE_Race_Car.wheel_front.k * FSAE_Race_Car.chassis.radius_f * R_f_d - FSAE_Race_Car.wheel_rear.k * FSAE_Race_Car.chassis.radius_k * R_r_d];
        
        z0 = K \ ff;
        % Static deflection for 1/2 car, 2 DOF
        
    elseif strcmp(vibration_model, 'half_car_4_DOF') == 1
        ff = [M(1,1) * 32.174;...
            0;...
            FSAE_Race_Car.wheel_front.weight - FSAE_Race_Car.wheel_front.c * dRdt_f_d - FSAE_Race_Car.wheel_front.k * R_f_d;...
            FSAE_Race_Car.wheel_rear.weight - FSAE_Race_Car.wheel_rear.c * dRdt_r_d - FSAE_Race_Car.wheel_rear.k * R_r_d];
        
        z0 = K \ ff;
        % Static deflection for 1/2 car, 4 DOF
        
    end
end

