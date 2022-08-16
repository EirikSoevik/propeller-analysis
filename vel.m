function [V0,n] = vel(Re07,cD,nu,D,J, N)
%Calculates inital velocity V0, and rps, n
c07 = cD(ceil(0.7*N),1);
Vinf07 = Re07*nu/c07;
n=(Vinf07./D).*1./(sqrt((0.7*pi).^2+J.^2)); %rps
V0 = J.*n.*D;


end