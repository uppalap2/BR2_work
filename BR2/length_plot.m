% % plot(yz_40cm(yz_40cm(:,3)>0,2),yz_40cm(yz_40cm(:,3)>0,3),'r.')
% 
% % plot(yz_40cm(:,2),yz_40cm(:,3),'r.')
% 
% %% 40 cm
% % plot(yz_40cm(yz_40cm(:,3)>0.11,2),yz_40cm(yz_40cm(:,3)>0.11,3),'g.')
% % hold on
% % axis equal
% % 
% % [k,v] = boundary(yz_40cm(yz_40cm(:,3)>.11,2),yz_40cm(yz_40cm(:,3)>.11,3),1)
% %  reduced = [yz_40cm(yz_40cm(:,3)>0.11,2) yz_40cm(yz_40cm(:,3)>0.11,3)]
% %  
% %  plot(reduced(k,1),reduced(k,2))
% 
% %% 35 cm
% 
% plot(yz_35cm(:,2),yz_35cm(:,3),'r.')
% axis equal
% hold on
% grid on
% plot(yz_35cm(yz_35cm(:,3)>0,2),yz_35cm(yz_35cm(:,3)>0,3),'g.')
% hold on
% axis equal
% 
% 
% [k,v] = boundary(yz_35cm(yz_35cm(:,3)>0,2),yz_35cm(yz_35cm(:,3)>0,3),1)
%  reduced = [yz_35cm(yz_35cm(:,3)>0,2) yz_35cm(yz_35cm(:,3)>0,3)]
%  
%  plot(reduced(k,1),reduced(k,2))

%% plot

area = [4.56e-7 1.9623e-5 1.9646e-4 .0014 .0067 .0198 .0356 .0364];
l = [5:5:40]*1e-2;

fig1 = plot(l,area./(l).^2,'--o','linewidth',3);

fig1.MarkerEdgeColor = [217 95 14]/256;
fig1.MarkerFaceColor = [217 95 14]/256;
fig1.Color = [117 107 177]/256;
fig1.MarkerSize = 10;

xlabel ('L (in m)','FontSize',12,'FontWeight','bold')
ylabel ('YZ plane workspace area/L^{2}','FontSize',12,'FontWeight','bold','interpreter', 'tex')
set(gca,'linewidth',2,'FontSize',12)

grid on
font_size = 12;
f_width = 4.5;
f_height = 4.5;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])