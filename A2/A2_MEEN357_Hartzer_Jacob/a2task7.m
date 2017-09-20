clc; clear all; close all;

syms x;
fun(x) = atan(x);

n = 1;
while true
    fun_diff = diff(fun,n+1);
    
    remainder = max(abs(double(fun_diff(linspace(0,pi/4,500)))))/...
        factorial(n+1)*power((pi/6),n-1);
    
    if remainder < power(10,-5) || n >= 50
        break
    end
    
    n = n + 1 ;
end   
disp(n); disp(remainder);
