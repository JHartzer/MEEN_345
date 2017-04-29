load('data10')
load('data13')
state = max([data10{:,4},data13{:,4}]);
while true
    for i = 1:27
        ff_data = ff_team_O10(data10{i,1},data10{i,2},data10{i,3});
        X1 = optimize_car(@objective_function,ff_data);
        if data10{i,4} < objective_function(ff_data,X1)
            data10{i,4} = objective_function(ff_data,X1);
            data10{i,5} = X1;
            save('data10')
        end
        if state < data10{i,4}
            state = data10{i,4};
            disp(state);
        end
    end
    for i = 1:27
        ff_data = ff_team_O13(data13{i,1},data13{i,2},data13{i,3});
        X1 = optimize_car(@objective_function,ff_data);
        if data13{i,4} < objective_function(ff_data,X1)
            data13{i,4} = objective_function(ff_data,X1);
            data13{i,5} = X1;
            save('data13')
        end
        if state < data13{i,4}
            state = data13{i,4};
            disp(state);
        end
    end
end
function ff_data = ff_team_O13(pilot,chassis,pp)
    eval(char(pilot));
    eval(char(chassis));
    eval(char(pp));

    suspension_front = struct(...
        'model',    'Öhlins TTX25 MKII',...
        'location', 'inboard',...
        'angle',    44,...
        'travel',   randi(11)/2 + 0.5,...
        'k',        randi(19)*25+25,...
        'c',        rand()*250);

    suspension_rear = struct(...
        'model',    'Öhlins TTX25 MKII',...
        'location', 'inboard',...
        'angle',    31,...
        'travel',   randi(11)/2 + 0.5,...
        'k',        randi(19)*25+25,...
        'c',        rand()*250);

    wheel_front = struct(...
        'model',        '18x6–10 R25B',...
        'weight',       25,...
        'travel',       rand()*2+2,...
        'deflection',   2,...
        'k',            rand()*1250+250,...
        'c',            3);

    wheel_rear = struct(...
        'model',        '18x6–10 R25B',...
        'weight',       30,...
        'travel',       rand()*2+2,...
        'deflection',   2,...
        'k',            rand()*1250+250,...
        'c',            3);
    
    if strcmp(pp,'motor_2014()')
        v_top = 62;
        t60 = 3.4;
    elseif strcmp(pp,'motor_2016()')
        v_top = 80;
        t60 = 3.5;
    else
        v_top = 80;
        t60 = 3;        
    end
    
    FSAE_Race_Car = struct(...
        'team',             'Team O',...
        'year',             2017,...
        'top_speed',        v_top,...
        't2top_speed',      t2top_speed(t60,v_top),...
        'pilot',            pilot,...
        'chassis',          chassis,...
        'power_plant',      power_plant,...
        'suspension_front', suspension_front,...
        'suspension_rear',  suspension_rear,...
        'wheel_front',      wheel_front,...
        'wheel_rear',       wheel_rear);

    ff_data = struct(...
        't_prev',       0,...
        'X_prev',       0,...
        'car',          FSAE_Race_Car,...
        'model',        'full_car_7_DOF',...
        'trajectory',   @trajectory,...
        't_in',         0,...
        't_out',        2,...
        'V_in',         30,...
        'V_out',        10,...
        'N',            50,...
        'roadway_d',    @agony,...
        'X_enter_d',    0,...
        'roadway_p',    @agony,...
        'X_enter_p',    1);
