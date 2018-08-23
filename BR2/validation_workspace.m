%% validation for workspace(one side)

load('Control valves_2\EI_fine_BR2.mat');
load('Control valves_2\GJ_fine_BR2.mat');
load('Control valves_2\kappa_fine_BR2.mat');
load('Control valves_2\tau_fine_BR2.mat');

EL = [0;0;3e-3]*10;
L = 31e-2;


P_b_q = 7:1:28;
P_r_q = 0:1:28;

n_t     = 101;%51 for < 20 % 61 for 20
% init_g_value = 9.81;
WpL = .1194;
F_e = EL;
% n = 15;
% L = 31e-2;
gravity_on = 1;

Pb = 7:2:27;
Pr1 = 0:2:28;

end_position = zeros(165,5);
ii= 1;
for i = 1:length(Pb)
    for j = 1:length(Pr1)
        
        k = interp2(P_b_q,P_r_q,kappaq,Pb(i),Pr1(j));
        t = interp2(P_b_q,P_r_q,tauq,Pb(i),Pr1(j));
        EI = interp2(P_b_q,P_r_q,EIq,Pb(i),Pr1(j));
        GJ = interp2(P_b_q,P_r_q,GJq,Pb(i),Pr1(j));
        
        shape = cosserat_full_mod([EI GJ k t],WpL,F_e,L,gravity_on,n_t);
        
        P_end = shape(end,1:3);
        end_position(ii,:) = [Pb(i) Pr1(j) P_end];
        ii = ii+1;
%         plot3(abs(shape(:,1)),abs(shape(:,2)),abs(-shape(:,3)));
%         axis equal
%         grid on
    end
end


