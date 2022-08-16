function [gamma,Vinf,C_D,Ut,Ua,Beta,alpha,Uai,Uti] = simpleCirculation(r,n,rR,PD,D,C_L,t,nu,c,J)
% Calculates circulation distribution without regard for induced velocities
% This is a very fast method but is also very inaccurate

% Induced velocities are initialized to zero to match so we can use the
% same functions as the rest of the program
Uai = zeros(length(rR),1);
Uti = zeros(length(rR),1);
Ua  = J*n*D*ones(length(rR),1);
Ut  = 2*pi*n*r;

[alpha, Vinf, Beta, ~] = velangle (Ua, Ut,r,PD,D,Uai,Uti);
C_D                    = drag (t,c,nu,Vinf,C_L);
[gamma, ~]             = circulation (Vinf,c, C_L,alpha);
end