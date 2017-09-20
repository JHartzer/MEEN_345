function I = trapint(x, fx) 
    %trapint - A function that takes data sample locations and 
    %   function samplings at those locations as inputs and returns an 
    %   approximation of the integral over the sample range based on 
    %   the trapezoidal rule
    %   
    %   USAGE
    %I = trapint(x, fx) 
    %
    %   INPUT
    %x      Numerical data for sample locations. (N-element vector) 
    %fx     Function data taken at locations defined in input x. (N-element vector) 
    %
    %   OUTPUT
    %I      Approximation for the integral of fx over its sampled range.
    
    if ~isvector(x) || ~isnumeric(x)
        error('Error: x must be a numeric vector')
    elseif ~isvector(fx) || ~isnumeric(fx)
        error('Error: fx must be a numeric vector')
    elseif length(x) ~= length(fx)
        error('Error: x and fx must be equal in length')
    end
    
    I = 0;
    for i = 1:length(x)-1
        I = I + (fx(i) + fx(i+1)) * (x(i+1) - x(i))/2;
    end
end