end
function ff_data = ff_team_O10(pilot,chassis,pp)
    eval(char(pilot));
    eval(char(chassis));
    eval(char(pp));

    suspension_front = struct(...
        'model',    'Öhlins TTX25 MKII',...
        'location', 'inboard',...
        'angle',    44,...
        'travel',   randi(11)/2 + 0.5,...
        'k',        randi(19)*25+25,...
        'c',        rand()*250);

    suspension_rear = struct(...
        'model',    'Öhlins TTX25 MKII',...
        'location', 'inboard',...
        'angle',    31,...
        'travel',   randi(11)/2 + 0.5,...
        'k',        randi(19)*25+25,...
        'c',        rand()*250);

    wheel_front = struct(...
        'model',        '18x6–10 R25B',...
        'weight',       20,...
        'travel',       rand()*2+2,...
        'deflection',   2,...
        'k',            rand()*650+100,...
        'c',            3);

    wheel_rear = struct(...
        'model',        '18x6–10 R25B',...
        'weight',       25,...
        'travel',       rand()*2+2,...
        'deflection',   2,...
        'k',            rand()*650+100,...
        'c',            3);

    FSAE_Race_Car = struct(...
        'team',             'Texas A&M',...
        'year',             2017,...
        'top_speed',        80,...
        't2top_speed',      t2top_speed(3,80),...
        'pilot',            pilot,...
        'chassis',          chassis,...
        'power_plant',      power_plant,...
        'suspension_front', suspension_front,...
        'suspension_rear',  suspension_rear,...
        'wheel_front',      wheel_front,...
        'wheel_rear',       wheel_rear);

    ff_data = struct(...
        't_prev',       0,...
        'X_prev',       0,...
        'car',          FSAE_Race_Car,...
        'model',        'full_car_7_DOF',...
        'trajectory',   @trajectory,...
        't_in',         0,...
        't_out',        2,...
        'V_in',         30,...
        'V_out',        10,...
        'N',            50,...
        'roadway_d',    @agony,...
        'X_enter_d',    0,...
        'roadway_p',    @agony,...
        'X_enter_p',    1);
end
function [ x1 ] = optimize_car(f, D) %#ok<*DEFNU>
    
    TolX = 0.1;
    step = [1.5, 0.1, 0.5, 1.5, 0.1, 0.5, 1, .1, 1, .1];
    x0 = [D.car.suspension_front.k;...
        D.car.suspension_front.c;...
        D.car.suspension_front.travel;...
        D.car.suspension_rear.k;...
        D.car.suspension_rear.c;...
        D.car.suspension_rear.travel;...
        D.car.wheel_front.k;...
        D.car.wheel_front.travel;...
        D.car.wheel_rear.k;...
        D.car.wheel_rear.travel];
    
%     fprintf('\n%f \n%s \n%s \n%f \n',objective_function(D,x0),D.car.pilot.name,D.car.power_plant.model,D.car.chassis.year)
%     disp(x0);
%     fprintf('\n');
    
    while true
%         fprintf('>> ')
        H = Hessian(x0);
        G = Gradient(x0);
        x1 = opti_jump(x0,-H\G);
        
        if norm(x1-x0) < TolX
%             fprintf('\n\n');
            break
        end
        
        x0 = x1;
%         fprintf('\n%f \n%s \n%s \n%f \n',objective_function(D,x0),D.car.pilot.name,D.car.power_plant.model,D.car.chassis.year)
%         disp(x0);
%         fprintf('\n');
    end    
    
    function [ H ] = Hessian(X)
        H = zeros(10);
        for i = 1:10
            for j = 1:10
                H(i,j) = hessian_entry(i,j,step(i),step(j));
            end
        end
        function [ entry ] = hessian_entry(X1,X2,h1,h2)
%             fprintf('.')
            X_1 = X; X_1(X1) = X_1(X1) + h1; X_1(X2) = X_1(X2) + h2;
            X_2 = X; X_2(X1) = X_2(X1) + h1; X_2(X2) = X_2(X2) - h2;
            X_3 = X; X_3(X1) = X_3(X1) - h1; X_3(X2) = X_3(X2) + h2;
            X_4 = X; X_4(X1) = X_4(X1) - h1; X_4(X2) = X_1(X2) - h2;
            entry = (f(D,X_1) - f(D,X_2) - f(D,X_3) + f(D,X_4))/(4*h1*h2);
        end
    end
    function [ Del_F ] = Gradient(X)
        Del_F = zeros(10,1);
        for i = 1:10
            X_1 = X; X_1(i) = X_1(i) + step(i);
            X_2 = X; X_2(i) = X_2(i) - step(i);
            Del_F(i) = (f(D,X_1) - f(D,X_2))/(2*step(i));
        end
    end
    function [ x0 ] = opti_jump(x0,HG)
        max_x = x0;
        max_phi = objective_function(D,x0);
        for i = .1:.1:1
            if objective_function(D,coerce(x0+HG*i)) > max_phi
                max_phi = objective_function(D,coerce(x0+HG*i));
                max_x = coerce(x0+HG*i);
            end
        end
        x0 = max_x;
