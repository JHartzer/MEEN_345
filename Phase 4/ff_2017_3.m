car_2017();

ff_data = struct(...
    't_prev',       0,...
    'X_prev',       0,...
    'car',          FSAE_Race_Car,...
    'model',        'half_car_2_DOF',...
    'trajectory',   @trajectory,...
    't_in',         0,...
    't_out',        2,...
    'V_in',         30,...
    'V_out',        10,...
    'N',            5000,...
    'roadway_d',    @agony,...
    'X_enter_d',    0,...
    'roadway_p',    @agony,...
    'X_enter_p',    0);