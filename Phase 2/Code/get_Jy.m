function [ Jy ] = get_Jy(FSAE_Race_Car)
    %get_Jy - A function for computing the moment of inertia of the
    %   given car model.
    %
    %   USAGE
    %[ Jy ] = get_Jy(FSAE_Race_Car)
    %
    %   INPUT
    %FSAE_Race_Car      a struct defining which car to do analysis on
    %
    %   OUTPUT
    %Jy                 The moment of inertia of the sprung mass of
    %                   the given vehicle model in slug-ft^2
    
    if isstruct(FSAE_Race_Car) == 0
        error('Error: FSAE_Race_Car must be of type struct');
    end
    
    I_chassis = 1/12 * FSAE_Race_Car.chassis.weight/32.174 * (6 * power(FSAE_Race_Car.chassis.diameter/2/12,2) + power(FSAE_Race_Car.chassis.length/12,2));
    I_engine = 2/5*FSAE_Race_Car.power_plant.weight/32.174 * power(FSAE_Race_Car.power_plant.diameter/2/12,2);
    I_legs = 1/12 * 0.40 * FSAE_Race_Car.pilot.weight/32.174 * (3 * power(FSAE_Race_Car.pilot.girth/12/(2*pi) ,2) + power(FSAE_Race_Car.pilot.height/12 * 0.60,2));
    I_torso = 1/12 * 0.60 * FSAE_Race_Car.pilot.weight/32.174 * (3 * power(FSAE_Race_Car.pilot.girth/12/(2*pi) ,2) + power(FSAE_Race_Car.pilot.height/12 * 0.40,2));
    
    cg = get_cg(FSAE_Race_Car);
    
    Jy = ...
        I_chassis + FSAE_Race_Car.chassis.weight/32.174 * power(cg - FSAE_Race_Car.chassis.cg_X,2) +...
        I_engine + FSAE_Race_Car.power_plant.weight/32.174 * power(cg - FSAE_Race_Car.chassis.motor_X,2) +...
        I_legs + FSAE_Race_Car.pilot.weight/32.174 * 0.40 * power(cg - (FSAE_Race_Car.chassis.seat_X/12 - FSAE_Race_Car.pilot.height/12 * 0.60 / 2),2) +...
        I_torso + FSAE_Race_Car.pilot.weight/32.174 * 0.60 * power(cg - (FSAE_Race_Car.chassis.seat_X/12 - FSAE_Race_Car.pilot.girth/12/(2*pi)),2);
        
    
    
    
end

