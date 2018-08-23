%% Script to get the curvature and torsion only when bending is actuated with gravity
% From the previous data EI = .0254 and GJ = .0122 is known
% We use this information to fit kappa and tau with experimental data



% for prototype 1
clf
EI = .011;
GJ = EI/5;
L = 37.5e-2;
WpL = .1087;
EC_F = [0;0;2e-3]*10;
gravity_on = 1;

n_t = 100;

% fit values and file 
kappa = -9.7;
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
load('Control valves_2\P1_36_0.mat');
plot3(exp_data(:,2)/1000,exp_data(:,1)/1000,-exp_data(:,3)/1000,'r');
view(-90,0)


%% exp data for planar benidng

% exp_data = [181.8689	9.1979	-16.5547
% 210.7854	98.4568	-9.9862
% 300.1089	113.3873	-12.2897
% 349.1792	36.8026	-11.6258
% 285.229	-33.6229	-22.5676
% 
% ];
% 
% exp_data = exp_data/1e3 - exp_data(1,:)/1e3;
% 
% plot3(exp_data(:,3)*0,exp_data(:,1),exp_data(:,2),'r')
% view(90,0)



