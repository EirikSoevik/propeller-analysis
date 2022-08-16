clear; close all; clc;

N    = 10;  task = 5;  J_inp = 0.5;  N_start = 6;  N_step = 6;  N_end = 36;
show_plots = true;
% This program does 5 different tasks, please input which task you would
% like to perform below.
%   Tasks:
%               1. Propeller characteristics with no induced velocities
%               2. Propeller characteristics with simple induced
%                  velocities, using complete momentum theory
%               3. Propeller characteristics using lifting line theory
%               4. Convergence test for J=0.5 for different sections N
%               5. NB! Missing datafile "cpny/cp2.txt". Supposed to do 
%                  a cavitation test
%
%   Variables you can change:
%           N          - number of sections
%           task       - which task to solve
%           N_vec      - Number of sections you want to run the convergence
%                        test for, reccomended values are N_vec = [6:6:36]
%           J_inp      - Which J to run convergence or cavitation test for
%                        must be one of these values:
%                            0.5 0.6 0.7 0.8 0.9 1.0 1.1
%                        However, J=0.5 is recommended
%           show_plots - set to true to show plots, and false to hide them


% Runs input script
inp;
printout; % to command line

for i=1:length(J)
    switch task
        case 1
            %------------- No induced velocities --------------------
            
            [gamma(:,i),Vinf(:,i),C_D(:,i),Ut(:,i),Ua(:,i),Betai(:,i),...
                alpha(:,i),Uai(:,i),Uti(:,i)]...
                =simpleCirculation(r,n(i),rR,PD,D,C_L,t,nu,c,J(i));
            
            %------------------ Torque, thrust and eta --------------------
            [Kt(i),Kq(i),eta0(i)]...
                = thrutorq(r,Vinf(:,i),C_D(:,i),c,rho,z,n(i),Ut(:,i),...
                Ua(:,i),gamma(:,i),D,J(i),Betai(:,i),Uai(:,i),Uti(:,i));
            
            
        case 2
            %-------- Circulation with simple induced velocities ----------
            
            [gamma(:,i),Vinf(:,i),C_D(:,i),Uti(:,i),Uai(:,i),...
                Ut(:,i),Ua(:,i),Betai(:,i),alpha(:,i)]...
                = inducedCirculation(ksi,r,gamma(:,i),n(i),rR,PD,D,...
                z,C_L,t,nu,c,J(i));
            
            %------------------ Torque, thrust and eta --------------------

            [Kt(i),Kq(i),eta0(i)]...
                = thrutorq(r,Vinf(:,i),C_D(:,i),c,rho,z,n(i),Ut(:,i),...
                Ua(:,i),gamma(:,i),D,J(i),Betai(:,i),Uai(:,i),Uti(:,i));
            
        case 3
            
            [gamma(:,i),Vinf(:,i),C_D(:,i),Ut(:,i),Ua(:,i),Betai(:,i),...
                alpha(:,i),Uai(:,i),Uti(:,i)] = ...
                accurateInducedCirculation(ksi,r,gamma(:,i),n(i),rR,PD...
                ,D,z,C_L,nu,c,J(i),t);
            
            %-------------- Calculating torque and thrust -----------------

            [Kt(i),Kq(i),eta0(i)]...
                = thrutorq(r,Vinf(:,i),C_D(:,i),c,rho,z,n(i),Ut(:,i),...
                Ua(:,i),gamma(:,i),D,J(i),Betai(:,i),Uai(:,i),Uti(:,i));
            
        case 4
            %----------------------- Convergence --------------------------
            %------------- J=J_inp  N=[N_start:N_step:N_end] --------------

            if J(i) == J_inp
                % Convergence test over values chosen in main
                N_vec   = N_start:N_step:N_end;
                [Kt_vec, Kq_vec,N_vec] = convergence(J_inp,N_vec);
                
                return  %Code finishes
            end
            
        case 5
            %----------------- Cavitation check ---------------------------

            if J(i) == J_inp
                if N ~= 10
                    fprintf('Beware that changing N to anything other ');
                    fprintf('than 10 might result in inaccurate results\n');
                    fprintf('as 10 is the number used when finding Cp in');
                    fprintf('xFoil. That said, try and see if the');
                    fprintf('results vary!\n\n');
                end
                %----------- Using accurate induced velocities ------------

                [gamma(:,i),Vinf(:,i),C_D(:,i),Ut(:,i),Ua(:,i),...
                    Betai(:,i),alpha(:,i),Uai(:,i),Uti(:,i)] = ...
                    accurateInducedCirculation(ksi,r,gamma(:,i),n(i),...
                    rR,PD,D,z,C_L,nu,c,J_inp,t);
                
                %-------------- Cavitation check --------------------------

                [cavcheck,sigma,cp_ext] = cavitation(patm,pv,rho,g,h,r,...
                    R,Vinf(:,i),rR,clpos,N,J_inp);
                
                
                return % Code finishes
            end
    end
end

if show_plots == true
    plotting
end