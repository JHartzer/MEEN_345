clc; clear all; close all;

%% 1.)
A=gallery('gcdmat',7);

%% 2.)
vec = A(:,6);

%% 3.)
v_max = vec(1);
v_min = vec(1);
for i = 2:length(vec)
    if vec(i) < v_min
        v_min = vec(i);
    elseif vec(i) > v_max
        v_max = vec(i);
    end
end

%% 4.)
M = repmat(vec', [2 1]);

%% 5.)
diagM = diag(A);

%% 6.)
samples1 = linspace(1,10,9);

%% 7.)
samples2 = [0:0.2:1.95];