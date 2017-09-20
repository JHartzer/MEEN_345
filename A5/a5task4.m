clc; clear all; close all;

trap_data = zeros(10,2);
simp_data = zeros(10,2);

for intervals = 2:2:20
    h = 4/intervals;
    x = 0:h:4;
    fx = x.*sin(x);
    trap_data(intervals/2,:) = [intervals, trapint(x, fx) ];
    simp_data(intervals/2,:) = [intervals, simpint13(h, fx)];
end

f_true = -4*cos(4)+sin(4);

p = plot(trap_data(:,1),trap_data(:,2),simp_data(:,1),simp_data(:,2),[2,20],[f_true,f_true]);
p(1).Marker = 'o';
p(2).Marker = 's';
legend('Trapezoidal Numeric Integration','Simpson''s 1/3 Rule Numeric Integration','True Value')
xlabel('Iterations');
ylabel('Value from Integration');
title('Testing Numerical Integration Methods');