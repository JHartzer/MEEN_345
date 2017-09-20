function [ x ] = backward_elim(U, y)
    % A function implementing backward elimination given a solution
    % vector and an upper triangular matrix.
    %
    %   USAGE
    %[ x ] = backward_elim(U, y)
    %
    %   INPUT
    %U  -   An upper triangular matrix
    %y  -   The solution vector
    %
    %   OUTPUT
    %x  -   vector x for Ux = y.
    if ~ismatrix(U) || ischar(U)
        error('Error: U must be a matrix of numeric values')
    elseif size(U,1) ~= size(U,2)
        error('Error: U must be a square matrix')
    elseif all(size(y) ~= 1 ) || ischar(y)
        error('Error: y must be a vector')
    elseif size(U,1) ~= size(y,1)
        error('Error: U and y must be of like dimension')
    elseif any(diag(U) == 0)
        error('Error: Diagonal elements of U must be nonzero')
    end
    
    n = size(U,1);
    
    x = zeros(n,1);
    
    
    for i = n : -1 : 1
        summation = 0;
        for j = 1+1 : n
            summation = summation + U(i,j) * x(j);
        end
        
        x(i) = (y(i) - summation)/U(i,i);
    end
end

