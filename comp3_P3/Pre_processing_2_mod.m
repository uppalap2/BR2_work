%% Pre_processing _2
% Selection = 1 (for curvatures)
% Selection = 2 (for rigidity values)

% Input is the Y and Z location experimnetally obtained when the
% manipulator is actuated to bending pressures.
% This code is used to obtain the pre curvature (in absence of any forces)
% at a given pressure.

% for prototype 3
% clf
function [kappa,tau,EI,GJ] = Pre_processing_2(kappa,tau,EI,GJ,selection,filename)

clf

% example:
%[] = Pre_processing_2(-1.9,0, .009,.009/5, 1 ,'Control valves\P3_6_0.mat')
%[] = Pre_processing_2(-1.9,0, .009,.009/5, 2 ,'Control valves\P3_6_0.mat')

% selection = 1; for curvatures
% selection = 2; for rigidity values



% some trash values of EI, GJ (rigidity and shear modulus)(initally set)
% EI = .009;
% GJ = .009/5;

% length
L = 40e-2;

% Weight per unit length (kg/m)
WpL = .0863;

% End force
F_e = [0;0;1.5e-3]*10;

% POints for the solver
n_t_1 = 151;

% Force estimation points (can be anything, doesn't matter)
n_f = 10;
n = 12;

% gravity value
init_g_value = 9.81;



if selection == 1
    
    % Gravity force on(1) , off(0)
    gravity_on = 0;
    
    % option 0 for without gravity, 1 for with gravity, 2 for forces estimation
    option = 0;
    
%     % guess values for kappa, tau
%     kappa = -12.2;
%     tau = 0;
    
    %     load('Control valves\P3_6_0.mat');
    params_opti = [EI GJ kappa tau] ;
    
    [~,~,shape_final,~,~]  = getShape(params_opti,... % e only for cons3 function
        WpL,...
        F_e,L,...
        gravity_on,...
        n_t_1,...
        n_f,...
        0,n,init_g_value,option);
    
    plot3(shape_final(:,1),shape_final(:,2),shape_final(:,3),'b:');
    hold on
    axis equal
    grid on
    shape_final(end,1:3)*1000
    %     plot3(exp_data(:,1)/1000,exp_data(:,2)/1000,-exp_data(:,3)/1000,'r');
    view(-90,0)
    
    % view(0,90)
    % pause(3)
else
    % Gravity force on(1) , off(0)
    gravity_on = 1;
    
    % option 0 for without gravity, 1 for with gravity, 2 for forces estimation
    option = 0;
    
    % orignal values for kappa, tau
%     kappa = -12.2;
%     tau = 0;
    
    % Fit values for EI,GJ
    
%     EI = .009;
%     GJ = EI/5;

    % filename = 'Control valves\P3_6_0.mat'
    load(filename);
    params_opti = [EI GJ kappa tau] ;
    
    [~,~,shape_final,~,~]  = getShape(params_opti,... % e only for cons3 function
        WpL,...
        F_e,L,...
        gravity_on,...
        n_t_1,...
        n_f,...
        0,n,init_g_value,option);
    
    plot3(shape_final(:,1),shape_final(:,2),shape_final(:,3),'b:');
    hold on
    axis equal
    grid on
    shape_final(end,1:3)*1000
    plot3(exp_data(:,1)/1000,exp_data(:,2)/1000,-exp_data(:,3)/1000,'r');
    view(-90,0)
    
end