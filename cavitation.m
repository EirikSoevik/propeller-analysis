function [cavcheck, sigma, cp_ext] = cavitation(patm, pv, rho, g, h, r,R, Vinf,rR,clpos,N,J_inp)
% Cavitation check for a given J and N, checks for the cavitation criterion
% based on internal values up against values for Cp computed in xFoil


cavcheck = false(length(r),1);

% Create sigma for all r
sigma = (patm - pv + rho*g.*(h+R-r) ) ./ (0.5*rho.*Vinf.^2);

% Create Cp for a set of sections
% Cpmin is found as -max because it is given by 
% xFoil with the opposite sign
for i=1:8
    [~, ~, ~, cp] = readCp(i+1);
    cpmin(i) = -max(cp);
end

% Extrapolate Cp over all of r
cp_ext = interp1(clpos,cpmin,r,'linear','extrap');

% Cavitation check for each section of r
for i=1:length(r)
    if -cp_ext(i) >= sigma(i)
        cavcheck(i) = true;
    end
end

figure
plot(rR,sigma,rR,-cp_ext);
legend('sigma','-Cp');
ylabel('sigma, -Cp')
xlabel('rR');
jstring = num2str(J_inp);
titlestring = strcat('Cavitation check for J=', jstring, ' over the radius of the foil');
title(titlestring);

%------------- Cavitation status at % of R ----------------
fprintf('Cavitation check at %% of R:\n');
for i2=1:N
    fprintf('%.2fR: %s\n',rR(i2),string(cavcheck(i2)));
end

end
