%% Script to get the curvature and torsion only when bending is actuated with gravity
% From the previous data EI = .0254 and GJ = .0122 is known
% We use this information to fit kappa and tau with experimental data



% for prototype 1
clf
EI = .03;
GJ = EI/5;
L = 37.6e-2;
WpL = .0887;
EC_F = [0;0;1.5e-3]*10;
gravity_on = 1;

n_t = 100;

% fit values and file 
kappa = -.05;
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
load('Control valves_2\P2_0_0.mat');
plot3(exp_data(:,2)/1000,exp_data(:,1)/1000,-exp_data(:,3)/1000,'r');
view(-90,0)


%% exp data for planar benidng

% exp_data = [188.6	9.1391	-8.0488
% 203.5737	65.428	-8.0499
% 276.6517	93.862	-8.5528
% 330.9918	37.1341	-7.5567
% 296.0617	-32.0584	-3.8304
% 218.8548	-30.8859	-0.5263
% ];
% 
% exp_data = exp_data/1e3 - exp_data(1,:)/1e3;
% 
% plot3(exp_data(:,3)*0,exp_data(:,1),exp_data(:,2),'r')
% view(90,0)

