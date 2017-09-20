clc; clear all; close all;

station = 0:3:30;
half_areas = [0, 0.31, 0.99, 1.77, 2.4, 2.73, 2.55, 2.07, 1.32, 0.585, 0];

vol_trap = trapint(station, half_areas*2);
vol_simp = simpint13(3, half_areas*2);

fprintf(['According to the Trapezoidal Numeric Integration Routine,'...
    ' the boat should weigh %.4f pounds\n\n'],vol_trap*power(12,-3)*62.4);

fprintf(['According to Simpson''s 1/3 Numeric Integration Routine,'...
    ' the boat should weigh %.4f pounds\n\n'],vol_simp*power(12,-3)*62.4);

