function [Ut, Ua] = simpleInducedVel(Ua,r,n,gamma0,z)
% Computes simple induced velocities

Ut = (gamma0*z)./(2*pi.*r);
Ua = -Ua+sqrt(Ua.^2+2*Ut.*(2*pi*n.*r-0.5.*Ut));
end