%%% PLOTS FOR BR2 %%%

%% BR2 anaytical workspace

load('Control valves_2/endpoints_31cm.mat');

plot3(endpoints_31cm(:,1),endpoints_31cm(:,2),endpoints_31cm(:,3),'o','Color',[27 158 119]/255);
axis equal
grid on
xlabel 'X'
ylabel 'Y'
zlabel 'Z'

% right side of the BR2
hold on
plot3(-endpoints_31cm(:,1),endpoints_31cm(:,2),endpoints_31cm(:,3),'o','Color',[117 112 179]/255);
axis equal
grid on
xlabel ('X (in m)','FontSize',12,'FontWeight','bold')
ylabel ('Y(in m)','FontSize',12,'FontWeight','bold')
zlabel ('Z(in m)','FontSize',12,'FontWeight','bold')

% 21_0 plot
shape = cosserat_full_mod([.0166,.0029,10.344,.001],.1194,[0;0;3*1e-3]*10,31e-2,1,101);
exp_data = shape;
shape1 = plot3(exp_data(:,1),exp_data(:,2),-exp_data(:,3),'-','Color',[217,95,2]/255,'LineWidth',5);
shape1.Color(4) = .8;

% home position
shape = cosserat_full_mod([.0166,.0029,0 ,0],.1194,[0;0;3*1e-3]*10,31e-2,1,101);
exp_data = shape;
shape2 = plot3(exp_data(:,1),exp_data(:,2),-exp_data(:,3),':','Color',[217,95,2]/255,'LineWidth',5);
shape2.Color(4) = .8;
% legend('CW','ACW','B21R0','Home')

% axis properties

set(gca,'linewidth',2,'FontSize',12)


font_size = 12;
f_width = 4.5;
f_height = 4.5;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])

%%  Plots for BR workspaces (volume)

c = categorical({'P1','P2','P3'});
Volume = [2.6109e-4, 2.053e-3,4.36e-3];
bar(c,Volume)
ylabel 'Workspace (in m^{3})'
set(gca,'linewidth',2,'FontSize',12)


font_size = 12;
f_width = 3;
f_height = 3;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])

%%  Plots for BR workspaces (area)

c = categorical({'P1','P2','P3'});
Volume = [3.7829e-3, 2.0404e-2,4.3202e-2];
bar(c,Volume)
ylabel 'Area (in m^{2})'
ax = gca;
ax.YAxis.Exponent = -2;
set(gca,'linewidth',2,'FontSize',12)



font_size = 12;
f_width = 3;
f_height = 3;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])


