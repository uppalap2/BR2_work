n = length(end_position);
YZdata = zeros(n,3);

% because each point will have a different rotation angle, need to do it
% one by one (so using a for loop)

for i = 1:n
    theta = atan2(end_position(i,3),end_position(i,4));
    RotZ = [cos(theta) -sin(theta) 0;
        sin(theta) cos(theta) 0;
        0          0          1];
    
    YZdata(i,:) = (RotZ*end_position(i,3:5)')';
    
end


fig1 = plot(YZdata(:,2),-YZdata(:,3),'ko')
axis equal
grid on
axis tight
hold on
fig1.MarkerEdgeColor = [217 95 14]/256;
fig1.MarkerFaceColor = [217 95 14]/256;



fig2 = plot(YZdata(1:15:end,2),-YZdata(1:15:end,3),'ks-','linewidth',2);
fig2.MarkerEdgeColor = [1 1 1]/256;
fig2.MarkerFaceColor = [1 1 1]/256;


grid on
xlim([0 .23]);
font_size = 12;
f_width = 3;
f_height = 3;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])
xlabel ('Y(in m) ','FontSize',12,'FontWeight','bold')
ylabel('Z(in m) ','FontSize',12,'FontWeight','bold')
set(gca,'linewidth',2,'FontSize',12)
legend('BR^{2}','B^{3}')

%% Workspace for 8gms and 50 gms
% 8gms
load('Control valves_2\workspace_31cm_8g.mat')


n = length(EndPoints);
YZdata = zeros(n,3);

% because each point will have a different rotation angle, need to do it
% one by one (so using a for loop)

for i = 1:n
    theta = atan2(EndPoints(i,1),EndPoints(i,2));
    RotZ = [cos(theta) -sin(theta) 0;
        sin(theta) cos(theta) 0;
        0          0          1];
    
    YZdata(i,:) = (RotZ*EndPoints(i,1:3)')';
    
end
fig3 = plot(YZdata(:,2),-YZdata(:,3),'ko')
hold on
axis tight
axis equal
grid on
fig3.MarkerEdgeColor = [1 11 11]/256;
fig3.MarkerFaceColor = [43 140 190]/256;
fig4 = plot(162.3e-3, -211.5e-3,'ks');
fig4.MarkerSize = 10;
fig4.MarkerEdgeColor = [1 1 1]/256;
fig4.MarkerFaceColor = [227 74 51]/256;
set(gca,'linewidth',2,'FontSize',16)
font_size = 14;
f_width = 3;
f_height = 3;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])

%% 50 gms

load('Control valves_2\workspace_31cm_50g.mat')


n = length(EndPoints);
YZdata = zeros(n,3);

% because each point will have a different rotation angle, need to do it
% one by one (so using a for loop)

for i = 1:n
    theta = atan2(EndPoints(i,1),EndPoints(i,2));
    RotZ = [cos(theta) -sin(theta) 0;
        sin(theta) cos(theta) 0;
        0          0          1];
    
    YZdata(i,:) = (RotZ*EndPoints(i,1:3)')';
    
end

fig3 = plot(YZdata(YZdata(:,2)<.15,2),-YZdata(YZdata(:,2)<.15,3),'ko')
hold on
axis tight
axis equal
grid on
fig3.MarkerEdgeColor = [1 11 11]/256;
fig3.MarkerFaceColor = [43 140 190]/256;
fig4 = plot(162.3e-3, -211.5e-3,'ks');
fig4.MarkerSize = 14;
fig4.MarkerEdgeColor = [1 1 1]/256;
fig4.MarkerFaceColor = [227 74 51]/256;
set(gca,'linewidth',2,'FontSize',16)
font_size = 12;
f_width = 3;
f_height = 3;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])