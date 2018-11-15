clear all
clc
load simulation_data.mat


edges_z = [-1:.2:1];
edges_Px = (-18:2:22)/10;
edges_Py = (-22:2:22)/10;
edges_Pz = (-6:2:32)/10;


[~,~,tagsOz] = histcounts(data_rot_mod(:,6),edges_z);
[~,~,tagsOy] = histcounts(data_rot_mod(:,5),edges_z);
[~,~,tagsOx] = histcounts(data_rot_mod(:,4),edges_z);


[~,~,tagsPz] = histcounts(data_rot_mod(:,3),edges_Pz);
[~,~,tagsPy] = histcounts(data_rot_mod(:,2),edges_Py);
[~,~,tagsPx] = histcounts(data_rot_mod(:,1),edges_Px);


tags = [tagsPx tagsPy tagsPz tagsOx tagsOy tagsOz];

% get the unique entries
[pos_ori,ia,ic] = unique(tags,'rows');

% get the unique positions and count their orientations
[only_pos,iia,iic] = unique(pos_ori(:,1:3),'rows');

counts = accumarray(iic,1); % in each position different orienattions

dexterity = counts;

scatter3((only_pos(:,1)-10)*2,(only_pos(:,2)-12)*2,(only_pos(:,3)-4)*2,30,dexterity*10,'filled')
colormap jet
axis equal
grid on
colorbar
view(150,30)
ylabel('Y(cm) ','Fontweight','bold','fontsize',12)

xlabel('X(cm) ','Fontweight','bold','fontsize',12)
zlabel('Z(cm)','Fontweight','bold','fontsize',12)
set(gca,'linewidth',1,'FontSize',12)
% xlim([10 24]*6.89476)

grid on
ax = gca;

set(gcf, 'Position', [100, 100, 500, 500])
axis equal


