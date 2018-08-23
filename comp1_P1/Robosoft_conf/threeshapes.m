% Plot for comparing workspaces between no load at all, only self weght and
% 15 gms end load

% % [~,PosEnd_noload] = ShapeParams(24,8,[0 0 0]);% MAKE SURE TO EDIT WPL IN ShapeParams
% % 
% % 
% % [~,PosEnd_Swalone] = ShapeParams(24,8,[0 0 0]);
% % 
% % [~,PosEnd_Sw_EL] = ShapeParams(24,8,[0 0 15e-2]);
% 
% PosEnd_noload = [-PosEnd_noload(:,1),PosEnd_noload(:,2),-PosEnd_noload(:,3)];
% PosEnd_Swalone = [-PosEnd_Swalone(:,1),PosEnd_Swalone(:,2),-PosEnd_Swalone(:,3)];% 43 gms
% 
% PosEnd_Sw_EL = [-PosEnd_Sw_EL(:,1),PosEnd_Sw_EL(:,2),-PosEnd_Sw_EL(:,3)];% 43 gms + 15 gms

% save('PosEnd_noload.mat','PosEnd_noload');
% save('PosEnd_Swalone.mat','PosEnd_Swalone');
% save('PosEnd_Sw_EL.mat','PosEnd_Sw_EL');
load PosEnd_noload.mat
load PosEnd_Swalone.mat
load PosEnd_Sw_EL.mat

plot3(-PosEnd_Swalone(:,1),PosEnd_Swalone(:,2),-PosEnd_Swalone(:,3),'g','linewidth',3)
hold on
plot3(-PosEnd_Sw_EL(:,1),PosEnd_Sw_EL(:,2),-PosEnd_Sw_EL(:,3),'b','linewidth',3)
plot3(-PosEnd_noload(:,1),PosEnd_noload(:,2),-PosEnd_noload(:,3),'r','linewidth',3)



