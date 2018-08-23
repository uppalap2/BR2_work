clear all
clc

load patch_point4_wp.mat;

% unique position and orinetations
%  ia and ic, such that C = A(ia) and A = C(ic). 
[pos_ori,ia,ib] = unique(patch_point(:,1:4),'rows');

% unique position
[pos_alone,iia,iib] = unique(pos_ori(:,1:2),'rows');

counts = accumarray(iib,1); % in each position different orienattions

dexterity = counts/1800;




scatter((pos_alone(:,1)-10)*5,(pos_alone(:,2)-20)*5,24,dexterity,'filled')
colormap(jet)
colorbar
axis equal
grid on
xlabel ('Y (in mm)','FontSize',12,'FontWeight','bold')
ylabel ('Z(in mm)','FontSize',12,'FontWeight','bold')

set(gca,'linewidth',2,'FontSize',12)


font_size = 12;
f_width = 4.5;
f_height = 4.5;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])
% hold on
% scatter((36-10)*5,-(72-20)*5,24,'r*')
%% 49 25(.0194 dexterity) 
max_point_orientations = pos_ori((pos_ori(:,1) == 49) & (pos_ori(:,2)==25),:);
% 36 72 (.0144 dexterity)
max_point_orientations2 = pos_ori((pos_ori(:,1) == 36) & (pos_ori(:,2)==72),:);
% save('orientations.mat','max_point_orientations')
% save('orientations1.mat','max_point_orientations2')