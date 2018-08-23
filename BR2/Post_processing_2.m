%% Post _2 for fine data for simulation
close all

P_b = 7:7:28;
P_r = 0:7:28;
[P_B,P_R] = meshgrid(P_b,P_r);



% % Plots with first obj function and constraints on last 5 points and
% orientation

% EI
load('Control valves_2\EI_BR2.mat')
EI = EI_BR2';


P_b_q = 7:1:28;
P_r_q = 0:1:28;
[P_B_q,P_R_q] = meshgrid(P_b_q,P_r_q);

EIq = interp2(P_B,P_R,EI,P_B_q,P_R_q);

save('Control valves_2\EI_fine_BR2.mat','EIq')




% GJ
load('Control valves_2\GJ_BR2.mat')
GJ = GJ_BR2';



GJq = interp2(P_B,P_R,GJ,P_B_q,P_R_q);
save('Control valves_2\GJ_fine_BR2.mat','GJq')





% Curvature
load('Control valves_2\kappa_BR2.mat')
kappa = kappa_BR2';


kappaq = interp2(P_B,P_R,kappa,P_B_q,P_R_q);
save('Control valves_2\kappa_fine_BR2.mat','kappaq')


% torsion

load('Control valves_2\tau_BR2.mat')
tau = tau_BR2';


tauq = interp2(P_B,P_R,tau,P_B_q,P_R_q);
save('Control valves_2\tau_fine_BR2.mat','tauq')
