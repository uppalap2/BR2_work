% collect end points of P3 (control valves data) for give length and plot
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
n_t_1      = 101;%51 for < 20 % 61 for 20

% dont tweak this, can be any number
n_f        = 101;%31 for < 20 % 61 for 20

init_g_value = 9.81;

WpL = .0863;
F_e = [0;0;1.5e-3]*10;
n = 35;

Ls = [10]*5e-2;
% load estimated parametsers
% load('Control valves\EI_P3.mat');
% load('Control valves\GJ_P3.mat');
% load('Control valves\kappa_P3.mat');
% load('Control valves\tau_P3.mat');

% load the fine estimated parameters
load('Control valves\EI_fine_P3.mat');
load('Control valves\GJ_fine_P3.mat');
load('Control valves\kappa_fine_P3.mat');
load('Control valves\tau_fine_P3.mat');

surfaceArea = zeros(length(Ls));

ii = 1;
L = Ls(ii);
% nPoints = 61*25; % fine 
nPoints = 13*10;
EndPoints = zeros(nPoints,3);
for i = 1:nPoints
    params = [EIq(i) GJq(i) kappaq(i) tauq(i)]; % fine
% params = [EI_P3(i) GJ_P3(i) kappa_P3(i) tau_P3(i)];
    [~,~,shape_final,~,~]  = getShape(params,... % e only for cons3 function
                                    WpL,...
                                    F_e,L,...
                                    gravity_on,...
                                    n_t_1,...
                                    n_f,...
                                    0,n,init_g_value,option);
EndPoints(i,:) = shape_final(end,1:3);                                
% if rem(i,13) == 0
%     plot3(EndPoints(:,1),EndPoints(:,2),-EndPoints(:,3),'r*')
%     axis equal
%     grid on
%     pause
% end
end

%% get surface area
% % https://www.mathworks.com/matlabcentral/answers/184234-how-do-i-determine-the-surface-area-of-a-2-d-surface-in-a-3-d-space
tri = delaunay(EndPoints(:,1),-EndPoints(:,3));
P = [EndPoints(:,1),EndPoints(:,2),-EndPoints(:,3)];


v1 = P(tri(:,2), :) - P(tri(:,1), :);
v2 = P(tri(:,3), :) - P(tri(:,2), :);

cp = 0.5*cross(v1,v2);

surfaceArea(ii) = sum(sqrt(dot(cp, cp, 2)))

trisurf(tri,EndPoints(:,1),EndPoints(:,2),-EndPoints(:,3))
axis equal
