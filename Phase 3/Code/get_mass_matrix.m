function [M] =  get_mass_matrix(vibration_model,FSAE_Race_Car)
    % get_mass_matrix - A function for producing the mass 
    %   matrix for a given car and vibration model type.
    %
    %   USAGE
    % [M] =  get_mass_matrix(vibration_model, FSAE_Race_Car)
    %
    %   INPUT
    % vibration_model    a char defining which type of model is being
    %                   used. Can be either "quarter_car_1_DOF",
    %                   "quarter_car_2_DOF", "half_car_2_DOF",
    %                   or "half_car_4_DOF".
    % FSAE_Race_Car      a struct defining which car to do analysis on
    %
    %   OUTPUT
    % M                  The mass matrix for the given vehicle and
    %                   vibration model type
    
    % Checks input types
    
    if ischar(vibration_model) == 0 
        error(['Error: Input type.',...
            '\n\tvibration_model must be a char, not a %s'],class(vibration_model));        
        
    elseif isstruct(FSAE_Race_Car) == 0
        error(['Error: Input type.',...
            '\n\tFSAE_Race_Car must be a struct, not a %s'],class(FSAE_Race_Car));
        
    elseif strcmp(vibration_model,'quarter_car_1_DOF') == 0 &&... 
            strcmp(vibration_model,'quarter_car_2_DOF') == 0 &&...
            strcmp(vibration_model,'half_car_2_DOF') == 0 &&...
            strcmp(vibration_model,'half_car_4_DOF') == 0 &&...
            strcmp(vibration_model,'full_car_3_DOF') == 0 &&...
            strcmp(vibration_model,'full_car_7_DOF') == 0
        error(['Error: Invalid vibration model. Acceptable formats are:',...
            '\n"quarter_car_1_DOF"',...
            '\n"quarter_car_2_DOF"',...
            '\n"half_car_2_DOF"',...
            '\n"half_car_4_DOF"',...
            '\n"full_car_3_DOF"',...
            '\n"full_car_7_DOF"%s'],'');
    end
    
    w_pilot = FSAE_Race_Car.pilot.weight;
    w_engine = FSAE_Race_Car.power_plant.weight;
    w_chassis = FSAE_Race_Car.chassis.weight;
    w_wheel_front = FSAE_Race_Car.wheel_front.weight;
    w_wheel_rear = FSAE_Race_Car.wheel_rear.weight;
    
    Jy = get_Jy(FSAE_Race_Car);
    Jx = get_Jx(FSAE_Race_Car);
    
    m = (w_pilot + w_engine + w_chassis)/32.174;
    
    switch vibration_model
        case 'quarter_car_1_DOF'
            M = m/4;

        case 'quarter_car_2_DOF'
            M = diag([m/4,(w_wheel_front + w_wheel_rear)/2/32.174]);

        case 'half_car_2_DOF'
            M = diag([m/2, Jy/2]);

        case 'half_car_4_DOF'
            M = diag([m/2, Jy/2, w_wheel_front/32.174, w_wheel_rear/32.174]);
            
        case 'full_car_3_DOF'
            M = diag([]);
            
        case 'full_car_7_DOF'
            M = diag([m,Jy,Jx,w_wheel_front/32.174,w_wheel_front/32.174,w_wheel_rear/32.174,w_wheel_rear/32.174]); 
    end
end

