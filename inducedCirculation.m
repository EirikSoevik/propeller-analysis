function [gamma,Vinf,C_D,Uti,Uai,Ut,Ua,Betai,alphai] = inducedCirculation(ksi,r,gamma,n,rR,PD,D,z,C_L,t,nu,c,J)
% Calculates circulation with simple induced velocities based on iteration

it        = 0;
tol       = 1e-5;
maxIt     = 10000;
Uai       = zeros(length(rR),1);
Uti       = zeros(length(rR),1);
Ua        = J*n*D*ones(length(rR),1);
Ut        = 2*pi*n*r;
gammadiff = 1;

while gammadiff>tol && maxIt>it
    [Uti, Uai]               = simpleInducedVel (Ua,r,n,gamma,z);
    [alphai, Vinf, Betai, ~] = velangle (Ua,Ut,r,PD,D,Uai,Uti);   
    [gamma1, C_L2]           = circulation (Vinf,c, C_L,alphai);
    
    gamma                    = gamma+ksi* (gamma1-gamma);
    gammadiff                = max (abs(gamma1-gamma));
    it                       = it+1;
end
C_D                          = drag(t,c,nu,Vinf,C_L2);
end
