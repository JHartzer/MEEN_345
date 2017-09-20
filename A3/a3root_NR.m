function [x_r, n] = a3root_NR(f, df, x_i, tol)
    %a3root_NR        a root of a supplied function f(x).
    %
    %   USAGE
    %x_r = a3root_NR(f, df, xi, tol)
    %[x_r, n] = a3root_NR(f, df, xi, tol)
    %
    %   INPUT
    %f      pointer     A handle to an external function with interface f(x).
    %df     pointer     A handle to an external function with interface df(x).
    %x_i    scalar      Initial approximation of xr.
    %tol    scalar      Acceptable range of error tolerance for reporting a root, tol > 0. 
    %
    %   OUTPUT
    %x_r    scalar      An approximate root for f(x) in that |f(xr)| < tol.
    %n      scalar      Number of iterations required to get the solution.

    if abs(df(x_i)) == 0
        error('Error: The first derivative cannot be near zero');
    elseif tol <= 0
        error('Error: Tolerance must be positive');
    end

    n = 1;
    
    while true
        x_r = x_i - f(x_i)/df(x_i);
        if abs(f(x_r))<tol
            break
        elseif abs((x_r-x_i)/x_r)<.001
            break
        elseif n > 50
            break
        else
            x_i = x_r;
        end
        
        n = n + 1;
    end 
end

