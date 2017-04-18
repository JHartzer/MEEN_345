function [ K ] = get_stiffness_matrix(vibration_model,FSAE_Race_Car)
    % get_stiffness_matrix - A function for producing the stiffness 
    %   matrix for a given car. Takes into account the calculated 
    %   leverage ratio and average across all car sections. 
    %
    %   USAGE
    % [ K ] = get_stiffness_matrix(vibration_model,FSAE_Race_Car)
    %
    %   INPUT
    % vibration_model    a char defining which type of model is being
    %                   used. Acceptable formats are:
    %                   "quarter_car_1_DOF",
    %                   "quarter_car_2_DOF", 
    %                   "half_car_2_DOF",
    %                   "half_car_4_DOF",
    %                   "full_car_3_DOF",
    %                   "full_car_7_DOF".
    % FSAE_Race_Car      a struct defining which car to do analysis on
    %
    %   OUTPUT
    % K                  The stiffness matrix for the given   and
    %                   vibration model type
    
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
    
    
    kf = FSAE_Race_Car.wheel_front.k * 12;
    kr = FSAE_Race_Car.wheel_rear.k * 12;   
    k1 = FSAE_Race_Car.suspension_front.k * 12 * get_leverage_ratio('front', FSAE_Race_Car);
    k2 = k1;
    k3 = FSAE_Race_Car.suspension_rear.k * 12 * get_leverage_ratio('rear', FSAE_Race_Car);
    k4 = k3;
    lf = get_cg(FSAE_Race_Car);
    lr = (FSAE_Race_Car.chassis.wheelbase / 12) - lf;
    
    Ks = (k1 + k3) / 2;
       
    rf = FSAE_Race_Car.chassis.radius_f/12;
    rr = FSAE_Race_Car.chassis.radius_r/12;
    
    switch vibration_model
        case 'quarter_car_1_DOF'
            K = Ks;

        case 'quarter_car_2_DOF'
            K = [Ks, -Ks;...
                -Ks, Ks + (kf + kr)/2];

        case 'half_car_2_DOF'
            K = [k1 + k3, ((k3 * lr) - (k1 * lf));...
                ((k3 * lr) - (k1 * lf)), ((k1 * (lf^2)) + (k3 * (lr^2)))];

        case 'half_car_4_DOF'
            K = [k1 + k3, ((k3 * lr) - (k1 * lf)), -(k1), -(k3);...
                ((k3 * lr) - (k1 * lf)), ((k1 * (lf^2)) + (k3 * (lr^2))), (k1 * lf), -(k3 * lr);...
                -(k1), (k1 * lf), (k1 + kf), 0;...
                -(k3), -(k3 * lr), 0, (k3 + kr)];
            
        case 'full_car_3_DOF'
            K = [k1+k2+k3+k4, (k3+k4)*lr - (k1+k2)*lf, (k3-k4)*rr - (k1-k2)*rf;...
                (k3+k4)*lr - (k1+k2)*lf, (k1+k2)*lf^2 + (k3+k4)*lr^2, (k1-k2)*lf*rf + (k3-k4)*lr*rr;...
                (k3-k4)*rr - (k1-k2)*rf, (k1-k2)*lf*rf + (k3-k4)*lr*rr, (k1+k2)*rf^2 + (k3+k4)*rr^2];
            
        case 'full_car_7_DOF'
            kdf = kf; kpf = kf;
            kdr = kr; kpr = kr;
            
            K = [k1+k2+k3+k4, (k3+k4)*lr - (k1+k2)*lf, (k3-k4)*rr - (k1-k2)*rf, -k1, -k2, -k3, -k4;...
                (k3+k4)*lr - (k1+k2)*lf, (k1+k2)*lf^2 + (k3+k4)*lr^2, (k1-k2)*lf*rf + (k3-k4)*lr*rr, k1*lf, k2*lf, -k3*lr, -k4*lr;...
                (k3-k4)*rr - (k1-k2)*rf, (k1-k2)*lf*rf + (k3-k4)*lr*rr, (k1+k2)*rf^2 + (k3+k4)*rr^2, k1*rf, -k2*rf, -k3*rr, k4*rr;...
                -k1, k1*lf, k1*rf, k1+kdf,0,0,0;...
                -k2, k2*lf,-k2*rf,0,k2+kpf,0,0;...
                -k3,-k3*lr,-k3*rr,0,0,k3+kpr,0;...
                -k4,-k4*lr, k4*rr,0,0,0,k4+kdr];
    end
end

    