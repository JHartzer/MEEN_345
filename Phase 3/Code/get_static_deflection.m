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
    
    K = get_stiffness_matrix(vibration_model, FSAE_Race_Car);
    M = get_mass_matrix(vibration_model, FSAE_Race_Car);

    switch vibration_model
        case 'quarter_car_1_DOF'
            z0 = K \ (M * 32.174);

        case 'quarter_car_2_DOF'
            ff = [M(1,1); M(2,2)] * 32.174;
            z0 = K \ ff;

        case 'half_car_2_DOF'
            ff = [M(1,1) * 32.174; 0];
            z0 = K \ ff;

        case 'half_car_4_DOF'
            ff = [M(1,1); 0; M(3,3); M(4,4)] * 32.174;
            z0 = K \ ff;
            
        case 'full_car_3_DOF'
            ff = [M(1,1);0;0];
            z0 = K \ ff;
            
        case 'full_car_7_DOF'
            ff = [M(1,1);0;0;M(4,4);M(5,5);M(6,6);M(7,7)] * 32.174;
            z0 = K \ ff;
    end
end

