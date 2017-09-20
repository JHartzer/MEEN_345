function [d_theta] = a3dfn( x )
    %
    %
    %   USAGE 
    %
    %
    %   INPUT
    %x          scalar      A positive number
    %
    %   OUTPUT
    %d_theta    scalar      Solution to the first derivative of the function
    
    if x < 0
        error('Error: x must be positive')
    end
    
    L = 4; %as specified by Dr. Mukherjee
    a = L/2.5;
    
    d_theta = 3/2.5.* x - 2 .* max(x-a,0);
end
