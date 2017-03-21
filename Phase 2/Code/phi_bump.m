function [ phi ] = phi_bump( X, length, top)
    %phi_bump - A function for describing the angle of the haversine
    %   function for the bump function.
    %
    %   USAGE
    %[ phi ] = phi_bump( X ) 
    %
    %   INPUT 
    %X          Position along the bump: 0 < X < length (in ft) 
    %length     Overall length of the bump: length > 0 (in ft) 
    %top        Flat region on bump: 0 £ top < length (in ft)
    %
    %   OUTPUT 
    %phi        Angle supplied to haversine function
    
    if 0 < X && X < (length-top)/2
        phi = 2*pi*X/(length-top);
    elseif X <= (length+top)/2
        phi = pi;
    elseif X <= length
        phi = 2*pi*(X-top)/(length-top);
    else
        error('Error: X must satisfy 0 < X < length');
    end
end

