clc; clear all; close all;

for tol = [0.1, 0.001, 0.00001]
    [xr, n] = a3root_bisection(@a3fn, 0,4, tol);
    fprintf('The root obtained at a tolerance of %f was %0.4f with L = 4 and %d iterations.\n',tol,xr,n)
end


