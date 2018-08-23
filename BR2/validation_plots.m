%% plots for validation of BR2


%%
points23_0_exp = [0	0	0;
-0.0306024	0.1727272	0.0604365;-0.0244633	0.178634	0.088206;
-0.0227	0.1814789	0.1092783;-0.024343	0.1805933	0.1316017;
-0.0223002	0.1716121	0.1630818; -0.0205506	0.1636444	0.1863054;
-0.0189271	0.1574462	0.2028834];

plot3(points23_0_exp(:,1),points23_0_exp(:,2),points23_0_exp(:,3),'r*');
axis equal
grid on


points23_0_ana = [0 0 0;
                    .0041 -.1846 .0023;
                    .0066 -.1882 .0104;
                    .0168 -.1912 .0198;
                    -.0303 -.1929 .0307;
                    -.0042 -.2009 .0499;
                    -.0022 -.2045 .0729;
                    -.0015 -.2054 .0964];
                
hold on
plot3(points23_0_ana(:,1),-points23_0_ana(:,2),points23_0_ana(:,3),'g*');
axis equal
grid on

%%
figure
points23_15_exp = [0	0	0;
-0.1630855	0.0368062	0.1571631
-0.1583602	0.0358095	0.169612
-0.1538051	0.0441118	0.1829482
-0.1420859	0.0307518	0.1985911
-0.1337587	0.0279139	0.2117862
-0.1285504	0.0243064	0.2214444
-0.1202316	0.0304545	0.2316724
];

plot3(abs(points23_15_exp(:,1)),abs(points23_15_exp(:,2)),abs(points23_15_exp(:,3)),'r*');
axis equal
grid on


points23_15_ana = [0 0 0;
                    .1670 -.0611 .1491;
                    .1597 -.0517 .1680;
                    .1513 -.0448 .1835;
                    .1428 -.0399 .1960;
                    .1272 -.0339 .2144;
                    .1141 -.0309 .2270;
                    .1033 -.0293 .2360];
                
hold on
plot3(abs(points23_15_ana(:,1)),abs(-points23_15_ana(:,2)),abs(points23_15_ana(:,3)),'g*');
axis equal
grid on

%%  all exp _points (to get the correct rotation)
figure

exp = [-0.0306024	0.1727272	0.0604365;
    -0.0244633	0.178634	0.088206;
    -0.0227	0.1814789	0.1092783;
    -0.024343	0.1805933	0.1316017;
    -0.0223002	0.1716121	0.1630818;
    -0.0205506	0.1636444	0.1863054;
    -0.0189271	0.1574462	0.2028834;
    -0.1202316	0.0304545	0.2316724;
    -0.1285504	0.0243064	0.2214444;
    -0.1337587	0.0279139	0.2117862;
    -0.1420859	0.0307518	0.1985911;
    -0.1538051	0.0441118	0.1829482;
    -0.1583602	0.0358095	0.169612;
    -0.1630855	0.0368062	0.1571631;
    0.1264535	0.1120431	0.1452156;
    0.1282327	0.1008617	0.1606147;
    0.126563	0.0924117	0.1742245;
    0.1248174	0.0881865	0.1813351;
    0.1182115	0.0720074	0.2009757;
    0.1114727	0.0707196	0.2167776;
    0.1019627	0.0695889	0.2315108];

theta = 10;
RotZ = [cosd(theta) -sind(theta) 0;
    sind(theta) cosd(theta) 0 ;
    0 0 1];

exp_rot = exp*RotZ;

plot3(exp(:,1),exp(:,2),exp(:,3),'g*')
hold on
plot3(exp_rot(:,1),exp_rot(:,2),exp_rot(:,3),'r*')
axis equal
grid on


%% Plot for 23_15 actuation with loads

loads = [3:3:12 18:6:30];

analCW = [.1670 -.0611 .1491;
          .1597 -.0517 .1680;
          .1513 -.0448 .1835;
          .1428 -.0399 .1960;
          .1272 -.0339 .2144;
          .1141 -.0309 .2270;
          .1033 -.0293 .2360];
expCW = [0.1264535	0.1120431	0.1452156;
    0.1282327	0.1008617	0.1606147;
    0.126563	0.0924117	0.1742245;
    0.1248174	0.0881865	0.1813351;
    0.1182115	0.0720074	0.2009757;
    0.1114727	0.0707196	0.2167776;
    0.1019627	0.0695889	0.2315108];
expCCW = [   -0.1630855	0.0368062	0.1571631;
    -0.1583602	0.0358095	0.169612;
    -0.1538051	0.0441118	0.1829482;
    -0.1420859	0.0307518	0.1985911;
    -0.1337587	0.0279139	0.2117862;
    -0.1285504	0.0243064	0.2214444;
    -0.1202316	0.0304545	0.2316724];
theta = 10;
RotZ = [cosd(theta) -sind(theta) 0;
    sind(theta) cosd(theta) 0 ;
    0 0 1];
