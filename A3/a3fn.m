function [theta] = a3fn( x )
    % This returns an evaluation of the beam function with an example
    %   load weight, young' modulus, and second moment.
    %
    %   USAGE 
    %f = a3fn(x)
    %
    %   INPUT
    %x      scalar      A positive number
    %
    %   OUTPUT
    %theta  scalar      Solution to the function
    
    if x < 0
        error('Error: x must be positive')
    end
    
    L = 4; %as specified by Dr. Mukherjee
    a = L/2.5;
        
    theta = -1.2 * a^2 + 0.6 * x.^2 - max(x-a,0).^2;
    
end

