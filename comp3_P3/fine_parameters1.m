%% Post _2 for fine data for simulation
close all

P_b = 6:6:30;
P_r = 0:15:60;
[P_B,P_R] = meshgrid(P_b,P_r);



% % Plots with first obj function and constraints on last 5 points and
% orientation

% EI
load('Control valves\EI_P3.mat')
EI = EI_P3';


P_b_q = 6:1:30;
P_r_q = 0:1:60;
[P_B_q,P_R_q] = meshgrid(P_b_q,P_r_q);

EIq = interp2(P_B,P_R,EI,P_B_q,P_R_q);

save('Control valves\EI_fine_P3.mat','EIq')




% GJ
load('Control valves\GJ_P3.mat')
GJ = GJ_P3';



GJq = interp2(P_B,P_R,GJ,P_B_q,P_R_q);
save('Control valves\GJ_fine_P3.mat','GJq')





% Curvature
load('Control valves\kappa_P3.mat')
kappa = -kappa_P3';


kappaq = interp2(P_B,P_R,kappa,P_B_q,P_R_q);
save('Control valves\kappa_fine_P3.mat','kappaq')


% torsion

load('Control valves\tau_P3.mat')
tau = tau_P3';


tauq = interp2(P_B,P_R,tau,P_B_q,P_R_q);
save('Control valves\tau_fine_P3.mat','tauq')






