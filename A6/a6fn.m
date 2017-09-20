function [ f ] = a6fn( x,y )
    %f(x,y)= 2x y+5x?9y?7x^2?9y^2 
    
    if ~isscalar(x)
        error('Error: x must be a scalar');
    elseif ~isscalar(y)
        error('Error: y must be a scalar');
    end
    
    f = 2.*x.*y +5.*x - 9.*y - 7.*x.^2 - 9.*y.^2;
    
end

