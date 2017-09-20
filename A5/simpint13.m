function I = simpint13(h, fx) 
    %simpint13 - A function that takes data sampled at evenly spaced 
    %   locations as inputs and returns an approximation of the 
    %   integral over the sample range based on Simpson’s multiple-
    %   application 1/3 rule
    %   
    %   USAGE
    %I = simpint13(h, fx) 
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
    elseif length(fx) <= 1
        error('Error: fx must contain at least three elements for this method');
    end
    
    I = 0;
    for i = 1:2:length(fx) - 2
        I = I + (fx(i) + 4*fx(i+1) + fx(i+2))*h/3;
    end
    
end

