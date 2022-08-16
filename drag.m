function C_D = drag(t,c,nu,Vinf,C_L2)
% This function calculates drag 
RN = Vinf.*c./nu;

C_F = 0.075./((log10(RN)-2).^2);
C_D = 2.*C_F.*(1+2.*(t./c)+60.*((t./c).^4)).*(1+(C_L2.^2)./8);
C_D(end)=0;

end