function [T, X, V, A] = Beeman(X0, V0, A0, M, C, K, FN, D) 
    %Beeman - Implements Beeman's algorithm for integrating the 
    %   second-order ODE
    %
    %   USAGE 
    %[T, X, V, A] = Beeman(X0, V0, A0, M, C, K, FN, D) 
    %
    %   INPUT
    %X0     col vector  initial condition for displacement, size DOFx1 (ft) 
    %V0     col vector  initial condition for velocity, size DOFx1 (ft/sec) 
    %A0     matrix      initial condition for acceleration, size DOFx3 (ft/sec2) 
    %           A0(i,1)  is the acceleration vector at time 0 
    %           A0(i,2)  is the acceleration vector at time -h 
    %           A0(i,3)  is the acceleration vector at time -2h 
    %M      matrix      mass matrix, size DOFxDOF (lb/(ft/sec2), or ft-lb/(rad/sec2)) 
    %C      matrix      damping matrix, size DOFxDOF (lb/(ft/sec) or ft-lb/(rad/sec)) 
    %K      matrix      stiffness matrix, size DOFxDOF (lb/ft or ft-lb/rad) 
    %FN     handle      FN = @(D) get_forcing_function(D) 
    %D      struct      a data struct that is passed to and from FN
    %
    %   OUTPUT
    %T      vector      times where the solutions got, size (D.N+1)x1 (sec) 
    %X      matrix      displacements, size (D.N+1)xDOF (ft or rad) 
    %V      matrix      velocities, size (D.N+1)xDOF (ft/sec or rad/sec) 
    %A      matrix      accelerations, size (D.N+1)xDOF (ft/sec2 or rad/sec2) 
    
    if ~isstruct(D)
       Error('D, the forcing function data structure, must be a struct.');
    end
    if D.t_out <= D.t_in
       Error('The final time t_out must be greater than the initial time t_in.');
    end
    if D.N < 1
       Error('The number of integration cannot be less than one.');
    end
    dof = size(X0,1);
    if size(V0,1) ~= dof
       Error('The length of vectors X0 and V0 must be the same.');
    end
    if size(A0,1) ~= dof
       Error('The length of vectors X0, V0 and A0 must be the same.');
    end
    [rows, cols] = size(M);
    if (rows ~= dof) || (cols ~= dof)
       Error('The mass matrix must have dimension DOFxDOF.');
    end
    [rows, cols] = size(C);
    if (rows ~= dof) || (cols ~= dof)
       Error('The damping matrix must have dimension DOFxDOF.');
    end
    [rows, cols] = size(K);
    if (rows ~= dof) || (cols ~= dof)
       Error('The stiffness matrix must have dimension DOFxDOF.');
    end

    % Set the step size.
    h = (D.t_out - D.t_in)/D.N; 

    T = zeros(D.N+1,1);
    X = zeros(D.N+1,dof);
    V = zeros(D.N+1,dof);
    A = zeros(D.N+3,dof);

    % Assign initial conditions to the output fields.
    T(1) = D.t_in;
    X(1,:) = X0';
    V(1,:) = V0';
    A(1:3,:) = fliplr(A0(:,1:3)');
    
    % Integrate over the interval [T0,TN].
    for nn=1:D.N
        T(nn+1) = T(nn) + h;

        % Predict (P) using explicit integrators to estimate the displacement and velocity vectors.
        X(nn+1) = X(nn) + h * V(nn) + h^2/6*(4*A(nn+2)-A(nn+1));
        V(nn+1) = V(nn) + h/12 * (23*A(nn+2) - 16*A(nn+1) + 5*A(nn));
        
        % Evaluate (E) the acceleration vector using these predicted values for displacement and velocity
        A(nn+3) = M\(FN(T(nn+1) - C*V(nn+1) - K*X(nn+1)));
        
        % Correct (C) the predicted estimates using implicit Adams-Moulton methods to get improved solutions for the displacement and velocity vectors, thereby enhancing algorithmic stability.
        X(nn+1) = X(nn) + h * V(nn) + h^2/6 * (A(nn+3) + 2*A(nn+2));
        V(nn+1) = V(nn) + h/2 * (A(nn+3) + A(nn+2));
        
        % Re-Evaluate (E) the acceleration vector using corrected values for displacement and velocity. 
        A(nn+3) = M\(FN(T(nn+1) - C*V(nn+1) - K*X(nn+1)));
        
    end
end