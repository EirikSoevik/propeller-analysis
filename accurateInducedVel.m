function [Uti, Uai] = accurateInducedVel(r,gamma0,z,Beta)
% Calculates induced velocities based on the functions InductionFactors and
% SingularIntegration. This method takes into account that there are only 
% a finite amount of blades, and utilises Biot Savarts' law with induction 
% factors i_A and i_T

Uti=zeros(length(r),1);
Uai=zeros(length(r),1);

gammaspline = csapi(r,gamma0);
gammaderivative = fnval(r,fnder(gammaspline,1));
p = gammaderivative;

for k=2:length(r)-1
    
    i_A = zeros(length(r),1);
    i_T = zeros(length(r),1);
    r0_r = r(k);
    for j=1:length(r)
        [i_A(j), i_T(j)] = InductionFactors(r(j), r0_r, Beta(j), z);
    end
    f_a = i_A.*p./(2*pi);
    f_t = i_T.*p./(2*pi);
    J_a = SingularIntegration(r,f_a,r0_r);
    J_t = SingularIntegration(r,f_t,r0_r);
    
    Uai(k) = J_a;
    Uti(k) = J_t;
end

% Interpolate the first values of Ut and Ua
Uashort = Uai(2:end);
Utshort = Uti(2:end);
r_short = r(2:end);
Uti = interp1(r_short,Utshort,r,'pchip','extrap');
Uai = interp1(r_short,Uashort,r,'pchip','extrap');

end