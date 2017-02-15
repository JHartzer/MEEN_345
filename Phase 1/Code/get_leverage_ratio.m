function [LR] =  get_leverage_ratio(front_or_rear,FSAE_Race_Car)
    %The function needs to return an informative help message when 
        %called via help get_mass_matrix.
    
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
