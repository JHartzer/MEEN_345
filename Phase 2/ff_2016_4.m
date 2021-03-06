car_2016();

ff_data = struct(...
    't_prev',       0,...
    'X_prev',       0,...
    'car',          FSAE_Race_Car,...
    'model',        'half_car_4_DOF',...
    'trajectory',   @trajectory,...
    't_in',         0,...
    't_out',        .25,...
    'V_in',         60,...
    'V_out',        60,...
    'N',            2500,...
    'roadway_d',    @tar_strip,...
    'X_enter_d',    1,...
    'roadway_p',    @tar_strip,...
    'X_enter_p',    1);