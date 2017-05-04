function [R_f, R_r, dRdt_f, dRdt_r] = agony(wheelbase, X_enter, X, V)
    %agony - A function that returns the forcing function for a 
    %   vehicle driving down agony road
    %
    %   USAGE
    %[R_f, R_r, R_dot_f, R_dot_r] = agony(wheelbase, X_enter, X, V)
    %
    %   INPUT 
    %wheelbase  Distance between axles (in ft) 
    %X_enter    Location of the front axle along a roadway that locates the entrance point of speed bump (in ft) 
    %X          Location of front axle along the roadway (in ft) 
    %V          Velocity of the vehicle (in ft/sec) 
    %
    %   OUTPUT 
    %R_f        Vertical displacement of front wheel (in ft) 
    %R_r        Vertical displacement of rear wheel (in ft) 
    %R_dot_f    Vertical velocity of the front wheel (in ft/sec) 
    %R_dot_r    Vertical velocity of the rear wheel (in ft/sec)
    
    % Type check
    if isscalar(wheelbase) == 0 || ischar(wheelbase)
        error(['Error: Input type.',...
            '\n\twheelbase must be a scalar, not a %s'],class(wheelbase));   
    elseif isscalar(X_enter) == 0 || ischar(X_enter)
        error(['Error: Input type.',...
            '\n\tX_enter must be a scalar, not a %s'],class(X_enter));  
    elseif isscalar(X) == 0 || ischar(X)
        error(['Error: Input type.',...
            '\n\tX must be a scalar, not a %s'],class(X));  
    elseif isscalar(V) == 0 || ischar(V)
        error(['Error: Input type.',...
            '\n\tV must be a scalar, not a %s'],class(V));  
    end
    
    % Convention check
    if wheelbase <= 0
        error('Error: wheelbase must be positive')
    elseif X < 0
        error('Error: X must be nonnegative')
    elseif V < 0
        error('Error: V must be nonnegative')
    end
    
    % Initial 3ft flat section
    X = X-3;
    
    % Front wheel
    if X <= X_enter || X - X_enter >= 25 + 1 + 15 + 2
        R_f = 0;
        dRdt_f = 0;
    elseif X - X_enter < 25
        [R_f, dRdt_f] = bump(25, 1, 0, X - X_enter, V);
    elseif X - X_enter < 25 + 1
        [R_f, dRdt_f] = bump(1, -3/12, 0.75, X - X_enter - 25, V);
    elseif X - X_enter < 25 + 1 + 15
        [R_f, dRdt_f] = bump(15, -1, 3, X - X_enter - (25 + 1), V);
    elseif X - X_enter < 25 + 1 + 15 + 2
        [R_f, dRdt_f] = bump(2, -3/12, 1.75, X - X_enter - (25 + 1 + 15), V);
    end
    
    % Rear wheel
    X_rear = X - wheelbase;
    if X_rear <= X_enter || X_rear - X_enter >= 25 + 1 + 15 + 2
        R_r = 0;
        dRdt_r = 0;
    elseif X_rear - X_enter < 25
        [R_r, dRdt_r] = bump(25, 1, 0, X_rear - X_enter, V);
    elseif X_rear - X_enter < 25 + 1
        [R_r, dRdt_r] = bump(1, -3/12, 0.75, X_rear - X_enter - 25, V);
    elseif X_rear - X_enter < 25 + 1 + 15
        [R_r, dRdt_r] = bump(15, -1, 3, X_rear - X_enter - (25 + 1), V);
    elseif X_rear - X_enter < 25 + 1 + 15 + 2
        [R_r, dRdt_r] = bump(2, -3/12, 1.75, X_rear - X_enter - (25 + 1 + 15), V);
    end
end
