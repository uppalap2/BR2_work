function [end_position,shape] = forward_kin(Pb,Pr1,L,EL)
% Default
% EL = [0;0;3e-3]*10;
% L = 31e-2;
load('Control valves_2\EI_fine_BR2.mat');
load('Control valves_2\GJ_fine_BR2.mat');
load('Control valves_2\kappa_fine_BR2.mat');
load('Control valves_2\tau_fine_BR2.mat');

P_b_q = 7:1:28;
P_r_q = 0:1:28;

n_t     = 101;%51 for < 20 % 61 for 20
% init_g_value = 9.81;
WpL = .1194;
F_e = EL;
% n = 15;
% L = 31e-2;
gravity_on = 1;

k = interp2(P_b_q,P_r_q,kappaq,Pb,Pr1);
t = interp2(P_b_q,P_r_q,tauq,Pb,Pr1);
EI = interp2(P_b_q,P_r_q,EIq,Pb,Pr1);
GJ = interp2(P_b_q,P_r_q,GJq,Pb,Pr1);

shape = cosserat_full_mod([EI GJ k t],WpL,F_e,L,gravity_on,n_t);

P_end = shape(end,1:3)';
end_position = P_end;

plot3((shape(:,1)),(shape(:,2)),(shape(:,3)));
axis equal
grid on


end