% Creates 4 subplots in one plot:
% 
% |------------------------------------|
% | Circulation     |   Kt,10Kq,eta0   |
% |-----------------|------------------|
% | alpha and beta  |     alpha        |
% |------------------------------------|

% Option to plot only Kt,10Kq,eta0 at the bottom!

figure
set(gcf,'Position',[300 300 700 700])
subplot(2,2,1)
plot(r,gamma);
title('Circulation');
legend('gamma');
xlabel('r')
ylabel('gamma');

subplot(2,2,2)
plot(J, Kt,'kv--', J, 10*Kq, 'k*--', J, eta0, 'ks--', J_exp, Kt_exp,...
    'r-', J_exp, 10*Kq_exp, 'b-', J_exp, eta0_exp, 'g-')
legend('Kt','10*Kq','eta0', 'Kt_{exp}', '10*Kq_{exp}', 'eta0_{exp}','Location','East')
xlabel('J')
ylabel('-')
title('Propeller characteristics');

subplot(2,2,3)
hold on
for nn=1:7
    
    plot(rR,Betai(:,nn),rR,alpha(:,nn));%,rR,phi);
    title('angles of attack')
    legend('beta','alpha')
end

subplot(2,2,4)
plot(rR,alpha);
title('alpha')


if task == 1
    tstring = ' without induced velocities';
elseif task == 2
    tstring = ' using simple induced velocities';
elseif task == 3
    tstring = ' using more accurate induced velocities';
else
    return;
end

titlestring = strcat('Propeller characteristics calculated ',tstring);

figure
plot(J, Kt,'kv--', J, 10*Kq, 'k*--', J, eta0, 'ks--', J_exp, Kt_exp,...
    'r-', J_exp, 10*Kq_exp, 'b-', J_exp, eta0_exp, 'g-')
legend('Kt','10*Kq','eta0', 'Kt_{exp}', '10*Kq_{exp}', 'eta0_{exp}')
xlabel('J')
ylabel('Kt, 10*Kq, eta0')

title(titlestring);





