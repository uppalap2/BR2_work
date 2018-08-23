load('Control valves_2\EI_fine_BR2.mat');
load('Control valves_2\GJ_fine_BR2.mat');
load('Control valves_2\kappa_fine_BR2.mat');
load('Control valves_2\tau_fine_BR2.mat');

i = 36; %1 to 29*22

% 31e-2,.1194,[0;0;3*1e-3]*10,15,10.344,15.2013,.0166,.0036

option = 1; % gravity is on always
if option == 0
    gravity_on = 0;
else
    gravity_on = 1;
end
% number of points for BVP solver
n_t     = 101;%51 for < 20 % 61 for 20

init_g_value = 9.81;

WpL = .1194;
F_e = [0;0;0e-3]*10;
n = 15;

Ls = 31e-2;

% bvp4c

 params = [EIq(i) GJq(i) kappaq(i) tauq(i)*0]; % fine
% params = [EI_P3(i) GJ_P3(i) kappa_P3(i) tau_P3(i)];
[shape_final_2] = cosserat_full_mod(params,WpL,F_e,Ls,gravity_on,n_t,[zeros(1,3) 1.0000 zeros(1,3) 1 zeros(1,3) 1]);

% ode
[shape_final] = Kirchoff_mod(EIq(i),GJq(i),[kappaq(i);0;tauq(i)*0],Ls,F_e,WpL);



plot3(shape_final(:,1),shape_final(:,2),shape_final(:,3),'r*');
hold on
axis equal
grid on
plot3(shape_final_2(:,1),shape_final_2(:,2),shape_final_2(:,3),'g*');
