% File which fits the 4 parameters based on the experiments



clear all
clc
clf
%% fit the parameters with the experimental data
option = 2;

if option == 1

% getParams(exp_data,~,WpL,F_e,n,Kmax,Tmin,EImin,GJmin)
% for old data with manual valves
[params_opti] = getParams('Manual valves\data6_0.mat',40e-2,.1075,[0;0;2*10e-3]*10,15,1.4,4,.0054,.0035); % weight in gms is multiplied by 10 for force (EE)

elseif option == 2
% for old data with control valves
% load 'Control valves\P3_18_30.mat'
% exp_data = fnplt(cscvn(exp_data(:,[1:end])'))';
% % save('Control valves\P3_18_30.mat','exp_data')
[params_opti] = getParams_g('Control valves_2\BR2_14_28.mat',31e-2,.1194,[0;0;3*1e-3]*10,15,10.344,15.2013,.0166,.0036); % weight in gms is multiplied by 10 for force (EE)

else % for data with both rotating actuators actuated
 [params_opti] = getParams_g_r('Control valves_2\BR2_7_7_R.mat',31e-2,.1194,[0;0;3*1e-3]*10,15,3.7344,.01,.0144,.0029); % weight in gms is multiplied by 10 for force (EE)   
end


grid on

axis equal

% % testing with cosserat_full
% 
% x0_par = [    0.0144
%     0.0030
%   -15.5
%    5.5];
% WpL = .1194;
% EC_F = [0;0;3*1e-3]*10;
% L = 31e-2;
% gravity_on=1;
% n_t = 101;
% hold on
% [shape,C] = cosserat_full(x0_par,WpL,EC_F,L,gravity_on,n_t)
% shape_final = shape;
% plot3(shape_final(:,1),shape_final(:,2),shape_final(:,3),'go');
% 

