function [LR] =  get_leverage_ratio(front_or_rear,FSAE_Race_Car)
    %get_leverage_ratio - A function for finding the leverage ratio: 
    %   a scale between the stiffness k and damping c coefficients 
    %   to the actual shock absorber assembly effective values
    %
    %   USAGE
    %[LR] = get_leverage_ratio(front_or_rear,FSAE_Race_Car)
    %
    %   INPUT
    %front_or_rear      a char defining which half of the car to use.
    %                   Either "front" or "rear"
    %FSAE_Race_Car      a struct defining which car to do analysis on
    %
    %   OUTPUT
    %LR                 The effective leverage ratio given the car and
    %                   the location of interest
    
    
    if ischar(front_or_rear) == 0 
        error(['Error: Input type.',...
            '\n\tfront_or_rear must be a char, not a %s'],class(front_or_rear));        
    elseif isstruct(FSAE_Race_Car) == 0
        error(['Error: Input type.',...
            '\n\tFSAE_Race_Car must be a struct, not a %s'],class(FSAE_Race_Car));
    elseif strcmp(front_or_rear,'front') == 0 && strcmp(front_or_rear,'rear') == 0
        error('Error: invalid input. Acceptable formats are "front" and "rear"')
    end
    
    if strcmp(front_or_rear,'front') == 1
        if strcmp(FSAE_Race_Car.suspension_front.location,'inboard') == 1
            LR = power(FSAE_Race_Car.suspension_front.travel/FSAE_Race_Car.wheel_front.travel,2);
        else
            LR = cos(FSAE_Race_Car.suspension_front.angle);
        end
    else
        if strcmp(FSAE_Race_Car.suspension_rear.location,'inboard') == 1
            LR = power(FSAE_Race_Car.suspension_rear.travel/FSAE_Race_Car.wheel_rear.travel,2);
        else
            LR = cos(FSAE_Race_Car.suspension_rear.angle);
        end
    end
    
    
end
