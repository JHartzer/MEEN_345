clc; clear; close all;

data = csvread('Honors_data.csv',1,1);
data = data(:,[1,2,3,4,5,6,7]);

Mins = zeros([1,length(data(1,:))]);
Maxes = zeros([1,length(data(1,:))]);
Normalizeddata = zeros(size(data));

for i = 1:length(data(1,:))
    Mins(i) = min(data(:,i));
    Maxes(i) = max(data(:,i));
    Normalizeddata(:,i) = (data(:,i) - Mins(i))/(Maxes(i)-Mins(i));
end

De_H = zeros([length(data(:,1))],1);

for i = 1:length(data(:,1))
    De_H(i,1) = sqrt(sum(Normalizeddata(i,:).^2));
end

sigma = cov(data);

[eig_vect,D] = eig(sigma);
eig_val = diag(D);

disp(sqrt(abs((max(eig_val)./eig_val))));


sigma_inv = 0;
for i = 1:length(eig_val)
    sigma_inv = sigma_inv + 1/eig_val(i)*eig_vect(:,i)*eig_vect(:,i)';
end

means = zeros(1,size(data,2));
for i = 1:size(data,2)
    means(i) = mean(data(:,i));
end

T_squared = zeros(size(data,1),1);
for i = 1:size(data,1)
    T_squared(i) = (data(i,:) - means)*sigma_inv*(data(i,:) - means)';
end

figure
plot(De_H);
xlabel('Time');
ylabel('Euclidean Distance D_e');
title('Euclidean Distance Vs. Time');
ylim([0 inf])

figure
plot(T_squared);
xlabel('Time');
ylabel('Hotelling''s T^2');
title('Hotelling''s T^2 vs. Time without Variables 1, 2, & 3')
ylim([0 inf])
