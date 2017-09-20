function [ dydx ] = Rossler_attractor(~, y)
    %Rossler_attractor - A function that returns a system of 
    %   differential equations known as the Rossler attractor
    
    if ~isnumeric(y)
        error('Error: y must be a numeric array');
    elseif length(y) ~= 3 || min(size(y)) ~= 1
        error('Error: y must be a vector of length 3')
    end
    
    a = 1/4;
    b = 1;
    c = 5.5;
    dydx = [-y(2)-y(3);...
            y(1) + a*y(2);...
            b + y(3)*(y(1)-c)];
    
    
end