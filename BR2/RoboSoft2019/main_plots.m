%%% Figures
%  In total three sub figures for each figure a) 3D plot showing the
%  desired points, simulation and experimental points
%  b) Inputs Pb, Pr1,Pr2 and theta/4 in one plot
%  c) errors simulation and experimental

%% Only pos: line

% inverse inputs (O/P of NN) obtained using NN
load test_line_pos_x18y0.mat
test = test(linspace(3,60,20),:);
test_exp = test([1 6:5:16 20],:);

% exp end points(first column is the base)
exp_pts = [163.3942	-4.2792	-525.9855;
    200.8044-14.525	169.5228	-492.0766;
    193.1657-14.525	184.28	-448.5503;
    168.0447	180.2861	-403.8233;
    148.5211+14.525	176.3036	-364.8363;
    135.5045+14.525	174.4827	-343.7393];
exp_pts = (exp_pts-exp_pts(1,:))/100; % converting 
exp_pts = exp_pts(2:end,:); % removing the start point
exp_pts = [exp_pts(:,2) exp_pts(:,1) exp_pts(:,3)]; % changing the axis

% line points (variable name is inps)

load('line_test_pos_x18y0.mat')

inps = inps(linspace(3,60,20),:);
inps_exp = inps([1 6:5:16 20],:);

figure


set(gca,'nextplot','replacechildren'); 

% v = VideoWriter('line_pos.avi');
% open(v);
final_pos = zeros(length(test(:,1)),3);
test(test(:,1)>28,1) = 28;
test(test(:,2)>28,2) = 28;
test(test(:,3)>28,3) = 28;

plot3(inps(:,1)/10,inps(:,2)/10,inps(:,3)/10,'Marker','s','Color',[0 0 0],'MarkerFaceColor',[187/256 85/256 102/256],'Linestyle','none')
hold on

for k = 1:1:length(test)
   k;
   [final_pos(k,:),orient_rot,IP,shape] = forward_kin_rot(test(k,1),test(k,2),test(k,3),test(k,4));
   
   if k==11
       plot3(shape(1,:),shape(2,:),shape(3,:),'Color',[204/256 187/256 68/256],'linewidth',2,'Linestyle','--')
       
       hold on
   end
   
   

%    frame = getframe(gcf);
%    writeVideo(v,frame);
%    pause(1)
end

% close(v);


plot3(final_pos(:,1),final_pos(:,2),final_pos(:,3),'Marker','o','Color',[0 0 0],'MarkerFaceColor',[0/256 68/256 136/256],'Linestyle','none')

% plot3(exp_pts(:,1)/10,exp_pts(:,2)/10,exp_pts(:,3)/10,'Linestyle','none','Marker','d','Color',[0 0 0],'MarkerFaceColor',[34/256 136/256 51/256])
ylabel('Y (in m)','Fontweight','bold','fontsize',12)

xlabel('X (in m)','Fontweight','bold','fontsize',12)
zlabel('Z (in m)','Fontweight','bold','fontsize',12)
set(gca,'linewidth',1,'FontSize',12)
% xlim([10 24]*6.89476)

grid on
ax = gca;
ax.YAxis.Exponent = -2;
ax.XAxis.Exponent = -2;
ax.ZAxis.Exponent = -2;
% axis equal
% legend('Target','BR^2 shape','Simulation','Experiment')
legend('Target','BR^2 shape','Simulation')
view(3)
set(gcf, 'Position', [100, 100, 500, 500])
axis equal

figure
% inps plot and errors plot
plot(test(:,1),'-','Color',[221 170 51]/256,'linewidth',2);
hold on
% plot(test(:,2),'--','Color',[187 85 102]/256,'linewidth',2);
% plot(test(:,3),':','Color',[0 68 136]/256,'linewidth',2); 
% plot(test(:,4)/6,'-.','Color',[0 0 0]/256,'linewidth',2);
% legend('P_B','P_{Rc}','P_{Rcc}','\theta/6')
% 
% ylabel('Magnitude','Fontweight','bold','fontsize',12)
% 
% xlabel('Point','Fontweight','bold','fontsize',12)
% grid on
% set(gca,'linewidth',1,'FontSize',12)
% set(gcf, 'Position', [100, 100, 500, 500])
hold on
plot(test(:,2),'--','Color',[187 85 102]/256,'linewidth',2);
plot(test(:,3),':','Color',[0 68 136]/256,'linewidth',2); 
plot(test(:,4)/6,'-.','Color',[0 0 0]/256,'linewidth',2);
legend('P_B','P_{Rc}','P_{Rcc}','\theta/6')

