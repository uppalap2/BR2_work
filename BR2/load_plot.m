% % % 
% % % 
% % % 
% clf
% % %  till 16 gms
% % fig1 = plot(L4g_YZ(:,2),L4g_YZ(:,3),'r.');
% % hold on
% % axis equal
% % 
% % [k,v] = boundary(L4g_YZ(:,2),L4g_YZ(:,3),1);
% % 
% %  
% %   plot(L4g_YZ(k,2),L4g_YZ(k,3))
% % 
% % 
% % fig1.MarkerEdgeColor = [44 127 184]/256;
% % fig1.MarkerFaceColor = [44 127 184]/256;
% % fig1.Color = [44 127 184]/256;
% % 
% % xlabel ('Y ','FontSize',12,'FontWeight','bold')
% % ylabel ('Z','FontSize',12,'FontWeight','bold','interpreter', 'tex')
% % set(gca,'linewidth',1,'FontSize',12)
% % 
% % % grid on
% % font_size = 12;
% % f_width = 2;
% % f_height = 2;
% % font_rate=10/font_size;
% % set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])
% % 
% % % 
% % % % 16g = .10; 
% % % % %% 20 g
% % % % plot(L20g_YZ(:,2),L20g_YZ(:,3),'r.');
% % % % hold on
% % % % axis equal
% % % % 
% % % % plot(L20g_YZ(L20g_YZ(:,3)>0.13,2),L20g_YZ(L20g_YZ(:,3)>0.13,3),'g.')
% % % % 
% % % % 
% % % %  reduced = [L20g_YZ(L20g_YZ(:,3)>0.13,2) L20g_YZ(L20g_YZ(:,3)>0.13,3)];
% % % %  
% % % %  [k,v] = boundary(reduced(:,1),reduced(:,2),1);
% % % %  
% % % %  plot(reduced(k,1), reduced(k,2))
% % % %% 30 g
% % % % plot(L30g_YZ(:,2),L30g_YZ(:,3),'r.');
% % % % hold on
% % % % axis equal
% % % % 
% % % % plot(L30g_YZ(L30g_YZ(:,2)<0.17,2),L30g_YZ(L30g_YZ(:,2)<0.17,3),'g.')
% % % % 
% % % % 
% % % %  reduced = [L30g_YZ(L30g_YZ(:,2)<0.17,2) L30g_YZ(L30g_YZ(:,2)<0.17,3)];
% % % %  
% % % %  [k,v] = boundary(reduced(:,1),reduced(:,2),1);
% % % %  
% % % %  plot(reduced(k,1), reduced(k,2))
% % % %  
% % % 
% %% 40 g
% % plot(L40g_YZ(:,2),L40g_YZ(:,3),'r.');
% hold on
% axis equal
% 
% fig1 = plot(L40g_YZ(L40g_YZ(:,2)<0.17,2),L40g_YZ(L40g_YZ(:,2)<0.17,3),'r.')
% 
% 
%  reduced = [L40g_YZ(L40g_YZ(:,2)<0.17,2) L40g_YZ(L40g_YZ(:,2)<0.17,3)];
%  
%  [k,v] = boundary(reduced(:,1),reduced(:,2),1);
%  
%  plot(reduced(k,1), reduced(k,2))
%  fig1.MarkerEdgeColor = [44 127 184]/256;
% fig1.MarkerFaceColor = [44 127 184]/256;
% fig1.Color = [44 127 184]/256;
% 
% xlabel ('Y ','FontSize',12,'FontWeight','bold')
% ylabel ('Z','FontSize',12,'FontWeight','bold','interpreter', 'tex')
% set(gca,'linewidth',1,'FontSize',12)
% 
% % grid on
% font_size = 12;
% f_width = 2;
% f_height = 2;
% font_rate=10/font_size;
% set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])
% % %  
% % % 
% % % %% 50 g
% % % plot(L50g_YZ(:,2),L50g_YZ(:,3),'r.');
% % % hold on
% % % axis equal
% % % 
% % % plot(L50g_YZ(L50g_YZ(:,2)<0.135,2),L50g_YZ(L50g_YZ(:,2)<0.135,3),'g.')
% % % 
% % % 
% % %  reduced = [L50g_YZ(L50g_YZ(:,2)<0.135,2) L50g_YZ(L50g_YZ(:,2)<0.135,3)];
% % %  
% % %  [k,v] = boundary(reduced(:,1),reduced(:,2),1);
% % %  
% % %  plot(reduced(k,1), reduced(k,2))
% 
% 
% %% main plot
% 
load  = [0:4:20 30:10:50];

% workspace = [.0226 .0241 .0240 .0190 .0156 .0135 .0098 .0075 .0057];
 workspacebyLsquare = [.0226 .0241 .0240 .0190 .0156 .0135 .0098 .0075 .0057]/(31e-2)^2;

fig1 = plot(load,workspacebyLsquare,'--o','linewidth',3);

fig1.MarkerEdgeColor = [217 95 14]/256;
fig1.MarkerFaceColor = [217 95 14]/256;
fig1.Color = [117 107 177]/256;
fig1.MarkerSize = 10;

xlabel ('Load (in gms)','FontSize',12,'FontWeight','bold')
ylabel ('YZ plane workspace area/L^{2} ','FontSize',12,'FontWeight','bold','interpreter', 'tex')
set(gca,'linewidth',2,'FontSize',12)

grid on
font_size = 12;
f_width = 4.5;
f_height = 4.5;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])