%% with ori
exp_pts_ori = [0.435129	1.949658	1.434524
0.49324	1.891479	1.576429
0.565819	1.783117	1.804244
0.682109	1.641898	2.025276
0.780016	1.552242	2.154206
0.528179	1.333947	2.582592
0.357989	1.214764	2.729448
0.12463	1.368492	2.611649
-0.199509	1.206208	2.756628
-0.547011	1.377634	2.447416
-0.616939	1.339303	2.435882
-0.462831	1.512526	2.349361
-0.333123	1.828031	1.898393
-0.177932	1.906833	1.58464
0.165648	1.948731	1.356689
0.495832	1.904271	1.040559
0.910755	1.729347	0.793962
1.087414	1.517307	0.515001
1.180265	1.055959	0.078635
1.148904	0.929816	-0.042799
1.055026	0.887267	-0.101724
0.811718	0.981756	-0.157761
0.530337	0.838367	-0.239375
0.350286	1.308776	-0.076304
-0.103387	0.713602	-0.08273
-0.295297	0.990228	0.237395
0.207369	1.611859	0.196847
0.169047	1.808364	0.540211
0.316107	1.951423	0.954523
0.403622	1.942308	1.094796
];

theta = -15;
roty = [ cosd(theta) 0 sind(theta);0 1 0; -sind(theta) 0 cosd(theta) ];

rot_data_ori = exp_pts_ori*roty - 1*[.7 0  0];


% figure
% plot3(rot_data(:,2)/10,rot_data(:,1)/10,rot_data(:,3)/10,'k*')
% hold on
des_pts = [2.0073    0.1184    1.3701
    1.9095    0.3340    1.7025
    1.7313    0.4899    2.0123
    1.5047    0.5582    2.2853
    1.2700    0.5268    2.5093
    1.0693    0.4012    2.6741
    0.9385    0.2039    2.7723
    0.9008   -0.0298    2.7994
    0.9631   -0.2582    2.7543
    1.1142   -0.4405    2.6389
    1.3271   -0.5440    2.4585
    1.5638   -0.5503    2.2212
    1.7819   -0.4582    1.9377
    1.9425   -0.2843    1.6210
    2.0168   -0.0595    1.2852
    1.9917    0.1759    0.9455
    1.8715    0.3799    0.6173
    1.6777    0.5159    0.3155
    1.4451    0.5598    0.0537
    1.2151    0.5036   -0.1564
    1.0289    0.3574   -0.3051
    0.9197    0.1473   -0.3858
    0.9071   -0.0891   -0.3949
    0.9933   -0.3096   -0.3319
    1.1630   -0.4747   -0.1996
    1.3857   -0.5550   -0.0041
    1.6217   -0.5362    0.2458
    1.8288   -0.4214    0.5389
    1.9700   -0.2314    0.8618
    2.0200   -0.0000    1.2000];



% with only pos
exp_pts_pos = [0.268808	1.976764	1.538578
0.04971	1.906189	1.597864
0.22643	1.801446	1.710296
0.429539	1.697126	1.924152
0.726471	1.428248	2.110465
0.579018	1.364213	2.259154
0.360234	1.270342	2.410043
0.00804	1.339039	2.7
-0.26751	1.340315	2.575743
-0.373969	1.412674	2.370047
-0.569021	1.504308	2.317173
-0.464737	1.691188	2.124496
-0.269517	1.844981	1.903825
-0.221192	1.914067	1.581263
0.092368	1.952881	1.3
0.047068	1.91535	1.076843
0.084678	1.91418	0.955591
0.135775	1.763481	0.626142
0.282088	1.443847	0.09477
0.126921	1.244549	-0.026308
0.269318	1.188026	-0.3032
0.088631	1.206934	-0.2086
-0.437721	0.84782	-0.30267
-0.198842	1.18267	-0.13835
-0.212242	1.275062	-0.1023
-0.172242	1.453076	0.104366
-0.215295	1.57288	0.267588
-0.23334	1.860424	0.75402
-0.046605	1.963065	1.14287
0.348808	1.937405	1.319045

];


errors_pos = [des_pts(:,1)-exp_pts_pos(:,2) des_pts(:,2)-exp_pts_pos(:,1) des_pts(:,3)-exp_pts_pos(:,3)];
errors_pos = sqrt(cumsum(errors_pos.^2,2));
errors_pos = errors_pos(:,3);

errors_ori = [des_pts(:,1)-rot_data_ori(:,2) des_pts(:,2)-rot_data_ori(:,1) des_pts(:,3)-rot_data_ori(:,3)];
errors_ori = sqrt(cumsum(errors_ori.^2,2));
errors_ori = errors_ori(:,3);

% errors = [des_pts(:,1)-(exp_pts_c(:,2)) des_pts(:,2)-(exp_pts_c(:,1))  des_pts(:,3)-exp_pts_c(:,3)]

figure
plot3(des_pts(:,1)/10,des_pts(:,2)/10,des_pts(:,3)/10,'Marker','*','Color',[0 0 0],'MarkerFaceColor',[0/256 0/256 0/256],'Linestyle','None')
hold on
axis equal
plot3(exp_pts_pos(:,2)/10,exp_pts_pos(:,1)/10,exp_pts_pos(:,3)/10,'Marker','o','Color',[0 0 0],'MarkerFaceColor',[187/256 85/256 102/256],'Linestyle','None')
plot3(rot_data_ori(:,2)/10,rot_data_ori(:,1)/10,rot_data_ori(:,3)/10,'Marker','s','Color',[0 0 0],'MarkerFaceColor',[221/256 170/256 51/256],'Linestyle','None')
ylabel('Y (in m)','Fontweight','bold','fontsize',12)

xlabel('X (in m)','Fontweight','bold','fontsize',12)
zlabel('Z (in m)','Fontweight','bold','fontsize',12)
set(gca,'linewidth',1,'FontSize',12)
grid on
ax = gca;
ax.YAxis.Exponent = -2;
ax.XAxis.Exponent = -2;
ax.ZAxis.Exponent = -2;
% axis equal
% legend('Target','BR^2 shape','Simulation','Experiment')
legend('Desired curve','Pos (Exp)','Pos + Ori(Exp)')
view(-57,15)
set(gcf, 'Position', [100, 100, 500, 500])

figure

plot(errors_pos/10,'--','color',[0 68 136]/256,'linewidth',2)
hold on
plot(errors_ori/10,'--','color',[187 85 102]/256,'linewidth',2)

legend('Pos (Exp)','Pos + Ori (Exp)')

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

%% ################ loading effect : circle

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
legend('Target','BR^2 shape','Simulation (10 gms load)')
view(3)
set(gcf, 'Position', [100, 100, 500, 500])
axis equal

%% %% ################ loading effect : line
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
legend('Target','BR^2 shape','Simulation (10 gms load)')
view(3)
set(gcf, 'Position', [100, 100, 500, 500])
axis equal