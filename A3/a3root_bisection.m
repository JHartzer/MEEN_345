function [x_r, n] = a3root_bisection(f, x_l, x_u, tol)
    %a3root_bisection       Returns an estimate for a root of a supplied function f(x).
    %
    %   USAGE
    %[x_r, n] = a3root_bisection(f, x_l, x_u, tol)
    %
    %   INPUTS
    %f      pointer     A handle to an external function with interface f(x)
    %x_l    scalar      Lower limit of search region
    %x_u    scalar      Upper limit of search region, x_l < x_u
    %tol    scalar      Acceptable range of error tolerance for reporting a root, tol > 0
    %
    %   OUTPUTS
    %x_r    scalar      An approximate root for f(x) in that |f(x_r)| < tol
    %n      scalar      Number of iterations required to get the solution
    
    if x_l >= x_u
        error('Error: Lower bound greater than upper bound.');
    elseif f(x_l)*f(x_u) > 0
        error('Error: No root in specified interval.');
    elseif tol <= 0
        error('Error: Tolerance must be positive');
    end

    n = 1;
    while true
        x_r = (x_u+x_l)/2;
        
        if abs(f(x_r)) < tol
            break
        elseif abs((x_u-x_l)/(x_u+x_l)) <.001
            break
        elseif n > 50
            break
        elseif f(x_r)*f(x_u) < 0
            x_l = x_r;            
        else
            x_u = x_r;
        end
        n = n+1;
    end
end