ylabel('Magnitude','Fontweight','bold','fontsize',12)

xlabel('Point','Fontweight','bold','fontsize',12)
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])



% errors

figure
% Simulation error
error_sim = sqrt(cumsum((inps(:,1:3)/10-final_pos).^2,2));
error_sim = error_sim(:,3);

plot(error_sim,'--','color',[0 68 136]/256,'linewidth',2)
hold on
error_exp = sqrt(cumsum((exp_pts/10 - inps_exp(:,1:3)/10).^2,2));
error_exp = abs(error_exp(:,3)-.01);% -1 because of dia of actuator

% plot([1 6:5:16 20],error_exp,'Linestyle','none','Marker','s','Color',[0 0 0],'MarkerFaceColor',[34 136 51]/256,'MarkerSize',8)
% legend('Simulation','Experiment')
legend('Simulation')

ylabel('Error (in m)','Fontweight','bold','fontsize',12)

xlabel('Point','Fontweight','bold','fontsize',12)
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])
ax = gca;
ax.YAxis.Exponent = -2;
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])

%% ########################################### only pos: Circle#############################################
close all

% inverse inputs (O/P of NN) obtained using NN
load test_circle_pos_x18.mat
test = test(linspace(2,60,30),:);
test_exp = test([1 3:3:30],:);

% exp end points(first column is the base)
exp_pts = [163.3942	-4.2792	-525.9855;
    138.4926	169.492	-406.6595;
    152.8666	174.3347	-416.3582;
    158.9867	176.4189	-424.5909;
    144.8753	177.3621	-439.4796;
    136.2374	173.8921	-463.4184;
    207.2283	175.7005	-464.9947;
    192.2275	182.9709	-452.7377;
    147.9357	191.5841	-427.7613;
    139.6094	191.4848	-405.6472;
    132.2242	180.8389	-397.2613;
    145.9072	183.7242	-379.3035];

exp_pts = (exp_pts-exp_pts(1,:))/100; % converting 
exp_pts = exp_pts(2:end,:); % removing the start point
exp_pts = [exp_pts(:,2) exp_pts(:,1) exp_pts(:,3)]; % changing the axis

% line points (variable name is inps)

load('circle_test_pos_x18.mat')

inps = inps(linspace(2,60,30),:);
inps_exp = inps([1 3:3:30],:);

figure


set(gca,'nextplot','replacechildren'); 

% v = VideoWriter('line_pos.avi');
% open(v);
final_pos = zeros(length(test(:,1)),3);
test(test(:,1)>28,1) = 28;
test(test(:,2)>28,2) = 28;
test(test(:,3)>28,3) = 28;

plot3(inps(:,1)/10,inps(:,2)/10,inps(:,3)/10,'Marker','s','Color',[0 0 0],'MarkerFaceColor',[187/256 85/256 102/256],'Linestyle','none')
hold on

for k = 1:1:length(test)
   k;
   [final_pos(k,:),orient_rot,IP,shape] = forward_kin_rot(test(k,1),test(k,2),test(k,3),test(k,4));
   
   if k==any([1 3:3:30])
       plot3(shape(1,:),shape(2,:),shape(3,:),'Color',[204/256 187/256 68/256],'linewidth',2,'Linestyle','--')
       
       hold on
   end
   
   

%    frame = getframe(gcf);
%    writeVideo(v,frame);
%    pause(1)
end

% close(v);


plot3(final_pos(:,1),final_pos(:,2),final_pos(:,3),'Marker','o','Color',[0 0 0],'MarkerFaceColor',[0/256 68/256 136/256],'Linestyle','none')

% plot3(exp_pts(:,1)/10,exp_pts(:,2)/10,exp_pts(:,3)/10,'Linestyle','none','Marker','d','Color',[0 0 0],'MarkerFaceColor',[34/256 136/256 51/256])
ylabel('Y (in m)','Fontweight','bold','fontsize',12)

xlabel('X (in m)','Fontweight','bold','fontsize',12)
zlabel('Z (in m)','Fontweight','bold','fontsize',12)
set(gca,'linewidth',1,'FontSize',12)
% xlim([10 24]*6.89476)

