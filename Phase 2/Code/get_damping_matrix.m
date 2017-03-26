function [ C ] = get_damping_matrix(vibration_model,FSAE_Race_Car)
    % get_damping_matrix - A function for producing the damping matrix
    %   for a given car. Takes into account the calculated leverage
    %   ratio and average across all car sections. 
    %
    %   USAGE
    % [ C ] = get_damping_matrix(vibration_model, FSAE_Race_Car)
    %
    %   INPUT
    % vibration_model    a char defining which type of model is being
    %                   used. Can be either "quarter_car_1_DOF",
    %                   "quarter_car_2_DOF", "half_car_2_DOF",
    %                   or "half_car_4_DOF".
    % FSAE_Race_Car      a struct defining which car to do analysis on
    %
    %   OUTPUT
    % C                  The damping matrix for the given vehicle and
    %                   vibration model type
    
    % Checks input types
    if ischar(vibration_model) == 0 
        error(['Error: Input type.',...
            '\n\tvibration_model must be a char, not a %s'],class(vibration_model));        
    
    elseif isstruct(FSAE_Race_Car) == 0
        error(['Error: Input type.',...
            '\n\tFSAE_Race_Car must be a struct, not a %s'],class(FSAE_Race_Car));
    
    elseif strcmp(vibration_model,'quarter_car_1_DOF') == 0 && strcmp(vibration_model,'quarter_car_2_DOF') == 0 && strcmp(vibration_model,'half_car_2_DOF') == 0 && strcmp(vibration_model,'half_car_4_DOF') == 0
        error('Error: Invalid vibration model. Acceptable formats are:\n"quarter_car_1_DOF"\n"quarter_car_2_DOF"\n"half_car_2_DOF"\n"half_car_4_DOF"');
    end
    
    front_leverage = get_leverage_ratio('front',FSAE_Race_Car);
    rear_leverage = get_leverage_ratio('rear',FSAE_Race_Car);
    c_front_suspension = FSAE_Race_Car.suspension_front.c * 12;
    c_rear_suspension = FSAE_Race_Car.suspension_rear.c * 12;
    cf = FSAE_Race_Car.wheel_front.c * 12;
    cr = FSAE_Race_Car.wheel_rear.c * 12; 
    
    c1 = c_front_suspension * front_leverage; 
    c2 = c_rear_suspension * rear_leverage; 
    lf = get_cg(FSAE_Race_Car);
    lr = (FSAE_Race_Car.chassis.wheelbase / 12) - lf;
    
    Cs = ((c1) + (c2)) / 2;
    
    if strcmp(vibration_model,'quarter_car_1_DOF') == 1
        C = Cs;
        % Damping matrix for 1/4 car, 1 DOF
        
    elseif strcmp(vibration_model,'quarter_car_2_DOF') == 1
        C = [Cs, -Cs; -Cs , Cs + (cf + cr)/2];
        % Damping matrix for 1/4 car, 2 DOF
        
    elseif strcmp(vibration_model, 'half_car_2_DOF') == 1
        C = [c1 + c2, ((c2 * lr) - (c1 * lf));...
            ((c2 * lr) - (c1 * lf)), ((c1 * (lf^2)) + (c2 * (lr^2)))];
        % Damping matrix for 1/2 car, 2 DOF
        
    elseif strcmp(vibration_model, 'half_car_4_DOF') == 1
        C = [Cs*2, ((c2 * lr) - (c1 * lf)), -(c1), -(c2);...
            ((c2 * lr) - (c1 * lf)), ((c1 * (lf^2)) + (c2 * (lr^2))), (c1 * lf), -(c2 * lr);...
            -(c1), (c1 * lf), (c1 + cf), 0;...
            -(c2), -(c2 * lr), 0, (c2 + cr)];
        % Damping matrix for 1/2 car, 4 DOF
        
    end

end
