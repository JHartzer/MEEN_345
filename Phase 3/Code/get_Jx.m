function [ Jx ] = get_Jx(FSAE_Race_Car)
    %get_Jx - A function for computing the roll moment of inertia of 
    %   the given car model.
    %
    %   USAGE
    %[ Jx ] = get_Jx(FSAE_Race_Car)
    %
    %   INPUT
    %FSAE_Race_Car      a struct defining which car to do analysis on
    %
    %   OUTPUT
    %Jx                 The moment of roll inertia of the sprung mass 
    %                   of the given vehicle model in slug-ft^2
    
    if isstruct(FSAE_Race_Car) == 0
        error('Error: FSAE_Race_Car must be of type struct');
    end
    
    I_chassis = FSAE_Race_Car.chassis.weight/32.174 * power(FSAE_Race_Car.chassis.diameter/12/2,2);
    I_engine = 2/5 * FSAE_Race_Car.power_plant.weight/32.174 * power(FSAE_Race_Car.power_plant.diameter/12/2,2);
    I_legs = 1/2 * FSAE_Race_Car.pilot.weight/32.174 * 0.4 * power(FSAE_Race_Car.pilot.girth/(2*pi)/12,2);
    I_torso = 1/12 * FSAE_Race_Car.pilot.weight/32.174 * 0.6 * (3*power(FSAE_Race_Car.pilot.girth/(2*pi)/12,2)+power(FSAE_Race_Car.pilot.height*0.4/12,2));
    
    Jx = ...
        I_chassis + FSAE_Race_Car.chassis.weight/32.174 * power(FSAE_Race_Car.chassis.cg_Z/12,2) +...
        I_engine + FSAE_Race_Car.power_plant.weight/32.174 * power(FSAE_Race_Car.chassis.motor_Z/12,2) +...
        I_legs + FSAE_Race_Car.pilot.weight/32.174 * 0.4 * power(FSAE_Race_Car.chassis.seat_Z/12 + FSAE_Race_Car.pilot.girth/12/(2*pi), 2) +...
        I_torso + FSAE_Race_Car.pilot.weight/32.174 * 0.6 * power(FSAE_Race_Car.chassis.seat_Z/12 + FSAE_Race_Car.pilot.girth/12/pi + FSAE_Race_Car.pilot.height/12/5,2);
        
    
    
    
end