grid on
ax = gca;
ax.YAxis.Exponent = -2;
ax.XAxis.Exponent = -2;
ax.ZAxis.Exponent = -2;
% axis equal
% legend('Target','BR^2 shape','Simulation','Experiment')
legend('Target','BR^2 shape','Simulation')
view(3)
set(gcf, 'Position', [100, 100, 500, 500])
axis equal

figure
% inps plot and errors plot
plot(test(:,1),'-','Color',[221 170 51]/256,'linewidth',2);
hold on
plot(test(:,2),'--','Color',[187 85 102]/256,'linewidth',2);
plot(test(:,3),':','Color',[0 68 136]/256,'linewidth',2); 
plot(test(:,4)/6,'-.','Color',[0 0 0]/256,'linewidth',2);
legend('P_B','P_{Rc}','P_{Rcc}','\theta/6')

ylabel('Magnitude','Fontweight','bold','fontsize',12)

xlabel('Point','Fontweight','bold','fontsize',12)
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])

% errors

figure
% Simulation error
error_sim = sqrt(cumsum((inps(:,1:3)/10-final_pos).^2,2));
error_sim = error_sim(:,3);

plot(error_sim,'--','color',[0 68 136]/256,'linewidth',2)
hold on
error_exp = sqrt(cumsum((exp_pts/10 - inps_exp(:,1:3)/10).^2,2));
error_exp = abs(error_exp(:,3)-.01);% -1 because of dia of actuator

% plot([1 3:3:30],error_exp,'Linestyle','none','Marker','s','Color',[0 0 0],'MarkerFaceColor',[34 136 51]/256,'MarkerSize',8)
% legend('Simulation','Experiment')
legend('Simulation')

ylabel('Error (in m)','Fontweight','bold','fontsize',12)

xlabel('Point','Fontweight','bold','fontsize',12)
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])
ax = gca;
ax.YAxis.Exponent = -2;
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])

%% #####################################ONLY POS: VIVIANI#################
close all

% inverse inputs (O/P of NN) obtained using NN
load test_viviani_pos_3.mat
test = test(linspace(2,60,30),:);
test_exp = test([1 3:3:30],:);

% exp end points(first column is the base)
exp_pts = [163.43	16.0872	-215.0126;
    167.7607	191.2764	-383.6429;
    188.9813	172.3511	-358.7093;
    215.2907	124.0751	-299.8223;
    101.7408	115.1132	-271.5514;
    83.9434	   159.8428	  -321.5451;
    155.5779	192.1388	-392.5347;
    128.0531	172.513	    -482.3289;
    156.1222	125.6198	-535.6802;
    186.7747	130.1483	-532.3829;
    159.7171	159.1734	-500.4312;
    171.0334	194.3209	-399.7697];


exp_pts = (exp_pts-exp_pts(1,:))/100; % converting 
exp_pts = exp_pts(2:end,:); % removing the start point
exp_pts = [exp_pts(:,2) exp_pts(:,1) exp_pts(:,3)]; % changing the axis

% line points (variable name is inps)

load('viviani_test_pos_3.mat')

inps = inps(linspace(2,60,30),:);
inps_exp = inps([1 3:3:30],:);

%### testing
% plot3(inps_exp(:,1),inps_exp(:,2),inps_exp(:,3),'r*')
% axis equal
% hold on
% plot3(exp_pts(:,1),exp_pts(:,2),exp_pts(:,3),'b*')

figure


set(gca,'nextplot','replacechildren'); 

% v = VideoWriter('line_pos.avi');
% open(v);
final_pos = zeros(length(test(:,1)),3);
test(test(:,1)>28,1) = 28;
test(test(:,2)>28,2) = 28;
test(test(:,3)>28,3) = 28;

plot3(inps(:,1)/10,inps(:,2)/10,inps(:,3)/10,'Marker','s','Color',[0 0 0],'MarkerFaceColor',[187/256 85/256 102/256],'Linestyle','none')
hold on

for k = 1:1:length(test)
   k;
   [final_pos(k,:),orient_rot,IP,shape] = forward_kin_rot(test(k,1),test(k,2),test(k,3),test(k,4));
   
   if k==any([1 3:3:30])
       plot3(shape(1,:),shape(2,:),shape(3,:),'Color',[204/256 187/256 68/256],'linewidth',2,'Linestyle','--')
       
       hold on
   end
   
   

%    frame = getframe(gcf);
%    writeVideo(v,frame);
%    pause(1)
end

% close(v);


