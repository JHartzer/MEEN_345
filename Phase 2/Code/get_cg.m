function [ cg ] = get_cg(FSAE_Race_Car)
    %get_cg - A function for finding the center of mass of the given
    %   race car model as measured from the front axle of the vehicle.
    %
    %   USAGE
    %[ cg ] = get_cg(FSAE_Race_Car)
    %
    %   INPUT
    %FSAE_Race_Car      a struct defining which car to find the cent
    %                   of mass of
    %
    %   OUTPUT
    %cg                 The distance (in feet) from the front axle of
    %                   the vehicle to the center of mass.
    
    if isstruct(FSAE_Race_Car) == 0
        error('Error: FSAE_Race_Car must be of type struct');
    end
    
    torque = ...
        FSAE_Race_Car.pilot.weight * 0.60 * (FSAE_Race_Car.chassis.seat_X/12 - FSAE_Race_Car.pilot.girth/12/(2*pi)) +...
        FSAE_Race_Car.pilot.weight * 0.40 * (FSAE_Race_Car.chassis.seat_X/12 - FSAE_Race_Car.pilot.height/12 * 0.60 / 2) +...
        FSAE_Race_Car.power_plant.weight*FSAE_Race_Car.chassis.motor_X/12 +...
        FSAE_Race_Car.chassis.weight * FSAE_Race_Car.chassis.cg_X/12;
    
    weight = ...
        FSAE_Race_Car.pilot.weight +...
        FSAE_Race_Car.chassis.weight +...
        FSAE_Race_Car.power_plant.weight;
    
    cg = torque / weight;
end

