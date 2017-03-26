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
    
    
    [t, X, V] =   ff_data.trajectory(ff_data.t_prev, ff_data.X_prev, (ff_data.t_out - ff_data.t_in)/ff_data.N, ff_data.t_in, ff_data.t_out, ff_data.V_in, ff_data.V_out, ff_data.car);
    [R_f_d, R_r_d, dRdt_f_d, dRdt_r_d] = ff_data.roadway_d(ff_data.car.chassis.wheelbase/12, ff_data.X_enter_d, X, V);
    %[R_f_p, R_r_p, dRdt_f_p, dRdt_r_p] = ff_data.roadway_p(ff_data.car.chassis.wheelbase/12, ff_data.X_enter_p, X, V);

    M = get_mass_matrix(ff_data.model, ff_data.car);
    C = get_damping_matrix(ff_data.model,ff_data.car);
    K = get_stiffness_matrix(ff_data.model,ff_data.car);
    
    front_leverage = get_leverage_ratio('front',ff_data.car);
    rear_leverage = get_leverage_ratio('rear',ff_data.car);
    lf = get_cg(ff_data.car);
    lr = (ff_data.car.chassis.wheelbase / 12) - lf;
    
    k_front_suspension = ff_data.car.suspension_front.k * 12;
    k_rear_suspension = ff_data.car.suspension_rear.k * 12;
    kf = ff_data.car.wheel_front.k * 12;
    kr = ff_data.car.wheel_rear.k * 12;
    k1 = k_front_suspension * front_leverage;
    k2 = k_rear_suspension * rear_leverage;
    
    c_front_suspension = ff_data.car.suspension_front.c * 12;
    c_rear_suspension = ff_data.car.suspension_rear.c * 12;
    cf = ff_data.car.wheel_front.c * 12;
    cr = ff_data.car.wheel_rear.c * 12;
    c1 = c_front_suspension * front_leverage; 
    c2 = c_rear_suspension * rear_leverage; 
    
    
    
    
    if strcmp(ff_data.model, 'quarter_car_1_DOF') == 1
        FF = M * 32.174 - C * dRdt_f_d - K * R_f_d;
        
    elseif strcmp(ff_data.model, 'quarter_car_2_DOF') == 1
        FF = [M(1,1) * 32.174;...
            M(2,2) * 32.174 - (cf + cr)/2 * dRdt_f_d - (kf + kr)/2 * R_f_d];
                    
    elseif strcmp(ff_data.model, 'half_car_2_DOF') == 1
               
        FF = [M(1,1) * 32.174 - c1 * dRdt_f_d - c2 * dRdt_r_d - k1 * R_f_d - k2 * R_r_d;...
            c1 * lf * dRdt_f_d - c2 * lr * dRdt_r_d + k1 * lf * R_f_d - k2 * lr * R_r_d];
        
    elseif strcmp(ff_data.model, 'half_car_4_DOF') == 1

        FF = [M(1,1) * 32.174;...
            0;...
            M(3,3) * 32.174 - cf * dRdt_f_d - kf * R_f_d;...
            M(4,4) * 32.174 - cr * dRdt_r_d - kr * R_r_d];
    end
    
    ff_data.t_prev = t; 
    ff_data.X_prev = X;
end