plot3(final_pos(:,1),final_pos(:,2),final_pos(:,3),'Marker','o','Color',[0 0 0],'MarkerFaceColor',[0/256 68/256 136/256],'Linestyle','none')

% plot3(exp_pts(:,1)/10,exp_pts(:,2)/10,exp_pts(:,3)/10,'Linestyle','none','Marker','d','Color',[0 0 0],'MarkerFaceColor',[34/256 136/256 51/256])
ylabel('Y (in m)','Fontweight','bold','fontsize',12)

xlabel('X (in m)','Fontweight','bold','fontsize',12)
zlabel('Z (in m)','Fontweight','bold','fontsize',12)
set(gca,'linewidth',1,'FontSize',12)
% xlim([10 24]*6.89476)

grid on
ax = gca;
ax.YAxis.Exponent = -2;
ax.XAxis.Exponent = -2;
ax.ZAxis.Exponent = -2;
% axis equal
% legend('Target','BR^2 shape','Simulation','Experiment')
legend('Target','BR^2 shape','Simulation')
view(3)
set(gcf, 'Position', [100, 100, 500, 500])
axis equal

figure
% inps plot and errors plot
plot(test(:,1),'-','Color',[221 170 51]/256,'linewidth',2);
hold on
plot(test(:,2),'--','Color',[187 85 102]/256,'linewidth',2);
plot(test(:,3),':','Color',[0 68 136]/256,'linewidth',2); 
plot(test(:,4)/6,'-.','Color',[0 0 0]/256,'linewidth',2);
legend('P_B','P_{Rc}','P_{Rcc}','\theta/6')

ylabel('Magnitude','Fontweight','bold','fontsize',12)

xlabel('Point','Fontweight','bold','fontsize',12)
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])

% errors

figure
% Simulation error
error_sim = sqrt(cumsum((inps(:,1:3)/10-final_pos).^2,2));
error_sim = error_sim(:,3);

plot(error_sim,'--','color',[0 68 136]/256,'linewidth',2)
hold on
error_exp = sqrt(cumsum((exp_pts/10 - inps_exp(:,1:3)/10).^2,2));
error_exp = abs(error_exp(:,3)-.01);% -1 because of dia of actuator

% plot([1 3:3:30],error_exp,'Linestyle','none','Marker','s','Color',[0 0 0],'MarkerFaceColor',[34 136 51]/256,'MarkerSize',8)
% legend('Simulation','Experiment')
legend('Simulation')

ylabel('Error (in m)','Fontweight','bold','fontsize',12)

xlabel('Point','Fontweight','bold','fontsize',12)
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])
ax = gca;
ax.YAxis.Exponent = -2;
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])

%% ##################################POS + ORI: line############################################
% inverse inputs (O/P of NN) obtained using NN
load test_line_sys_ori.mat
test = test(linspace(3,60,20),:);
test_exp = test([1 6:5:16 20],:);

% exp end points(first column is the base)
exp_pts = [163.3942	-4.2792	-525.9855;
    200.6017	181.5994	-476.4434;
    202.2943	195.7023	-432.5077;
    182.1809	191.3108	-416.7664;
    162.7838	190.8068	-374.979;
    146.029	186.4919	-326.5037];
exp_pts = (exp_pts-exp_pts(1,:))/100; % converting 
exp_pts = exp_pts(2:end,:); % removing the start point
exp_pts = [exp_pts(:,2) exp_pts(:,1) exp_pts(:,3)]; % changing the axis

% line points (variable name is inps)

load('line_test_sys_ori.mat')

inps = inps(linspace(3,60,20),:);
inps_exp = inps([1 6:5:16 20],:);

figure


set(gca,'nextplot','replacechildren'); 

% v = VideoWriter('line_pos.avi');
% open(v);
final_pos = zeros(length(test(:,1)),3);
test(test(:,1)>28,1) = 28;
test(test(:,2)>28,2) = 28;
test(test(:,3)>28,3) = 28;

plot3(inps(:,1)/10,inps(:,2)/10,inps(:,3)/10,'Marker','s','Color',[0 0 0],'MarkerFaceColor',[187/256 85/256 102/256],'Linestyle','none')
hold on

for k = 1:1:length(test)
   k;
   [final_pos(k,:),orient_rot,IP,shape] = forward_kin_rot(test(k,1),test(k,2),test(k,3),test(k,4));
   
   if k==11
       plot3(shape(1,:),shape(2,:),shape(3,:),'Color',[204/256 187/256 68/256],'linewidth',2,'Linestyle','--')
       
       hold on
   end
   
   

