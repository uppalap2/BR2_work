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

else 
% for old data with control valves
% load 'Control valves\P3_18_30.mat'
% exp_data = fnplt(cscvn(exp_data(:,[1:end])'))';
% % save('Control valves\P3_18_30.mat','exp_data')
[params_opti] = getParams_g('Control valves_2\P2_27_0.mat',37.7e-2,.0887,[0;0;1.5*1e-3]*10,15,9.7,.001,.0074,.0015); % weight in gms is multiplied by 10 for force (EE)
end


grid on

axis equal




