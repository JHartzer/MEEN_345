
driver_harry();
chassis_2014();
motor_2014();
suspension_front_2014();
suspension_rear_2014();
wheel_front_2014();
wheel_rear_2014();


FSAE_Race_Car = struct(...
    'team',             'Texas A&M',...
    'year',             2014,...
    'top_speed',        62,...
    't2top_speed',      t2top_speed(3.4,62),...
    'pilot',            pilot,...
    'chassis',          chassis,...
    'power_plant',      power_plant,...
    'suspension_front', suspension_front,...
    'suspension_rear',  suspension_rear,...
    'wheel_front',      wheel_front,...
    'wheel_rear',       wheel_rear);


