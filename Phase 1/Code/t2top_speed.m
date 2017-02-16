function [t_top] = t2top_speed(t_60,v_top)
    %t2top_speed - Function for estimating time to reach top speed
    %   from 0-60 time and top speed 
    %
    %   USAGE
    %[t_top] = t2top_speed(t_60,v_top)
    %
    %   INPUT
    %t_60       The vehicle's 0 to 60 (mph) time (sec)
    %v_top      The vehicle's top speed (mph)
    %
    %   OUTPUT
    %t_top      The estimated time to reach the top speed (sec)

    t_top = pi*t_60 / acos((v_top-120)/v_top);
    
end

