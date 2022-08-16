function [alpha, Vinf, Beta, phi] = velangle(Ua, Ut,r,PD,D,Uai,Uti)
% Calculates the angle of attack, alpha, and the inflow velocity, Vinf

Vinf = sqrt( (Uai./2+Ua).^2+(Ut-0.5.*Uti).^2);
Beta = atan((Ua+0.5.*Uai)./(Ut-0.5.*Uti) );
phi = atan((PD.*D)./ (2.*pi.*r));
alpha = phi - Beta;
end
