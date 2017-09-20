clc; clear all; close all;

sum = 0;
n = 1;
while true
   
    if sum == sum + power(2,-(n-1))
        break
    end
    sum = sum + power(2,-(n-1));
    n = n + 1;
end
disp(n);