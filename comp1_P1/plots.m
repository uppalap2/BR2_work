% ploting the mesh values for the parameters
close all
clf
P_b = 6:6:30;
P_r = 0:4:16;
[P_B,P_R] = meshgrid(P_b,P_r);

option = 2; % 1 for fit data 2 for interpolated mesh

% % Plots with first obj function and constraints on last 5 points and
% orientation

% EI
figure (1)
EI = [.0054 .0124 .0139 .0139 .0139;
    .0079 .0156 .0146 .0139 .0146;
    .0181 .0158 .0153 .0139 .0180;
    .0181 .0229 .0160 .0139 .0146;
    NaN .0287 .0160 .0139 .0143];

if option == 1
surf(P_B,P_R,EI)
xlabel ' Bending pressure (in psi)'
ylabel ' Rotating pressure (in psi)'
zlabel 'EI'

else
P_b_q = 6:1:30;
P_r_q = 0:1:16;
[P_B_q,P_R_q] = meshgrid(P_b_q,P_r_q);

EIq = interp2(P_B,P_R,EI,P_B_q,P_R_q);

surf(P_B_q,P_R_q,EIq)
xlabel ('P_B (in psi)','fontweight','bold','fontsize',18,'Interpreter','tex')
ylabel (' P_R (in psi)','fontweight','bold','fontsize',18)
zlabel 'EI'
h = colorbar;
h.Location = 'northoutside';
title(h,'EI','fontweight','bold','fontsize',18)
axis tight
view(0,90)
colormap(linspecer); % linspecer colormap
set(gca,'linewidth',2,'FontSize',18)
set(gcf, 'Position', [100, 100, 600, 600])
xticks(6:6:30)
yticks(0:4:16)
end

% GJ
figure(2)
GJ = [.0035 .0063 .0064 .0064 NaN; .0083 .0106 .0108 .0163 .0168; .0120 .0158 .0160 .0164 .0164;...
    .0120 .02346 .0333 .0333 .0333; .0120 .0154 .0315 .0120 .0171]';
if option ==1

surf(P_B,P_R,GJ)
xlabel ' Bending pressure (in psi)'
ylabel ' Rotating pressure (in psi)'
zlabel 'GJ'

else
GJq = interp2(P_B,P_R,GJ,P_B_q,P_R_q);

surf(P_B_q,P_R_q,GJq)
xlabel ('P_B (in psi)','fontweight','bold','fontsize',18,'Interpreter','tex')
ylabel (' P_R (in psi)','fontweight','bold','fontsize',18)
zlabel 'GJ'
h = colorbar;
h.Location = 'northoutside';
title(h,'GJ','fontweight','bold','fontsize',18)
axis tight
view(0,90)
colormap(linspecer); % linspecer colormap
set(gca,'linewidth',2,'FontSize',18)
set(gcf, 'Position', [100, 100, 600, 600])
xticks(6:6:30)
yticks(0:4:16)
end


% Curvature

figure(3)
kappa = [1.4 1.3154 .9874 .9874 NaN; 2.6 2.2885 2.1653 1.8083 1.8083;4.3 4.0920 3.9166 3.6220 3.5063 ;...
    6.4 6.2097 6.1041 5.8711 5.4834; 8.5 7.8736 7.4028 7.3519 6.9654]';

if option ==1
surf(P_B,P_R,kappa)
xlabel ' Bending pressure (in psi)'
ylabel ' Rotating pressure (in psi)'
zlabel 'Curvature'

else
kappaq = interp2(P_B,P_R,kappa,P_B_q,P_R_q);

surf(P_B_q,P_R_q,kappaq)
xlabel ('P_B (in psi)','fontweight','bold','fontsize',18,'Interpreter','tex')
ylabel (' P_R (in psi)','fontweight','bold','fontsize',18)

h = colorbar;
h.Location = 'northoutside';
title(h,'\kappa','fontweight','bold','fontsize',20,'Interpreter','tex')
axis tight
view(0,90)
colormap(linspecer); % linspecer colormap
set(gca,'linewidth',2,'FontSize',18)
set(gcf, 'Position', [100, 100, 600, 600])

colormap(linspecer); % linspecer colormap
axis tight
xticks(6:6:30)
yticks(0:4:16)
end
% torsion

figure(4)
tau = [0 1.8184 4.9246 8.2299  NaN; 0 1.6716 3.7348 6.5055 10.6213;0 1.4587 3.0717 5.2688 8.6896 ;...
    0 1.7175 2.9330 4.7780 7.6115; 0 1.6226 3.2180 4.4412 7.1937]';

if option == 1
surf(P_B,P_R,tau)
xlabel ' Bending pressure (in psi)'
ylabel ' Rotating pressure (in psi)'
zlabel 'Torsion'

else
tauq = interp2(P_B,P_R,tau,P_B_q,P_R_q);

surf(P_B_q,P_R_q,tauq)
xlabel ('P_B (in psi)','fontweight','bold','fontsize',18,'Interpreter','tex')
ylabel (' P_R (in psi)','fontweight','bold','fontsize',18)

h = colorbar;
h.Location = 'northoutside';
title(h,'\tau','fontweight','bold','fontsize',20,'Interpreter','tex')

axis tight
view(0,90)
colormap(linspecer); % linspecer colormap
set(gca,'linewidth',2,'FontSize',18)
set(gcf, 'Position', [100, 100, 600, 600])


colormap(linspecer); % linspecer colormap
axis tight
xticks(6:6:30)
yticks(0:4:16)

end


%% plots for difference in workspace with and without load
load PosEndMat_15gms
load PosEndMat_0g
load PosEndMat_0g_0sw
sel = [1 3 5 6 8 10 11 12 15 16 18 20 21 23 25];
plot3(PosEndMat_0g_0sw(sel,1),PosEndMat_0g_0sw(sel,2),PosEndMat_0g_0sw(sel,3),'ko','MarkerFaceColor','red');
hold on
axis equal
plot3(PosEndMat_0g(sel,1),PosEndMat_0g(sel,2),PosEndMat_0g(sel,3),'ko','MarkerFaceColor','green');
axis equal
grid on
plot3(PosEndMat_15g(sel,1),PosEndMat_15g(sel,2),PosEndMat_15g(sel,3),'ko','MarkerFaceColor','blue');
% plot3(0,0,0,'ko','MarkerFaceColor','green')
legend('No Forces','SW','SW + EL');
axis equal
set(gca,'linewidth',2,'FontSize',14)
xlabel ('X(in m)','fontweight','bold')
ylabel ('Y(in m)','fontweight','bold')
zlabel ('Z(in m)','fontweight','bold')
set(gcf, 'Position', [100, 100, 600, 600])