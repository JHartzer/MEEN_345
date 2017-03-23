function [FF, ff_data] = get_forcing_function(t, ff_data) 
    %get_forcing_function - interface for constructing a forcing
    %   function
    %
    %   USAGE
    %[FF, ff_data] = get_forcing_function(t, ff_data) 
    %
    %   INPUT
    %t          time (scalar)
    %ff_data    data structure used to construct forcing function
    %
    %   OUTPUT
    %FF         forcing function
    %ff_data    updated data structure to pass back in next call
    
    if ~isstruct(ff_data)
        error(['Error: Input type.\n\t',...
            'ff_data must be a scalar, not a %s'],class(ff_data));
    elseif ~isscalar(t) || ischar(t)
        error(['Error: Input type.\n\t',...
            't must be a scalar, not a %s'],class(t)); 
    end
    
    
    [t, X, V] =  ff_data.trajectory(ff_data.t_prev, ff_data.X_prev, (ff_data.t_out - ff_data.t_in)/ff_data.N, ff_data.t_in, ff_data.t_out, ff_data.V_in, ff_data.V_out, ff_data.car);
    [R_f_d, R_r_d, dRdt_f_d, dRdt_r_d] = ff_data.roadway_d(ff_data.car.chassis.wheelbase/12, ff_data.X_enter_d, X, V);
    [R_f_p, R_r_p, dRdt_f_p, dRdt_r_p] = ff_data.roadway_p(ff_data.car.chassis.wheelbase/12, ff_data.X_enter_p, X, V);

    M = get_mass_matrix(ff_data.model, ff_data.car);

    if strcmp(ff_data.model, 'quarter_car_1_DOF') == 1
        FF = M(1,1) * 32.174;
        
    elseif strcmp(ff_data.model, 'quarter_car_2_DOF') == 1
        FF = [M(1,1); M(2,2)] * 32.174;
        
    elseif strcmp(ff_data.model, 'half_car_2_DOF') == 1
        FF = [M(1,1) * 32.174 - FSAE_Race_Car.wheel_front.c * dRdt_f_d - FSAE_Race_Car.wheel_rear.c * dRdt_r_d - FSAE_Race_Car.wheel_front.k * R_f_d - FSAE_Race_Car.wheel_rear.k * R_r_d;...
            FSAE_Race_Car.wheel_front.c * FSAE_Race_Car.chassis.radius_f * dRdt_f_d - FSAE_Race_Car.wheel_rear.c * FSAE_Race_Car.chassis.radius_r * dRdt_r_d - FSAE_Race_Car.wheel_front.k * FSAE_Race_Car.chassis.radius_f * R_f_d - FSAE_Race_Car.wheel_rear.k * FSAE_Race_Car.chassis.radius_k * R_r_d];
        
    elseif strcmp(ff_data.model, 'half_car_4_DOF') == 1
        FF = [M(1,1) * 32.174;...
            0;...
            FSAE_Race_Car.wheel_front.weight - FSAE_Race_Car.wheel_front.c * dRdt_f_d - FSAE_Race_Car.wheel_front.k * R_f_d;...
            FSAE_Race_Car.wheel_rear.weight - FSAE_Race_Car.wheel_rear.c * dRdt_r_d - FSAE_Race_Car.wheel_rear.k * R_r_d];
    end

    ff_data.t_prev = t; 
    ff_data.X_prev = X;
end

