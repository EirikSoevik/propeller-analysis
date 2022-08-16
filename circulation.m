function [gamma1, C_L2] = circulation(Vinf,c, C_L,alpha)
% Calculates a new circulation, based on the angle of attack alpha, and
% using the values we got from xFoil

C_L2 = 2.*pi.*alpha+C_L;

gamma1 = 1/2*Vinf.*C_L2.*c;
gamma1(1)=0;
gamma1(end)=0;
end