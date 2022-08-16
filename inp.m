%----------------------- Input script ------------------------------
%
% Matlab reads this whole script as if it was printed into wherever it is
% read from. It is a good way to establish such an amount of data without
% having to pass it as variables, declare global variables, or create
% structs.


%--------------------------- Given data ----------------------------------

D    = 1;        % Diameter [m]
R    = D/2;      % Radius [m]
PD   = 1.0;      % Pitch/diameter [-]
AEA0 = 0.4;      % Expanded bladre area ratio
z    = 4;        % Number of blades
Re07 = 2.4e6;    % Reynolds nr. at 70% of R
rho  = 1025;     % Water density [kg/m^3]
nu   = 1.05e-6;  % Kinematic viscosity [m^2/s]
pv   = 2150;     % Vapour pressure [Pa]
patm = 101325 ;  % Atmospheric pressure [Pa]
g    = 9.81;     % Acceleration of gravity [m/s]
h    = 1;        % Sumbersion level of the blade tips
ksi  = 0.1;      % Relaxation factor for updating gamma from gamma1

% Advance numbers to test for
J    = [0.5 0.6 0.7 0.8 0.9 1.0 1.1]; 

%------------------ Advance number and chosen J_inp ----------------------
% Checking 
k=-1;
for n1=1:length(J)
    if J_inp == J(n1)
        k = n1;
        break;
    end
end
if k == -1
    msg = 'could not find matching J';
    error(msg);
end


%---------------------- Geometry data for the foil ------------------------
geom_dat;
rR = geom(:,1);
cD = geom(:,2);
tD = geom(:,3);
PD = geom(:,4);
rRold = rR;

%-------------------- Interpolating foil geometry over N ------------------
% We are here assuming rR is linearly distributed, which it very nearly is
rR = linspace(rR(1), rR(end), N)';
%rR = [0.167,0.2:0.1:1]'; % If you want crisp integers
cD = interp1(rRold,cD,rR,'pchip');
tD = interp1(rRold,tD,rR,'pchip');
PD = interp1(rRold,PD,rR,'pchip');
r = rR.*R;
c = cD*D; 
t = tD*D;
dr = gradient(r); 

%---------------- Initial circulation (first iteration) -------------------
gamma=ones(N,length(J))*0.2;
gamma(1,:)=0;
gamma(N,:)=0;

%---------------------- Lift coefficient distribution from xFoil ----------

% Interpolates 
% First from xFoil with alpha=0
% Second version is based on printalpha.m, using our iterated values
C_LxFoil = [0.5523 0.5106 0.5558 0.5751 0.5098 0.4105 0.2987 0.2123]; 
clpos = [0.2:0.1:0.9];
C_L = interp1(clpos,C_LxFoil,rR,'linear','extrap');
C_L(1) = 0;
C_L(end) = 0;

%------------------- Experimental data -------------------
exp_dat;
J_exp = exp_mat(:,1);
Kt_exp = exp_mat(:,2);
Kq_exp = exp_mat(:,3);
eta0_exp = exp_mat(:,4);

%-------------- Advance velocity and rotational frequency -----------------
% V0 is the advance velocity without regard for the wake, as we have no
% data for w
% n is given as rotations per second
[V0,n] = vel(Re07,cD,nu,D,J,N);