expCW = expCW*RotZ;
expCCW = expCCW*RotZ;
% expCW(:,1) = -1*expCW(:,1);
% figure
% plot3(analCW(:,1),-analCW(:,2),analCW(:,3),'r*');
% axis equal
% grid on
% hold on
% xlabel 'X'
% ylabel 'Y'
% zlabel 'Z'
% 
% 
% plot3(expCW(:,1),expCW(:,2),expCW(:,3),'g*');
% plot3(expCCW(:,1),expCCW(:,2),expCCW(:,3),'g*');
% plot3(-analCW(:,1),-analCW(:,2),analCW(:,3),'r*');

ED_expCW = expCW - [0 0 .31];
ED_expCCW = expCCW - [0 0 .31];
% Euclidean_dist = sqrt(cumsum(Euclidean_dist.^2,2));
% Euclidean_dist = Euclidean_dist(:,3)/1000;
ED_expCW = sqrt(cumsum(ED_expCW.^2,2));
ED_expCW = ED_expCW(:,3);

ED_expCCW = sqrt(cumsum(ED_expCCW.^2,2));
ED_expCCW = ED_expCCW(:,3);

errorCW=abs(expCW)-abs(analCW);

errorCW = sqrt(cumsum(errorCW.^2,2));

errorCW = errorCW(:,3)-.009525;% reducing by dia of one actuator


errorCCW=abs(expCCW)-abs(analCW);
errorCCW = sqrt(cumsum(errorCCW.^2,2));

errorCCW = errorCCW(:,3)-.009525; % reducing by dia of one actuator

% plot(loads,errorCW*100,'--s', 'Color',[63 0 125]/256,'LineWidth',2,...
%     'MarkerEdgeColor',[217 95 14]/256,...
%     'MarkerFaceColor',[217 95 14]/256);

plot(loads,errorCW./ED_expCW,'--s', 'Color',[63 0 125]/256,'LineWidth',2,...
    'MarkerEdgeColor',[217 95 14]/256,...
    'MarkerFaceColor',[217 95 14]/256);
hold on
% plot(loads,errorCCW*100,'--o','Color',[217 95 14]/256,'LineWidth',2,...
%     'MarkerEdgeColor',[63 0 125]/256,...
%     'MarkerFaceColor',[63 0 125]/256)

plot(loads,errorCCW./ED_expCCW,'--o','Color',[217 95 14]/256,'LineWidth',2,...
    'MarkerEdgeColor',[63 0 125]/256,...
    'MarkerFaceColor',[63 0 125]/256)

legend('CW','CCW')
xlabel ('End load (in gms)','FontSize',12,'FontWeight','bold')
% ylabel ('Error (in cm)','FontSize',12,'FontWeight','bold')
ylabel ('Error metric','FontSize',12,'FontWeight','bold')
xlim([3 30])
set(gca,'linewidth',1,'FontSize',12)

grid on
font_size = 12;
f_width = 4.5;
f_height = 4.5;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])

    

 %% Plots for validation
 clear all
 close all
 load Anal_3gms.mat;
 load Exp_3gms.mat;
 Exp_3gms = [Exp_3gms_rot(:,2) Exp_3gms_rot(:,1) Exp_3gms_rot(:,3)];
% plot3(abs(end_position(:,3)),abs(end_position(:,4)),abs(end_position(:,5)),'r*');
% hold on
% plot3(abs(Exp_3gms(:,1)/1000),abs(Exp_3gms(:,2)/1000),abs(Exp_3gms(:,3)/1000),'g*')
% axis equal
% grid on
% xlabel 'X'
% ylabel 'Y'
% zlabel 'Z'

Euclidean_dist = Exp_3gms - [ 0 0 310] ;
Euclidean_dist = sqrt(cumsum(Euclidean_dist.^2,2));
Euclidean_dist = Euclidean_dist(:,3)/1000;

error = abs(end_position(:,3:5)) - abs(Exp_3gms/1000);

error = sqrt(cumsum(error.^2,2));

error = error(:,3)-9.525e-3;

error(error<0) = 0.000;

edges = [ 0:0.1:.7];

% divided by euclidean distance
hist1 = histogram(error./Euclidean_dist,edges,'FaceColor',[28 144 153]/256);
hist1.NumBins = 7;
hist1.FaceAlpha = 0.8;

xlabel ('Error metric','FontSize',12,'FontWeight','bold')
ylabel ('Count','FontSize',12,'FontWeight','bold')
xlim([0 .7])
set(gca,'linewidth',1,'FontSize',12)


font_size = 12;
f_width = 4;
f_height = 4;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])

 


%% 

 clear all
 close all
 load Anal_3gms.mat;
 load Exp_3gms.mat;
 
 
 plot3(Exp_3gms_rot(:,2)/1000,-Exp_3gms_rot(:,1)/1000,Exp_3gms_rot(:,3)/1000,'cs');
 hold on
 plot3(end_position(:,3),end_position(:,4),end_position(:,5),'g*')
 axis equal
 grid on
 
    



    

    

    

    
    