%    frame = getframe(gcf);
%    writeVideo(v,frame);
%    pause(1)
end

% close(v);


plot3(final_pos(:,1),final_pos(:,2),final_pos(:,3),'Marker','o','Color',[0 0 0],'MarkerFaceColor',[0/256 68/256 136/256],'Linestyle','none')

% plot3(exp_pts(:,1)/10,exp_pts(:,2)/10,exp_pts(:,3)/10,'Linestyle','none','Marker','d','Color',[0 0 0],'MarkerFaceColor',[34/256 136/256 51/256])
ylabel('Y (in m)','Fontweight','bold','fontsize',12)

xlabel('X (in m)','Fontweight','bold','fontsize',12)
zlabel('Z (in m)','Fontweight','bold','fontsize',12)
set(gca,'linewidth',1,'FontSize',12)
% xlim([10 24]*6.89476)

grid on
ax = gca;
ax.YAxis.Exponent = -2;
ax.XAxis.Exponent = -2;
ax.ZAxis.Exponent = -2;
% axis equal
% legend('Target','BR^2 shape','Simulation','Experiment')
legend('Target','BR^2 shape','Simulation')
view(3)
set(gcf, 'Position', [100, 100, 500, 500])
axis equal

figure
% inps plot and errors plot
plot(test(:,1),'-','Color',[221 170 51]/256,'linewidth',2);
hold on
plot(test(:,2),'--','Color',[187 85 102]/256,'linewidth',2);
plot(test(:,3),':','Color',[0 68 136]/256,'linewidth',2); 
plot(test(:,4)/6,'-.','Color',[0 0 0]/256,'linewidth',2);
legend('P_B','P_{Rc}','P_{Rcc}','\theta/6')

ylabel('Magnitude','Fontweight','bold','fontsize',12)

xlabel('Point','Fontweight','bold','fontsize',12)
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])

% errors

figure
% Simulation error
error_sim = sqrt(cumsum((inps(:,1:3)/10-final_pos).^2,2));
error_sim = error_sim(:,3);

plot(error_sim,'--','color',[0 68 136]/256,'linewidth',2)
hold on
error_exp = sqrt(cumsum((exp_pts/10 - inps_exp(:,1:3)/10).^2,2));
error_exp = abs(error_exp(:,3)-.01);% -1 because of dia of actuator

% plot([1 6:5:16 20],error_exp,'Linestyle','none','Marker','s','Color',[0 0 0],'MarkerFaceColor',[34 136 51]/256,'MarkerSize',8)
% legend('Simulation','Experiment')
legend('Simulation')

ylabel('Error (in m)','Fontweight','bold','fontsize',12)

xlabel('Point','Fontweight','bold','fontsize',12)
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])
ax = gca;
ax.YAxis.Exponent = -2;
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])

%% ############################POS+ORI: CIRCLE###################

close all

% inverse inputs (O/P of NN) obtained using NN
load test_circle_sys_ori.mat
test = test(linspace(2,60,30),:);
test_exp = test([1 3:3:30],:);

% exp end points(first column is the base)
exp_pts = [163.3942	-4.2792	-525.9855;
    138.8031	176.1349	-410.6242;
    146.7616	176.9411	-415.151;
    156.9278	188.3158	-414.5884;
    144.4149	180.5311	-447.273;
    114.0657	176.9474	-459.9279;
    105.0811	167.2995	-473.8271;
    91.0237	160.0179	-464.7122;
    73.9674	164.4158	-437.8017;
    69.4843	161.8292	-419.7722;
    90.0366	171.2683	-407.7664;
    132.3001	177.7366	-396.1465];

exp_pts = (exp_pts-exp_pts(1,:))/100; % converting 
exp_pts = exp_pts(2:end,:); % removing the start point
exp_pts = [exp_pts(:,2) exp_pts(:,1) exp_pts(:,3)]; % changing the axis

% line points (variable name is inps)

load('circle_test_sys_ori.mat')

inps = inps(linspace(2,60,30),:);
inps_exp = inps([1 3:3:30],:);

figure


set(gca,'nextplot','replacechildren'); 

% v = VideoWriter('line_pos.avi');
% open(v);
final_pos = zeros(length(test(:,1)),3);
test(test(:,1)>28,1) = 28;
test(test(:,2)>28,2) = 28;
test(test(:,3)>28,3) = 28;

