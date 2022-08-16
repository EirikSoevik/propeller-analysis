function [gamma,Vinf,C_D,Ut,Ua,Betai, alpha,Uai,Uti] = accurateInducedCirculation(ksi,r,gamma,n,rR,PD,D,z,C_L,nu,c,J,t)
% Calculates circulation with induced velocities found using induction
% factors, this is the most accurate way to calculate the induced
% velocities.

it        = 0;
tol       = 1e-5;
maxIt     = 10000;
Uai       = zeros(length(rR),1);
Uti       = zeros(length(rR),1);
Ua        = J*n*D.*ones(length(rR),1);
Ut        = 2*pi*n*r;
gammadiff = 1;

% Finding beta without induced velocities
[~,~,Beta,~] = velangle(Ua,Ut,r,PD,D,Uai,Uti);
Betai = Beta;

while gammadiff>tol && maxIt>it
    [Uti, Uai]              = accurateInducedVel (r,gamma,z,Betai);
    [alpha, Vinf, Betai, ~] = velangle (Ua,Ut,r,PD,D,Uai,Uti);
    [gamma1, C_L2]          = circulation (Vinf,c, C_L,alpha);
    
    gamma                   = gamma+ksi*(gamma1-gamma);
    gammadiff               = max(abs(gamma1-gamma));
    it                      = it+1;
end
C_D                         = drag(t,c,nu,Vinf,C_L2);
end