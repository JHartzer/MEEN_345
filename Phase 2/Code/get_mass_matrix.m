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
    elseif strcmp(vibration_model,'quarter_car_1_DOF') == 0 && strcmp(vibration_model,'quarter_car_2_DOF') == 0 && strcmp(vibration_model,'half_car_2_DOF') == 0 && strcmp(vibration_model,'half_car_4_DOF') == 0
        error('Error: Invalid vibration model. Acceptable formats are:\n"quarter_car_1_DOF"\n"quarter_car_2_DOF"\n"half_car_2_DOF"\n"half_car_4_DOF"');
    end
    
    m_pilot = FSAE_Race_Car.pilot.weight;
    m_engine = FSAE_Race_Car.power_plant.weight;
    m_chassis = FSAE_Race_Car.chassis.weight;
    m_wheel_front = FSAE_Race_Car.wheel_front.weight;
    m_wheel_rear = FSAE_Race_Car.wheel_rear.weight;
    Jy = get_Jy(FSAE_Race_Car);
    
    if strcmp(vibration_model,'quarter_car_1_DOF') == 1
        m_avg = (m_pilot + m_engine + m_chassis)/4;
        M = m_avg/32.174;
        % Mass matrix for 1/4 car, 1 DOF
        
    elseif strcmp(vibration_model,'quarter_car_2_DOF') == 1
        m_avg = (m_pilot + m_engine + m_chassis)/4;
        M = [m_avg,0;0,(m_wheel_front + m_wheel_rear)/2]/32.174;
        % Mass matrix for 1/4 car, 2 DOF
        
    elseif strcmp(vibration_model, 'half_car_2_DOF') == 1
        m_avg = (m_piolot + m_engine + m_chassis)/2;
        M = [m_avg/32.174,0;0,(Jy/2)];
        % Mass matrix for 1/2 car, 2 DOF
        
    elseif strcmp(vibration_model, 'half_car_4_DOF') == 1
        m_avg = (m_piolot + m_engine + m_chassis)/2;
        md = [m_avg/32.174,(Jy/2),(m_wheel_front/32.174),(m_wheel_rear/32.174)];
        M = zeros(4);
        for i = 1:4
            M(i,i) = md(i);
            % Mass matrix for 1/2 car, 4 DOF
        end
    end
    
    
end