plot3(inps(:,1)/10,inps(:,2)/10,inps(:,3)/10,'Marker','s','Color',[0 0 0],'MarkerFaceColor',[187/256 85/256 102/256],'Linestyle','none')
hold on

for k = 1:1:length(test)
   k;
   [final_pos(k,:),orient_rot,IP,shape] = forward_kin_rot(test(k,1),test(k,2),test(k,3),test(k,4));
   
   if k==any([1 3:3:30])
       plot3(shape(1,:),shape(2,:),shape(3,:),'Color',[204/256 187/256 68/256],'linewidth',2,'Linestyle','--')
       
       hold on
   end
   
   

%    frame = getframe(gcf);
%    writeVideo(v,frame);
%    pause(1)
end

% close(v);


plot3(final_pos(:,1),final_pos(:,2),final_pos(:,3),'Marker','o','Color',[0 0 0],'MarkerFaceColor',[0/256 68/256 136/256],'Linestyle','none')

% plot3(exp_pts(:,1)/10,exp_pts(:,2)/10,exp_pts(:,3)/10,'Linestyle','none','Marker','d','Color',[0 0 0],'MarkerFaceColor',[34/256 136/256 51/256])
ylabel('Y (in m)','Fontweight','bold','fontsize',12)

xlabel('X (in m)','Fontweight','bold','fontsize',12)
zlabel('Z (in m)','Fontweight','bold','fontsize',12)
set(gca,'linewidth',1,'FontSize',12)
% xlim([10 24]*6.89476)

grid on
ax = gca;
ax.YAxis.Exponent = -2;
ax.XAxis.Exponent = -2;
ax.ZAxis.Exponent = -2;
% axis equal
% legend('Target','BR^2 shape','Simulation','Experiment')
legend('Target','BR^2 shape','Simulation')
view(3)
set(gcf, 'Position', [100, 100, 500, 500])
axis equal

figure
% inps plot and errors plot
plot(test(:,1),'-','Color',[221 170 51]/256,'linewidth',2);
hold on
plot(test(:,2),'--','Color',[187 85 102]/256,'linewidth',2);
plot(test(:,3),':','Color',[0 68 136]/256,'linewidth',2); 
plot(test(:,4)/6,'-.','Color',[0 0 0]/256,'linewidth',2);
legend('P_B','P_{Rc}','P_{Rcc}','\theta/6')

ylabel('Magnitude','Fontweight','bold','fontsize',12)

xlabel('Point','Fontweight','bold','fontsize',12)
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])

% errors

figure
% Simulation error
error_sim = sqrt(cumsum((inps(:,1:3)/10-final_pos).^2,2));
error_sim = error_sim(:,3);

plot(error_sim,'--','color',[0 68 136]/256,'linewidth',2)
hold on
error_exp = sqrt(cumsum((exp_pts/10 - inps_exp(:,1:3)/10).^2,2));
error_exp = abs(error_exp(:,3)-.01);% -1 because of dia of actuator

% plot([1 3:3:30],error_exp,'Linestyle','none','Marker','s','Color',[0 0 0],'MarkerFaceColor',[34 136 51]/256,'MarkerSize',8)
% legend('Simulation','Experiment')
legend('Simulation')

ylabel('Error (in m)','Fontweight','bold','fontsize',12)

xlabel('Point','Fontweight','bold','fontsize',12)
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])
ax = gca;
ax.YAxis.Exponent = -2;
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])

%% ########################## POS+ORI:VIVIANI ##########################
close all

% inverse inputs (O/P of NN) obtained using NN
load test_viviani_sys_ori.mat
test = test(linspace(2,60,30),:);
test_exp = test([1 3:3:30],:);

% exp end points(first column is the base)
exp_pts = [163.43	16.0872	-215.0126;
    175.1009	194.4932	-381.4052;
    178.8067	177.6954	-333.411;
    185.8517	127.7268	-261.227;
    120.6656	113.115	-249.045;
    105.867	149.5761	-287.5794;
    162.9144	193.5714	-381.4013;
    259.4165	153.4727	-467.8588;
    234.5018	88.0699	-538.1816;
    248.3146	91.9493	-534.9055;
    161.5068	155.812	-502.4263;
    178.9358	191.6615	-412.0556];


