function [M] =  get_mass_matrix(vibration_model,FSAE_Race_Car)
    %get_mass_matrix - A function for producing the mass 
    %   matrix for a given car.
    %
    %   USAGE
    %[M] =  get_mass_matrix(vibration_model,FSAE_Race_Car)
    %
    %   INPUT
    %vibration_model    a char defining which type of model is being
    %                   used. Can be either "quarter_car_1_DOF" or
    %                   "quarter_car_2_DOF".
    %FSAE_Race_Car      a struct defining which car to do analysis on
    %
    %   OUTPUT
    %M                  The mass matrix for the given vehicle and
    %                   vibration model type
    
    if ischar(vibration_model) == 0 
        error(['Error: Input type.',...
            '\n\tvibration_model must be a char, not a %s'],class(vibration_model));        
    elseif isstruct(FSAE_Race_Car) == 0
        error(['Error: Input type.',...
            '\n\tFSAE_Race_Car must be a struct, not a %s'],class(FSAE_Race_Car));
    elseif strcmp(vibration_model,'quarter_car_1_DOF') == 0 && strcmp(vibration_model,'quarter_car_2_DOF') == 0
        error('Error: invalid vibration model. Acceptable formats are "quarter_car_1_DOF" and "quarter_car_2_DOF"')
    end
    
    M = [(FSAE_Race_Car.pilot.weight + FSAE_Race_Car.power_plant.weight + FSAE_Race_Car.chassis.weight)*0.031081,];
    if strcmp(vibration_model,'quarter_car_2_DOF') == 1
        M = [M;0, FSAE_Race_Car.wheel_front.weight*0.031081];
    end
    
    
    
end

