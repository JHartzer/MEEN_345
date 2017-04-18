function[R, dRdt] = bump(length, height, top, X, V) 
    %bump - A function for supplying a topology for an arbitrary bump 
    %   geometry.  The geometry of this bump is modeled as a modified 
    %   haversine function
    %
    %   USAGE
    %[R, dRdt] = bump(length, height, top, X, V) 
    %
    %   INPUT 
    %length     Overall length of the bump: length > 0 (in ft) 
    %height     The maximum height of the bump (in ft) 
    %top        Flat region on bump: 0 £ top < length (in ft) 
    %X          position along bump: 0 £ X £ length (in ft) 
    %V          The velocity of the vehicle (in ft/sec) 
    %
    %   OUTPUT 
    %R          The vertical displacement of a wheel going over  a bump (in ft) 
    %dRdt       The vertical velocity of a wheel going over a bump (in ft/sec)
    
    
    %Verify input types
    if isscalar(length) == 0 || ischar(length)
        error(['Error: Input type.',...
            '\n\tlength must be a scalar, not a %s'],class(length));   
    elseif isscalar(height) == 0 || ischar(height)
        error(['Error: Input type.',...
            '\n\theight must be a scalar, not a %s'],class(height));  
    elseif isscalar(top) == 0 || ischar(top)
        error(['Error: Input type.',...
            '\n\ttop must be a scalar, not a %s'],class(top));  
    elseif isscalar(X) == 0 || ischar(X)
        error(['Error: Input type.',...
            '\n\tX must be a scalar, not a %s'],class(X));  
    elseif isscalar(V) == 0 || ischar(V)
        error(['Error: Input type.',...
            '\n\tV must be a scalar, not a %s'],class(V));  
    end
    
    % Convention check
    if length <= 0 
        error('Error: length must be positive');
    elseif top < 0
        error('Error: top must be positive');
    elseif length <= top
        error('Error: top must be less than length');
    elseif V < 0
        error('Error: V must be positive');
    end
    
    R = height/2 * (1- cos(phi_bump(X, length, top)));
    dRdt = pi * height/(length-top) * sin(phi_bump(X, length, top))*V;
end

