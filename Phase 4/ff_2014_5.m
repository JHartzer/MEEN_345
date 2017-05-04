car_2014();

ff_data = struct(...
    't_prev',       0,...
    'X_prev',       0,...
    'car',          FSAE_Race_Car,...
    'model',        'full_car_3_DOF',...
    'trajectory',   @trajectory,...
    't_in',         0,...
    't_out',        1.5,...
    'V_in',         5,...
    'V_out',        5,...
    'N',            2500,...
    'roadway_d',    @speed_bump,...
    'X_enter_d',    1,...
    'roadway_p',    @speed_bump,...
    'X_enter_p',    3);