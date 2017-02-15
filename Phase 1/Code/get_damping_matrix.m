function [ C ] = get_damping_matrix(vibration_model,FSAE_Race_Car)
    %UNTITLED7 Summary of this function goes here
    %   Detailed explanation goes here
    %   leverage ratio × k
    
    if ischar(vibration_model) == 0 
        error(['Error: Input type.',...
            '\n\tvibration_model must be a char, not a %s'],class(vibration_model));        
    
    elseif isstruct(FSAE_Race_Car) == 0
        error(['Error: Input type.',...
            '\n\tFSAE_Race_Car must be a struct, not a %s'],class(FSAE_Race_Car));
    
    elseif strcmp(vibration_model,'quarter_car_1_DOF') == 0 && strcmp(vibration_model,'quarter_car_2_DOF') == 0
        error('Error: invalid vibration model. Acceptable formats are "quarter_car_1_DOF" and "quarter_car_2_DOF"')
    end
    
    c = (FSAE_Race_Car.suspension_front.c*get_leverage_ratio('front',FSAE_Race_Car)+...
        FSAE_Race_Car.suspension_rear.c*get_leverage_ratio('rear',FSAE_Race_Car))/2;
    C = [c,-c];
    if strcmp(vibration_model,'quarter_car_2_DOF') == 1
        C = [C;-c,c+(FSAE_Race_Car.wheel_front.c + FSAE_Race_Car.wheel_front.c)/2];
    end
end

