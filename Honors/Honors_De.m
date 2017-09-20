function [De_H] = Honors_De(filename)
    
    data = csvread(filename);
    Mins = zeros([1,length(data(1,:))]);
    Maxes = zeros([1,length(data(1,:))]);

    for i = 1:length(data(1,:))
        Mins(i) = min(data(:,i));
        Maxes(i) = max(data(:,i));
    end

    NormalizedData = zeros(size(data));

    for i = 1:length(data(1,:))
        NormalizedData(:,i) = (data(:,i) - Mins(i))/(Maxes(i)-Mins(i));
    end

    De_H = zeros([length(data(:,1))],1);

    for i = 1:length(data(:,1))
        De_H(i,1) = sqrt(sum(NormalizedData(i,:).^2));
    end