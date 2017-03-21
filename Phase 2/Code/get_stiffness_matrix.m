function [ K ] = get_stiffness_matrix(vibration_model,FSAE_Race_Car)
    % get_stiffness_matrix - A function for producing the stiffness 
    %   matrix for a given car. Takes into account the calculated 
    %   leverage ratio and average across all car sections. 
    %
    %   USAGE
    % [ K ] = get_stiffness_matrix(vibration_model,FSAE_Race_Car)
    %
    %   INPUT
    % vibration_model    a char defining which type of model is being
    %                   used. Can be either "quarter_car_1_DOF",
    %                   "quarter_car_2_DOF", "half_car_2_DOF",
    %                   or "half_car_4_DOF".
    % FSAE_Race_Car      a struct defining which car to do analysis on
    %
    %   OUTPUT
    % K                  The stiffness matrix for the given   and
    %                   vibration model type
    
    if ischar(vibration_model) == 0 
        error(['Error: Input type.',...
            '\n\tvibration_model must be a char, not a %s'],class(vibration_model));        
    
    elseif isstruct(FSAE_Race_Car) == 0
        error(['Error: Input type.',...
            '\n\tFSAE_Race_Car must be a struct, not a %s'],class(FSAE_Race_Car));
    
    elseif strcmp(vibration_model,'quarter_car_1_DOF') == 0 && strcmp(vibration_model,'quarter_car_2_DOF') == 0 && strcmp(vibration_model,'half_car_2_DOF') == 0 && strcmp(vibration_model,'half_car_4_DOF') == 0
        error('Error: invalid vibration model. Acceptable formats are:\n"quarter_car_1_DOF"\n"quarter_car_2_DOF"\n"half_car_2_DOF"\n"half_car_4_DOF"');
    end
    
    front_leverage = get_leverage_ratio('front', FSAE_Race_Car);
    rear_leverage = get_leverage_ratio('rear', FSAE_Race_Car);
    k_front_suspension = FSAE_Race_Car.suspension_front.k * 12;
    k_rear_suspension = FSAE_Race_Car.suspension_rear.k * 12;
    k_wheel_front = FSAE_Race_Car.wheel_front.k * 12;
    k_wheel_rear = FSAE_Race_Car.wheel_rear.k * 12;
    
    k_front_SxL = k_front_suspension * front_leverage;
    k_rear_SxL = k_rear_suspension * rear_leverage;
    LF = get_cg(FSAE_Race_Car);
    LR = (FSAE_Race_Car.chassis.wheelbase / 12) - LF;
    
    Ks = ((k_front_SxL) + (k_rear_SxL)) / 2;
    
    if strcmp(vibration_model, 'quarter_car_1_DOF') == 1
        K = Ks;
        % Stiffness matrix for 1/4 car, 1 DOF
        
    elseif strcmp(vibration_model, 'quarter_car_2_DOF') == 1
        K = [Ks, -Ks; -Ks, Ks + (k_wheel_front + k_wheel_rear)/2];
        % Stiffness matrix for 1/4 car, 2 DOF
        
    elseif strcmp(vibration_model, 'half_car_2_DOF') == 1
        K = [Ks*2, ((k_rear_SxL * LR) - (k_front_SxL * LF));...
            ((k_rear_SxL * LR) - (k_front_SxL * LF)), ((k_front_SxL * (LF^2)) + (k_rear_SxL * (LR^2)))];
        % Stiffness matrix for 1/2 car, 2 DOF
        
    elseif strcmp(vibration_model, 'half_car_4_DOF') == 1
        K = [Ks*2, ((k_rear_SxL * LR) - (k_front_SxL * LF)), -(k_front_SxL), -(k_rear_SxL);...
            ((k_rear_SxL * LR) - (k_front_SxL * LF)), ((k_front_SxL * (LF^2)) + (k_rear_SxL * (LR^2))), (k_front_SxL * LF), -(k_rear_SxL * LR);...
            -(k_front_SxL), (k_front_SxL * LF), (k_front_SxL + k_wheel_front), 0;...
            -(k_rear_SxL), -(k_rear_SxL * LR), 0, (k_rear_SxL + k_wheel_rear)];
        % Stiffness matrix for 1/2 car, 4 DOF
        
    end
end

    