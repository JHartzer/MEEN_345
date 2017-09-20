% Import data from Mukherjee's paper
data = csvread('Example_data.csv');

% Normalize data
covariance_matrix = cov(data);

% Eigendecomposition
[eig_vecs, eig_vals] = eig(covariance_matrix);
eig_vals = diag(eig_vals);
eig_pairs = cell(length(eig_vals),2);
for i = 1:length(eig_vals)
    eig_pairs(i,:) = {abs(eig_vals(i)), eig_vecs(:,i)};
end
eig_pairs = sortrows(eig_pairs,-1);

% Selecting Principal Componenets
cutoff = 0.95;
tot = sum([eig_pairs{:,1}]);
sum = 0;
for i = 1:length(eig_vals)
    sum = sum + [eig_pairs{i,1}]/tot;
    if sum > cutoff
        break
    end
end
clear sum;


num_eigenvectors = i;
matrix_w = zeros(length(eig_vals),num_eigenvectors);
for i = 1:num_eigenvectors 
    matrix_w(:,i) = [eig_pairs{i,2}];
end

% Projection onto the new feature space
final_data = data * matrix_w;
scatter(final_data(:,1),final_data(:,2))



