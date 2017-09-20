function [ y ] = linearspline( XDATA, YDATA, x )
    %A function for linear interpolation via spline.
    %
    %   USAGE
    %[ y ] = linearspline( XDATA, YDATA, x )
    %
    %   INPUT
    %XDATA  -   The vector of X data points
    %YDATA  -   The associated vector of Y data points
    %x      -   The vector of wanted interpolated values
    %
    %   OUTPUT
    %y      -   The vector of interpolated values

    if ~ismatrix(XDATA) || ischar(XDATA)
        error('Error: XDATA must be a matrix of numeric values')
    elseif ~ismatrix(YDATA) || ischar(YDATA)
        error('Error: YDATA must be a matrix of numeric values')
    elseif ~ismatrix(x) || ischar(x)
        error('Error: x must be a matrix of numeric values')
    elseif length(XDATA) ~= length(YDATA)
        error('Error: XDATA and YDATA must be of same length')
    end
    
    %sort function
    for i = 2:length(XDATA)
        k = i;
        while k ~= 1 && XDATA(k) < XDATA(k-1)
            hold_x = XDATA(k-1);
            hold_y = YDATA(k-1);
            
            XDATA(k-1) = XDATA(k);
            YDATA(k-1) = YDATA(k);
                        
            XDATA(k) = hold_x;
            YDATA(k) = hold_y;
                        
            k = k - 1;
        end
    end
        
    if any(x < XDATA(1)) || any(x > XDATA(end))
        error('Error: requested x value beyond range of interpolation')
    end
    
    y = zeros(1,length(x));
    
    for j = 1:length(x)
        i = 2;
        while x(j) > XDATA(i)
            i = i + 1;
        end

        y(j) = YDATA(i-1)*(x(j) - XDATA(i))/(XDATA(i-1) - XDATA(i))+...
            YDATA(i)*(x(j) - XDATA(i-1))/(XDATA(i) - XDATA(i-1));
    end
end

