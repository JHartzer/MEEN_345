function [ x_opt, y_opt ] = optinewton2V( f, x, y )
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    
    if ~isscalar(x)
        error('Error: x must be a scalar');
    elseif ~isscalar(y)
        error('Error: y must be a scalar');
    elseif ~isa(f,'function_handle')
        error('Error: input f must be a function handle')
    end
    
    TolX = 0.001;
    h = 0.1;
    x0 = [x;y];
    
    while true
        x1 = x0 - Hessian(f,x0(1),x0(2),h)\Gradient(f,x0(1),x0(2),h);
        if norm(x1-x0) < TolX
            x_opt = x1(1);
            y_opt = x1(2);
            break
        end
        x0 = x1;
    end    
    
    function [ H ] = Hessian(f,x,y,h)

        d2f_dx2 = (f(x+h,y)-2*f(x,y)+f(x-h,y))/(h^2);
        d2f_dy2 = (f(x,y+h)-2*f(x,y)+f(x,y-h))/(h^2);
        d2f_dxdy = (f(x+h,y+h) - f(x+h,y-h) - f(x-h,y+h) + f(x-h,y-h))/(4*h^2);

        H = [d2f_dx2, d2f_dxdy;...
            d2f_dxdy, d2f_dy2];
    end
    function [ Del_F ] = Gradient(f,x,y,h)
        df_dx = (f(x+h,y) - f(x-h,y))/(2*h);
        df_dy = (f(x,y+h) - f(x,y-h))/(2*h);
        
        Del_F = [df_dx; df_dy];
    end
end

