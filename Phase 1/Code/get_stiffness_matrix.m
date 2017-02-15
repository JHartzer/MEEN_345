function [ K ] = get_stiffness_matrix(vibration_model,FSAE_Race_Car)
    %get_stiffness_matrix - A function for producing the stiffness 
    %   matrix for a given car. Takes into account the calculated 
    %   leverage ratio and average across all car sections. 
    %
    %   USAGE
    %[ K ] = get_stiffness_matrix(vibration_model,FSAE_Race_Car)
    %
    %   INPUT
    %vibration_model    a char defining which type of model is being
    %                   used. Can be either "quarter_car_1_DOF" or
    %                   "quarter_car_2_DOF".
    %FSAE_Race_Car      a struct defining which car to do analysis on
    %
    %   OUTPUT
    %K                  The stiffness matrix for the given   and
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
    
    k = (FSAE_Race_Car.suspension_front.k*get_leverage_ratio('front',FSAE_Race_Car)+...
        FSAE_Race_Car.suspension_rear.k*get_leverage_ratio('rear',FSAE_Race_Car))/2;
    K = [k,-k];
    if strcmp(vibration_model,'quarter_car_2_DOF') == 1
        K = [K;-k,k+(FSAE_Race_Car.wheel_front.k + FSAE_Race_Car.wheel_rear.k)/2];
    end
end