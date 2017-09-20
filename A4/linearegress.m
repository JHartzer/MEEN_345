function [ y ] = linearegress( XDATA, YDATA, x )
    %A function for producing predicted values from a linear least
    % squares regresion of the given data.
    %
    %   USAGE
    %[ y ] = linearegress( XDATA, YDATA, x )
    %
    %   INPUT
    %XDATA  -   The vector of X data points
    %YDATA  -   The associated vector of Y data points
    %x      -   The vector of wanted interpolated values
    %
    %   OUTPUT
    %y      -   The vector of predicted values
    
    
    if ~ismatrix(XDATA) || ischar(XDATA)
        error('Error: XDATA must be a matrix of numeric values')
    elseif ~ismatrix(YDATA) || ischar(YDATA)
        error('Error: YDATA must be a matrix of numeric values')
    elseif ~ismatrix(x) || ischar(x)
        error('Error: x must be a matrix of numeric values')
    elseif all(size(XDATA) ~= 1 ) || all(size(YDATA) ~= 1 ) || all(size(XDATA) ~= 1 )
        error('Error: XDATA, YDATA, and x must be vectors')
    elseif length(XDATA) ~= length(YDATA)
        error('Error: XDATA and YDATA must be of same length')
    end
    
    xy_sum = 0;
    x_sum = 0;
    y_sum = 0;
    x2_sum = 0;
    
    n = length(XDATA);
    
    for i = 1 : n
        xy_sum = xy_sum + XDATA(i)*YDATA(i);
        x_sum = x_sum + XDATA(i);
        y_sum = y_sum + YDATA(i);
        x2_sum = x2_sum + XDATA(i)^2;
    end
    
    a_1 = (n * xy_sum - x_sum * y_sum)/(n * x2_sum - x_sum^2);
    a_0 = (y_sum - a_1 * x_sum)/n;
    
    y = a_0 + a_1*x;
end