%         while norm(HG) > 0.01
%             mid1 = objective_function(D,x0+HG/2);
%             mid2 = objective_function(D,x0+HG/1.85);
%             if mid1 > mid2
%                 HG = HG /2;
%             else
%                 x0 = coerce(x0 + HG /2);
%                 HG = HG /2;
%             end
%         end
    end
end
function [x] = coerce(x)
    if x(1) < 50
        x(1) = 50;
    elseif x(1) > 500
        x(1) = 500;
    else
        x(1) = round(x(1)/25)*25;
    end
    
    if x(2) < 0
        x(2) = 0;
    elseif x(2) > 250
        x(2) = 250;
    end
    
    if x(3) < 1
        x(3) = 1;
    elseif x(3) > 6
        x(3) = 6;
    else
        x(3) = round(x(3)/.5)*.5;
    end
    
    if x(4) < 50
        x(4) = 50;
    elseif x(4) > 500
        x(4) = 500;
    else
        x(4) = round(x(4)/25)*25;
    end
    
    if x(5) < 0
        x(5) = 0;
    elseif x(5) > 250
        x(5) = 250;
    end
    
    if x(6) < 1
        x(6) = 1;
    elseif x(6) > 6
        x(6) = 6;
    else
        x(6) = round(x(6)/.5)*.5;
    end
    
    if x(7) < 100
        x(7) = 100;
    elseif x(7) > 750
        x(7) = 750;
    end
    
    if x(8) < 2
        x(8) = 2;
    elseif x(8) > 4
        x(8) = 4;
    end
    
    if x(9) < 100
        x(9) = 100;
    elseif x(9) > 750
        x(9) = 750;
    end
    
    if x(10) < 2
        x(10) = 2;
    elseif x(10) > 4
        x(10) = 4;
    end
end
function [phi] = objective_function(D,X)
    D.car.suspension_front.k        = X(1);
    D.car.suspension_front.c        = X(2);
    D.car.suspension_front.travel   = X(3);
    D.car.suspension_rear.k         = X(4);
    D.car.suspension_rear.c         = X(5);
    D.car.suspension_rear.travel    = X(6);
    
    D.car.wheel_front.k         = X(7);
    D.car.wheel_front.c         = 25 - 23*(X(7)-100)/(750-100);
    D.car.wheel_front.travel    = X(8);
    D.car.wheel_rear.k          = X(9);
    D.car.wheel_rear.c          = 25 - 23*(X(9)-100)/(750-100);
    D.car.wheel_rear.travel    	= X(10);

    FN  = @(t, D) get_forcing_function(t, D);
    X0  = get_static_deflection(D.model, D.car);
    DOF = size(X0, 1);
    V0  = zeros(DOF, 1);
    M   = get_mass_matrix(D.model, D.car);
    C   = get_damping_matrix(D.model, D.car);
    K   = get_stiffness_matrix(D.model, D.car);

    % integrate
    [~, X, ~, ~] = Newmark(X0, V0, zeros(DOF, 3), M, C, K, FN, D);

    % calculate axle plane values
    lf = D.car.chassis.radius_f/12;
    lr = D.car.chassis.radius_r/12;
    L = lf + lr;
    rf = D.car.chassis.radius_f/12;
    rr = D.car.chassis.radius_r/12;
    W = rf + rr;
    axle_matrix = [lr/(2*L), lr/(2*L), lf/(2*L), lf/(2*L);...
        -1/(2*L), -1/(2*L), 1/(2*L), 1/(2*L);...
        -1/(2*W), 1/(2*W), 1/(2*W), -1/(2*W);...
        -rr/W, rr/W, -rf/W, rf/W];
    z_axle = (axle_matrix * X(:,4:7)')';
    
    target_heave = 8 - 5.11 + 0.2340;
    target_pitch = 6 - 4.91 + .13;
    target_roll = 3 - 1.55 + 0.0241;
    
    phi1 = norm(z_axle(:,1)*12)/max([10^-16,abs(norm(X(:,1)*12 - z_axle(:,1)*12) - target_heave)]);
    phi2 = norm(z_axle(:,2)*180/pi)/max([10^-16,abs(norm(X(:,2)*180/pi - z_axle(:,2)*180/pi) - target_pitch)]);
    phi3 = norm(z_axle(:,3)*180/pi)/max([10^-16,abs(norm(X(:,3)*180/pi - z_axle(:,3)*180/pi) - target_roll)]);

    phi = (phi1 + phi2 + phi3)/ max([phi1,phi2,phi3]);
end