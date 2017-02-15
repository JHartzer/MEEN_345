function [ z0 ] = get_static_deflection(vibration_model,FSAE_Race_Car)
    %get_static_deflection - A function for 
    %
    %   USAGE
    %[ z0 ] = get_static_deflection(vibration_model,FSAE_Race_Car)
    %
    %   INPUT
    %vibration_model    a char defining which type of model is being
    %                   used. Can be either "quarter_car_1_DOF" or
    %                   "quarter_car_2_DOF".
    %FSAE_Race_Car      a struct defining which car to do analysis on
    %
    %   OUTPUT
    %z0                  
    
    if ischar(vibration_model) == 0 
        error(['Error: Input type.',...
            '\n\tvibration_model must be a char, not a %s'],class(vibration_model));        
    
    elseif isstruct(FSAE_Race_Car) == 0
        error(['Error: Input type.',...
            '\n\tFSAE_Race_Car must be a struct, not a %s'],class(FSAE_Race_Car));
    
    elseif strcmp(vibration_model,'quarter_car_1_DOF') == 0 && strcmp(vibration_model,'quarter_car_2_DOF') == 0
        error('Error: invalid vibration model. Acceptable formats are "quarter_car_1_DOF" and "quarter_car_2_DOF"')
    end
    

    if strcmp(vibration_model,'quarter_car_1_DOF') == 1
        z0 = 'wrong';
    else
        z0 = get_stiffness_matrix('quarter_car_2_DOF', car_2017)\(diag(get_mass_matrix('quarter_car_2_DOF', car_2017))*32.174);
    end
end

