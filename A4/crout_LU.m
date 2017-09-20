function [ L, U ] = crout_LU( A )
    %A function that performs Crout reduction to produce an upper and
    % lower triangular matrix from a square matrix.
    %
    %   USAGE
    %[ L, U ] = crout_LU( A )
    %
    %   INPUT
    %A  -   Square matrix A
    %
    %   OUTPUT
    %L  -   Lower triangular matrix from A
    %U  -   Upper triangular matrix from A
    
    if ~ismatrix(A) || ischar(A)
        error('Error: A must be a matrix of numeric values')
    elseif size(A,1) ~= size(A,2)
        error('Error: A must be a square matrix');
    end
    
    n = size(A,1);
    L = zeros(n);
    U = eye(n);
    
    for k = 1 : n
        for i = k : n
            summation = 0;
            for m = 1:k-1
                summation = summation + L(i,m)*U(m,k);
            end
            L(i,k) = A(i,k) - summation;
        end
        for j = k + 1 : n
            summation = 0;
            for m = 1:k-1
                summation = summation + L(k,m)*U(m,j);
            end
            U(k,j) = (A(k,j) - summation) / L(k,k);
        end
    end
    
    if any(diag(L) == 0)
        warning('Warning: diagonal element of the reduced matrix L is zero valued');
    end
end

