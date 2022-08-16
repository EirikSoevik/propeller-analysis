function [Kt_vec, Kq_vec,N_vec] = convergence(J_inp,N_vec)
% This function runs a convergence test for a given J over a set of N,
% defined by the user

% Must run input file again as its easier than passing it all to a
% function!
N = 10;
inp;
[V0,n] = vel(Re07,cD,nu,D,J,N);



%----------------------- Convergence test ---------------------------------
% Loops over the chosen values of N, gets Kt and Kq for each

for i=1:length(N_vec)
    N = N_vec(i);
    inp;
    
    [gamma,Vinf,C_D,Ut,Ua,Betai,~,Uai,Uti] = ...
        accurateInducedCirculation(ksi,r,gamma(:,k),n(k),rR,PD,D,z,C_L,nu,c,J(k),t);
    
    %-------------- Calculating torque and thrust ----------------
    [Kt,Kq,~]...
        = thrutorq(r,Vinf,C_D,c,rho,z,n(k),Ut,...
        Ua,gamma,D,J(k),Betai,Uai,Uti);
    
    %---------------
    Kt_vec(i) = Kt;
    Kq_vec(i) = Kq;
end

tstring = num2str(J_inp);
titlestring = strcat('Convergence test for J= ',tstring);
plot(N_vec,Kt_vec,'--',N_vec,10*Kq_vec,'-');
legend('Kt','10*Kq')
ylabel('Kt, 10*Kq')
xlabel('N')
title(titlestring);
end