exp_pts = (exp_pts-exp_pts(1,:))/100; % converting 
exp_pts = exp_pts(2:end,:); % removing the start point
exp_pts = [exp_pts(:,2) exp_pts(:,1) -exp_pts(:,3)]; % changing the axis

% line points (variable name is inps)

load('viviani_test_sys_ori.mat')

inps = inps(linspace(2,60,30),:);
inps_exp = inps([1 3:3:30],:);

%### testing
% plot3(inps_exp(:,1),inps_exp(:,2),inps_exp(:,3),'r*')
% axis equal
% hold on
% plot3(exp_pts(:,1),exp_pts(:,2),exp_pts(:,3),'b*')

figure


set(gca,'nextplot','replacechildren'); 

% v = VideoWriter('line_pos.avi');
% open(v);
final_pos = zeros(length(test(:,1)),3);
test(test(:,1)>28,1) = 28;
test(test(:,2)>28,2) = 28;
test(test(:,3)>28,3) = 28;

plot3(inps(:,1)/10,inps(:,2)/10,inps(:,3)/10,'Marker','s','Color',[0 0 0],'MarkerFaceColor',[187/256 85/256 102/256],'Linestyle','none')
hold on

for k = 1:1:length(test)
   k;
   [final_pos(k,:),orient_rot,IP,shape] = forward_kin_rot(test(k,1),test(k,2),test(k,3),test(k,4));
   
   if k==any([1 3:3:30])
       plot3(shape(1,:),shape(2,:),shape(3,:),'Color',[204/256 187/256 68/256],'linewidth',2,'Linestyle','--')
       
       hold on
   end
   
   

%    frame = getframe(gcf);
%    writeVideo(v,frame);
%    pause(1)
end

% close(v);


plot3(final_pos(:,1),final_pos(:,2),final_pos(:,3),'Marker','o','Color',[0 0 0],'MarkerFaceColor',[0/256 68/256 136/256],'Linestyle','none')

% plot3(exp_pts(:,1)/10,exp_pts(:,2)/10,exp_pts(:,3)/10,'Linestyle','none','Marker','d','Color',[0 0 0],'MarkerFaceColor',[34/256 136/256 51/256])
ylabel('Y (in m)','Fontweight','bold','fontsize',12)

xlabel('X (in m)','Fontweight','bold','fontsize',12)
zlabel('Z (in m)','Fontweight','bold','fontsize',12)
set(gca,'linewidth',1,'FontSize',12)
% xlim([10 24]*6.89476)

grid on
ax = gca;
ax.YAxis.Exponent = -2;
ax.XAxis.Exponent = -2;
ax.ZAxis.Exponent = -2;
% axis equal
% legend('Target','BR^2 shape','Simulation','Experiment')
legend('Target','BR^2 shape','Simulation')
view(3)
set(gcf, 'Position', [100, 100, 500, 500])
axis equal

figure
% inps plot and errors plot
plot(test(:,1),'-','Color',[221 170 51]/256,'linewidth',2);
hold on
plot(test(:,2),'--','Color',[187 85 102]/256,'linewidth',2);
plot(test(:,3),':','Color',[0 68 136]/256,'linewidth',2); 
plot(test(:,4)/6,'-.','Color',[0 0 0]/256,'linewidth',2);
legend('P_B','P_{Rc}','P_{Rcc}','\theta/6')

ylabel('Magnitude','Fontweight','bold','fontsize',12)

xlabel('Point','Fontweight','bold','fontsize',12)
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])

% errors

figure
% Simulation error
error_sim = sqrt(cumsum((inps(:,1:3)/10-final_pos).^2,2));
error_sim = error_sim(:,3);

plot(error_sim,'--','color',[0 68 136]/256,'linewidth',2)
hold on
error_exp = sqrt(cumsum((exp_pts/10 - inps_exp(:,1:3)/10).^2,2));
error_exp = abs(error_exp(:,3)-.01);% -1 because of dia of actuator

% plot([1 3:3:30],error_exp,'Linestyle','none','Marker','s','Color',[0 0 0],'MarkerFaceColor',[34 136 51]/256,'MarkerSize',8)
% legend('Simulation','Experiment')
legend('Simulation')

ylabel('Error (in m)','Fontweight','bold','fontsize',12)

xlabel('Point','Fontweight','bold','fontsize',12)
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])
ax = gca;
ax.YAxis.Exponent = -2;
grid on
set(gca,'linewidth',1,'FontSize',12)
set(gcf, 'Position', [100, 100, 500, 500])