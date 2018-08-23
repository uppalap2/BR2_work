%% Script to get the curvature and torsion only when bending is actuated with gravity
% From the previous data EI = .0254 and GJ = .0122 is known
% We use this information to fit kappa and tau with experimental data



% for prototype 1
clf
EI = .008;
GJ = EI/5;
L = 37.6e-2;
WpL = .0863;
EC_F = [0;0;1.5e-3]*10;
gravity_on = 1;

n_t = 100;

% fit values and file 
kappa = -15;
tau = 0;


params_opti = [EI GJ kappa tau] ;


[shape_final,C] = cosserat_full(params_opti,WpL,EC_F,L,gravity_on,n_t)
                                
plot3(shape_final(:,1),shape_final(:,2),shape_final(:,3),'b:');
hold on
axis equal
grid on
xlabel 'X'
ylabel 'Y'
zlabel 'Z'
%% for rigidity stuff
load('Control valves_2\P3_28_0.mat');
plot3(exp_data(:,2)/1000,exp_data(:,1)/1000,-exp_data(:,3)/1000,'r');
view(-90,0)


%% exp data for planar benidng

% exp_data = [262.5125	1.5467	-10.7359
% 270.7474	62.1818	-11.4521
% 326.1403	119.4173	-9.0067
% 406.7823	119.1567	-6.9665
% 457.8924	57.387	-6.5074
% 452.7767	-16.3416	-7.1336
% 
% ];
% 
% exp_data = exp_data/1e3 - exp_data(1,:)/1e3;
% 
% plot3(exp_data(:,3)*0,exp_data(:,1),exp_data(:,2),'r')
% view(90,0)

