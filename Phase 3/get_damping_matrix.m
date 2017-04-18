function [ C ] = get_damping_matrix(vibration_model,FSAE_Race_Car)
    % get_damping_matrix - A function for producing the damping matrix
    %   for a given car. Takes into account the calculated leverage
    %   ratio and average across all car sections. 
    %
    %   USAGE
    % [ C ] = get_damping_matrix(vibration_model, FSAE_Race_Car)
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
    % C                  The damping matrix for the given vehicle and
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
    

    cf = FSAE_Race_Car.wheel_front.c * 12;
    cr = FSAE_Race_Car.wheel_rear.c * 12; 
    c1 = FSAE_Race_Car.suspension_front.c * 12 * get_leverage_ratio('front',FSAE_Race_Car); 
    c2 = c1;
    c3 = FSAE_Race_Car.suspension_rear.c * 12 * get_leverage_ratio('rear',FSAE_Race_Car); 
    c4 = c3;
    lf = get_cg(FSAE_Race_Car);
    lr = (FSAE_Race_Car.chassis.wheelbase / 12) - lf;
    rf = FSAE_Race_Car.chassis.radius_f/12;
    rr = FSAE_Race_Car.chassis.radius_r/12;
    
    Cs = ((c1) + (c3)) / 2;
    
    switch vibration_model
        case 'quarter_car_1_DOF'
            C = Cs;

        case 'quarter_car_2_DOF'
            C = [Cs, -Cs;...
                -Cs , Cs + (cf + cr)/2];

        case 'half_car_2_DOF'
            C = [c1 + c3, ((c3 * lr) - (c1 * lf));...
                ((c3 * lr) - (c1 * lf)), ((c1 * (lf^2)) + (c3 * (lr^2)))];

        case 'half_car_4_DOF'
            C = [Cs*2, ((c3 * lr) - (c1 * lf)), -(c1), -(c3);...
                ((c3 * lr) - (c1 * lf)), ((c1 * (lf^2)) + (c3 * (lr^2))), (c1 * lf), -(c3 * lr);...
                -(c1), (c1 * lf), (c1 + cf), 0;...
                -(c3), -(c3 * lr), 0, (c3 + cr)];

        case 'full_car_3_DOF'
            C = [c1+c2+c3+c4, (c3+c4)*lr - (c1+c2)*lf, (c3-c4)*rr - (c1-c2)*rf;...
                (c3+c4)*lr - (c1+c2)*lf, (c1+c2)*lf^2 + (c3+c4)*lr^2, (c1-c2)*lf*rf + (c3-c4)*lr*rr;...
                (c3-c4)*rr - (c1-c2)*rf, (c1-c2)*lf*rf + (c3-c4)*lr*rr, (c1+c2)*rf^2 + (c3+c4)*rr^2];
            
        case 'full_car_7_DOF'
            cdf = cf; cpf = cf;
            cdr = cr; cpr = cr;
            
            C = [c1+c2+c3+c4, (c3+c4)*lr - (c1+c2)*lf, (c3-c4)*rr - (c1-c2)*rf, -c1, -c2, -c3, -c4;...
                (c3+c4)*lr - (c1+c2)*lf, (c1+c2)*lf^2 + (c3+c4)*lr^2, (c1-c2)*lf*rf + (c3-c4)*lr*rr, c1*lf, c2*lf, -c3*lr, -c4*lr;...
                (c3-c4)*rr - (c1-c2)*rf, (c1-c2)*lf*rf + (c3-c4)*lr*rr, (c1+c2)*rf^2 + (c3+c4)*rr^2, c1*rf, -c2*rf, -c3*rr, c4*rr;...
                -c1, c1*lf, c1*rf, c1+cdf,0,0,0;...
                -c2, c2*lf,-c2*rf,0,c2+cpf,0,0;...
                -c3,-c3*lr,-c3*rr,0,0,c3+cpr,0;...
                -c4,-c4*lr, c4*rr,0,0,0,c4+cdr];
    end

end
