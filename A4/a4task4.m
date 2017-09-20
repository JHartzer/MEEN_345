clc; clear all; close all; 

A = [   2,  0,  1,  2;...
        1,  1,  0,  2;...
        2, -1,  3,  1;...
        3, -1,  4,  3];
    
[L, U] = crout_LU(A);
n = size(A,1);

I = eye(n);
A_inv = zeros(n);

for i = 1: n
    y = forward_elim(L,I(:,i));
    A_inv(:,i) = backward_elim(U,y);
end

clear('i','n')

fprintf('A_inv * A =\n');
disp(fix(A_inv * A));