function [t, X, V] = trajectory(t, X, h, t_in, t_out, V_in, V_out, FSAE_Race_Car)
    %trajectory - function to construct a generic trajectory that 
    %   accelerates or decelerates a car over a specified time 
    %   interval assuming a haversine velocity profile from entry 
    %   point to exit poin
    %
    %   USAGE
    %[t, X, V] = trajectory(t, X, h, t_in, t_out, V_in, V_out, FSAE_Race_Car)
    %
    %   INPUT
    %t              time at beginning of integration step (in sec) 
    %X              front axle location at beginning of step (in ft) 
    %h              time step size of integration (in sec) 
    %t_in           time upon entering the trajectory (in sec) 
    %t_out          time when leaving the trajectory (in sec) 
    %V_in           velocity upon entering the trajectory (in mph) 
    %V_out          velocity when leaving the trajectory (in mph) 
    %FSAE_Race_Car  struct the SAE formula race car being drive
    %
    %   OUTPUT
    %t              time at the end of the integration step (in sec) 
    %X              location of front axle at end of the step (in ft) 
    %V              velocity of the vehicle at end of step (in ft/sec)
    
    % Data input check
    if isscalar(t) == 0 || ischar(t)
        error(['Error: Input type.',...
            '\n\tt must be a scalar, not a %s'],class(t));   
    elseif isscalar(X) == 0 || ischar(X)
        error(['Error: Input type.',...
            '\n\tX must be a scalar, not a %s'],class(X));  
    elseif isscalar(h) == 0 || ischar(h)
        error(['Error: Input type.',...
            '\n\th must be a scalar, not a %s'],class(h));  
    elseif isscalar(t_in) == 0 || ischar(t_in)
        error(['Error: Input type.',...
            '\n\tt_in must be a scalar, not a %s'],class(t_in));  
    elseif isscalar(t_out) == 0 || ischar(t_out)
        error(['Error: Input type.',...
            '\n\tt_out must be a scalar, not a %s'],class(t_out));  
    elseif isscalar(V_in) == 0 || ischar(V_in)
        error(['Error: Input type.',...
            '\n\tV_in must be a scalar, not a %s'],class(V_in));  
    elseif isscalar(V_out) == 0 || ischar(V_out)
        error(['Error: Input type.',...
            '\n\tV_out must be a scalar, not a %s'],class(V_out));         
    elseif isstruct(FSAE_Race_Car) == 0
        error(['Error: Input type.',...
            '\n\tFSAE_Race_Car must be a struct, not a %s'],class(FSAE_Race_Car));
    end
    
    t_top = FSAE_Race_Car.t2top_speed;
    
    % Checks for inputs to follow given conventions
    if t_in < 0
        error('Error: t_in must be nonnegative')
    elseif t_out <= t_in
        error('Error:  t_out must be greater than t_in')
    elseif t_in > t
        error('Error: t_in must be less than or equal to t')
    elseif h <= 0
        error('Error: h must be positive')
    elseif round((t+h)*1000)/1000 > t_out
        error('Error: t+h must be less than or equal to t_out')
    elseif X < 0
        error('Error:  X must be nonnegative')
    elseif V_in < 0
        error('Error: V_in must be nonnegative')
    elseif V_out < 0
        error('Error: V_out must be nonnegative')
    elseif FSAE_Race_Car.top_speed < V_in
        error('Error: V_in must be less than top speed')
    elseif FSAE_Race_Car.top_speed < V_out
        error('Error: V_out must be less than top speed')
    elseif (V_out - V_in)/(t_out - t_in) > FSAE_Race_Car.top_speed/t_top
        error('Error: function specifies an acceleration that exceeds capability of vehicle')
    elseif -1.4 * 32.174 > (V_out - V_in)*5280/3600 /(t_out - t_in)
        error('Error: function specifies brake that exceed capability of vehicle')
    end
    
    Vf = @(t) (V_in + (V_out - V_in)/2 * (1 - cos(pi * (t - t_in)/(t_out - t_in))))*5280/3600;
    
    X = X + (h/6) * (Vf(t) + 4*Vf(t + h/2) + Vf(t + h));
    t = t + h;
    
    V = Vf(t);
end

