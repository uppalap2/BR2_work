% collect end points of P1 (control valves data) for give length and plot
% the analytical workspace
clear all
clc

option = 1; % gravity is on always
if option == 0
    gravity_on = 0;
else
    gravity_on = 1;
end
% number of points for BVP solver
n_t_1      = 61;%51 for < 20 % 61 for 20

% dont tweak this, can be any number
n_f        = 61;%31 for < 20 % 61 for 20

init_g_value = 9.81;

WpL = .1075;
F_e = [0;0;2*10e-3]*10;
n = 15;

L = 40e-2;

% load the estimated parameters
load('Control valves\EI_fine_P1.mat');
load('Control valves\GJ_fine_P1.mat');
load('Control valves\kappa_fine_P1.mat');
load('Control valves\tau_fine_P1.mat');

nPoints = 825;
EndPoints = zeros(825,3);
for i = 1:nPoints
    params = [EIq(i) GJq(i) kappaq(i) tauq(i)];
    [~,~,shape_final,~,~]  = getShape(params,... % e only for cons3 function
                                    WpL,...
                                    F_e,L,...
                                    gravity_on,...
                                    n_t_1,...
                                    n_f,...
                                    0,n,init_g_value,option);
EndPoints(i,:) = shape_final(end,1:3);                                
end