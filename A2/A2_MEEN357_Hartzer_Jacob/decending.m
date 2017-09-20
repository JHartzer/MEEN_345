function sorted_list = decending(unsorted_list)
    for i = 2:length(unsorted_list)
        k = i;
        while k ~= 1 && unsorted_list(k) > unsorted_list(k-1)
            hold = unsorted_list(k-1);
            unsorted_list(k-1) = unsorted_list(k);
            unsorted_list(k) = hold;
            k = k - 1;
        end
    end
    sorted_list = unsorted_list;