function I = forwarddiff(x, fx)
    %forwarddiff - a function that takes data sample locations and 
    %   function samplings at those locations as inputs and returns an 
    %   approximation of the derivative at the sample points based on 
    %   forward  finite difference method with order of accuracy O(h3)
    %   
    %   USAGE
    %I = forwarddiff(x, fx)
    %
    %   INPUT
    %x      Numerical data for sample locations. (N-element vector) 
    %fx     Function data taken at locations defined in input x. (N-element vector) 
    %
    %   OUTPUT
    %I      Approximation for the first derivative of fx at data points 2 to N-2
    
    if ~isvector(x) || ~isnumeric(x)
        error('Error: x must be a numeric vector')
    elseif ~isvector(fx) || ~isnumeric(fx)
        error('Error: fx must be a numeric vector')
    elseif length(x) ~= length(fx)
        error('Error: x and fx must be equal in length')
    elseif length(x) < 4 || length(fx) < 4
        error('Error: this method requires at least four data points');
    end
    
    I = zeros(1,length(2:length(x)-2));
    
    for i = 2:length(x)-2
        I(i-1) = (-fx(i+2) + 6*fx(i+1) - 3*fx(i) - 2*fx(i-1))/6/(x(i)-x(i-1));
    end
    
end

