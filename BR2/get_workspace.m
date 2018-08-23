% collect end points of BR2 (control valves data) for give length and plot
% the analytical workspace
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
F_e = [0;0;2e-3]*10;
n = 15;

Ls = 35e-2;


% load the fine estimated parameters
load('Control valves_2\EI_fine_BR2.mat');
load('Control valves_2\GJ_fine_BR2.mat');
load('Control valves_2\kappa_fine_BR2.mat');
load('Control valves_2\tau_fine_BR2.mat');

surfaceArea = zeros(length(Ls));

ii = 1;
L = Ls(ii);
% nPoints = 61*25; % fine 
nPoints = 29*22;
EndPoints = zeros(nPoints,3);
j = 1;

for i = 1:nPoints
params = [EIq(i) GJq(i) kappaq(i) tauq(i)]; % fine

% params = [EI_P3(i) GJ_P3(i) kappa_P3(i) tau_P3(i)];
[shape_final] = cosserat_full_mod(params,WpL,F_e,Ls,gravity_on,n_t,[zeros(1,3) 1.0000 zeros(1,3) 1 zeros(1,3) 1]);
 EndPoints(i,:) = shape_final(end,1:3);  
 
 if sum(EndPoints(i,:))==0 
     EndPoints(i,:) = [ 0 0 Ls];  
     points(j,:) = params;
     j = j+1;
%  elseif  (EndPoints(i,1) <= -1e-2) % only for higher loads
%      EndPoints(i,:) = [ 0 0 Ls];  
%      points(j,:) = params;
%      j = j+1;
%   elseif  (EndPoints(i,3) <= 20e-2)
%      EndPoints(i,:) = [ 0 0 Ls];  
%      points(j,:) = params;
%      j = j+1;     
     
 end
% if rem(i,13) == 0
%     plot3(EndPoints(:,1),EndPoints(:,2),-EndPoints(:,3),'r*')
%     axis equal
%     grid on
%     pause
% end
end

% filename

filename = strcat('Control valves_2\workspace_',num2str(Ls*100),'cm_',num2str(F_e(3)*100),'g','.mat');
save(filename,'EndPoints')

filename2 = strcat('Control valves_2\Bpoints_',num2str(Ls*100),'cm_',num2str(F_e(3)*100),'g','.mat');
save(filename2,'points')
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
sound(randn(4096, 1), 8192)