function [C_L] = liftCoef(clpos,C_LxFoil,rR)
% Interpolates C_L from the values extracted from xFiol

C_L = interp1(clpos,C_LxFoil,rR,'linear','extrap');
C_L(1) = 0;
C_L(end) = 0;

end

