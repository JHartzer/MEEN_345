function [ t_top ] = t2top_speed(t_60,v_top)
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    t_top = pi*t_60 / acos((v_top-120)/v_top);
    
end

