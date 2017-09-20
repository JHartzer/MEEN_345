function [ y1 ] = ode_Kutta(Kutta, f, h, x0, y0)
    %ode_Kutta - a solver for Kutta's Method
    %
    %   Inputs: 
    %Kutta: An instance of the Kutta data struct. 
    %f :       A function handle to the right-hand side of an ODE, e.g., dy/dx = f(x,y). 
    %h :      step size, viz., x 1 = x 0 + h. 
    %x0 :     Independent variable at beginning of step. 
    %y0 :     Dependent variable at beginning of step, i.e., the initial condition. 
    %   
    %   Output: 
    %y1 :     Dependent variable at end of one step, same dimension as f.
    
    if ~isstruct(Kutta)
        error('Error: Kutta must be a struct')
    elseif ~isscalar(x0)
        error('Error: x0 must be a scalar')
    elseif ~isscalar(h)
        error('Error: h must be a scalar')
    elseif h <= 0
        error('Error: h must be positive')
    elseif ~isa(f,'function_handle')
        error('Error: input FN must be a function handle')
    end
    
    k1 = f(x0,y0);
    
    if size(k1) ~= size(y0)
        error('Error: f must output an array of equal dimensions to y0');
    end
    
    k2 = f(x0 + Kutta.c1*h, y0 + h*(Kutta.A11*k1));
    k3 = f(x0 + Kutta.c2*h, y0 + h*(Kutta.A21*k1 + Kutta.A22*k2));
    k4 = f(x0 + Kutta.c3*h, y0 + h*(Kutta.A31*k1 + Kutta.A32*k2 + Kutta.A33*k3));
    
    y1 = y0 + h*(Kutta.b1*k1 + Kutta.b2*k2 + Kutta.b3*k3 + Kutta.b4*k4);
end

