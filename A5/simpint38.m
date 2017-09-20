function  I = simpint38(h, fx) 
    %simpint38 - A function that takes data sampled at evenly spaced 
    %   locations as inputs and returns an approximation of the 
    %   integral over the sample range based on Simpson’s multiple-
    %   application 3/8 rule
    %   
    %   USAGE
    %I = simpint38(h, fx) 
    %
    %   INPUT
    %h      Step size separating adjacent sampling locations (scalar) 
    %fx     Function data taken at uniform locations separated by a 
    %       distance of h, i.e., h = x2 – x1 = x3 - x2 = … 
    %       (N-element vector) 
    %
    %   OUTPUT
    %I      Approximation for the integral of fx over its sampled range.
    
    if ~isscalar(h) || ischar(h)
        error(['Error: Input type.\n\t',...
            'h must be a scalar, not a %s'],class(h));   
    elseif ~isvector(fx) || ~isnumeric(fx)
        error('Error: fx must be a numeric vector');
    elseif mod(length(fx),2) == 0
        error('Error: fx must be an odd length vector');
    elseif length(fx) <= 3
        error('Error: fx must contain at least five elements for this method');
    end
    
    I = 0;
    for i = 1:3:length(fx) - 3
        I = I + (fx(i) + 3*fx(i+1) + 3*fx(i+2) + fx(i+3))*3*h/8;
    end
    
end