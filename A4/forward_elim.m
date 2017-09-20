function [ y ] =  forward_elim(L, b)
    % A function implementing forward elimination given a solution
    % vector and a lower triangular matrix.
    %
    %   USAGE
    %[ y ] =  forward_elim(L, b)
    %
    %   INPUT
    %L  -   A lower triangular matrix
    %b  -   The solution vector
    %
    %   OUTPUT
    %y  -   vector y for Ly = b.
    
    if ~ismatrix(L) || ischar(L)
        error('Error: L must be a matrix of numeric values')
    elseif size(L,1) ~= size(L,2)
        error('Error: L must be a square matrix')
    elseif all(size(b) ~= 1 ) || ischar(b)
        error('Error: b must be a vector of numeric values')
    elseif size(L,1) ~= size(b,1)
        error('Error: L and y must be of like dimension')
    elseif any(diag(L) == 0)
        error('Error: Diagonal elements of L must be nonzero')
    end
    
    n = size(L,1);
    
    y = zeros(n,1);
    
    for i = 1 : n
        summation = 0; 
        for j = 1:i-1   
            summation = summation + L(i,j) * y(j); 
        end
        y(i) = (b(i) -  summation)/L(i,i); 
        
    end
end

