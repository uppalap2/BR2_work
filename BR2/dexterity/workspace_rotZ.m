% collect end points of BR2 (control valves data) for give length and plot
% the analytical workspace with base rotation
clear all
clc

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
F_e = [0;0;3e-3]*10;
n = 15;

Ls = 31e-2;


% load the fine estimated parameters
load('Control valves_2\EI_fine_BR2.mat');
load('Control valves_2\GJ_fine_BR2.mat');
load('Control valves_2\kappa_fine_BR2.mat');
load('Control valves_2\tau_fine_BR2.mat');

surfaceArea = zeros(length(Ls));

ii = 1;
L = Ls(ii);
% nPoints = 61*25; % fine 
nPoints = 29*22*73;
EndPoints = zeros(nPoints,3);

k = 1;
for j = 0:5:360
    rotz= [cosd(j) -sind(j) 0; sind(j) cosd(j) 0; 0 0 1];
    rot = rotz(:)';
   for i = 1:29*22
        
        params = [EIq(i) GJq(i) kappaq(i) tauq(i)]; % fine
        
        % params = [EI_P3(i) GJ_P3(i) kappa_P3(i) tau_P3(i)];
        [shape_final] = cosserat_full_mod(params,WpL,F_e,Ls,gravity_on,n_t,[zeros(1,3) rot]);
        EndPoints(k,:) = shape_final(end,1:3);
        k = k+1;
    end
end
% filename

filename = strcat('Control valves_2\workspace_rotz',num2str(Ls*100),'cm_',num2str(F_e(3)*100),'g','.mat');
save(filename,'EndPoints')

% %% get surface area
% % % https://www.mathworks.com/matlabcentral/answers/184234-how-do-i-determine-the-surface-area-of-a-2-d-surface-in-a-3-d-space
% tri = delaunay(EndPoints(:,1),-EndPoints(:,3));
% P = [EndPoints(:,1),EndPoints(:,2),-EndPoints(:,3)];
% 
% 
% v1 = P(tri(:,2), :) - P(tri(:,1), :);
% v2 = P(tri(:,3), :) - P(tri(:,2), :);
% 
% cp = 0.5*cross(v1,v2);
% 
% surfaceArea(ii) = sum(sqrt(dot(cp, cp, 2)))
% 
% trisurf(tri,EndPoints(:,1),EndPoints(:,2),-EndPoints(:,3))
% axis equal
% sound(randn(4096, 1), 8192)