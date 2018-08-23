%% Script to get the curvature and torsion only when bending is actuated with gravity
% From the previous data EI = .0254 and GJ = .0122 is known
% We use this information to fit kappa and tau with experimental data



% for prototype 1
clf
EI = .025;
GJ =.0029;
L = 30e-2;
WpL = .1194;
EC_F = [0;0;3e-3]*10;
gravity_on = 1;

n_t = 100;

% fit values and file 
kappa = -11.65;
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
load('Control valves_2\BR2_28_28_R.mat');
plot3(exp_data(:,2)/1000,exp_data(:,1)/1000,-exp_data(:,3)/1000,'r');
view(-90,0)


%% exp data for planar benidng

% exp_data = [-94.3308	137.7323	-5.6968
% -67.0242	134.2941	-3.4449
% -21.6058	131.4224	-2.304
% 28.1232	143.6514	-1.6864
% 63.1392	164.3374	-5.3273
% 93.5572	197.2452	-9.7503
% 123.3745	244.3282	-15.0087
% 
% ];
% 
% exp_data = exp_data/1e3 - exp_data(1,:)/1e3;
% 
% plot3(exp_data(:,3)*0,exp_data(:,2),exp_data(:,1),'r')
% view(90,0)

%% exp data for dual rotation

% exp_data = [-197.7146	-83.9623	22.4385
% -199.1396	-52.3828	15.8075
% -228.1056	-6.3792	17.8954
% -289.7764	18.5302	15.3856
% -342.9739	0.1106	17.2374
% -374.6723	-49.0946	15.6618
% -363.3641	-107.479	27.1295
% 
% ];
% 
% exp_data = exp_data/1e3 - exp_data(1,:)/1e3;
% 
% plot3(exp_data(:,3),-exp_data(:,1),exp_data(:,2),'r')
% view(90,0)