function [Kt,Kq,eta0] = thrutorq(r,Vinf,C_D,c,rho,z,n,Ut,Ua,gamma,D,J,Beta,Uai,Uti)
% Thrust and torque are calculated first as the derivative
% values, and then integrated using a trapezoidal function, then the
% unitless values, and the efficiency are found and returned to be plotted

dD = 0.5*rho*(Vinf.^2).*C_D.*c;
dT =(rho.*gamma).*(Ut-0.5.*Uti) - dD.*sin(Beta);
dQ =(rho.*gamma).*(Ua+0.5.*Uai).*r + dD.*r.*cos(Beta);

T = trapz(r,dT)*z;
Q = trapz(r,dQ)*z;

Kt=T./(rho.*n.^2*D^4);
Kq=Q./(rho.*n.^2*D^5);
eta0 = (J.*Kt)./(2.*pi.*Kq);
end