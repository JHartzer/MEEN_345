function x = a3task_GE(A,B)
    if size(A) ~= size(A')
        error('Error: Input must be a square matrix')
    end
    
    C = [A, B];
    

    % Forward Elimination
    for i = 1:length(C(:,1))-1
        for j = 1 : length(C(:,1)) - i
            C(i+j,:) = C(i+j,:) - C(i+j,i)/C(i,i) * C(i,:);
        end
    end

    % BaCkward Elimination
    for i = length(C(:,1)):-1:2
        for j = 1 : i-1
            C(i - j,:) = C(i - j,:) - C(i - j,i) / C(i,i) * C(i,:);      
        end
    end

    %solving
    for i = 1 : length(C(:,1))
        C(i,:) =  C(i,:)/C(i,i);
    end

    x = C(:,end);
end
