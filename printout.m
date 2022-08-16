switch task
    case 1
        fprintf('Propeller characteristics with no induced velocities\n')
    case 2
        fprintf('Propeller characteristics with simple induced\n');
        fprintf('velocities, using complete momentum theory\n')
    case 3
        fprintf('Propeller characteristics using lifting line theory\n');
        
    case 4
        fprintf('Convergence testing\n');
        fprintf('J = %.1f\n',J_inp);
        fprintf('N = %d:%d:%d\n',N_start,N_step,N_end);
    case 5
        fprintf('Cavitation test\n');
end
fprintf('---------------\n');
fprintf('Solving task: %d\n', task);
fprintf('N = %d\n',N);


        
       
%               4. Propeller characteristics using lifting line theory
%               4.2 Convergence test for J=0.5 for different sections N
%               5. Cavitation test
