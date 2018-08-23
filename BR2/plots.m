% ploting the mesh values for the parameters
close all
clf
P_b = 5:5:25;
P_r = 0:6:30;
[P_B,P_R] = meshgrid(P_b,P_r);

option = 2; % 1 for fit data 2 for interpolated mesh

% % Plots with first obj function and constraints on last 5 points and
% orientation

% EI
figure (1)
EI = [.0548 .0555 .0548 .0548 .0548 .0561;
    .0325 .0479 .0483 .0488 .0489 .0488;
    .0356 .0456 .0456 .0464 .0464 .0464;
    .0255 .0869 .0617 .0637 .0653 .0653;
    .0184 .0222 .0207 .0191 .0184 .0184]';

if option == 1
surf(P_B,P_R,EI)
xlabel ' Bending pressure (in psi)'
ylabel ' Rotating pressure (in psi)'
zlabel 'EI'

else
P_b_q = 5:1:25;
P_r_q = 0:1:30;
[P_B_q,P_R_q] = meshgrid(P_b_q,P_r_q);

EIq = interp2(P_B,P_R,EI,P_B_q,P_R_q);

surf(P_B_q,P_R_q,EIq)
xlabel ('P_B (in psi)','fontweight','bold','fontsize',18,'Interpreter','tex')
ylabel (' P_R (in psi)','fontweight','bold','fontsize',18)
zlabel 'EI'
h = colorbar;
h.Location = 'northoutside';
title(h,'P2 EI','fontweight','bold','fontsize',18)
axis tight
view(0,90)
colormap(linspecer); % linspecer colormap
set(gca,'linewidth',2,'FontSize',18)
set(gcf, 'Position', [100, 100, 400, 400])
xticks(5:5:25)
yticks(0:6:30)
end

% GJ
figure(2)
GJ = [.0120 .0121 .0120 .0120 .0120 .0125;
    .0120 .0161 .0174 .0180 .0174 .0175;
    .0120 .0121 .0120 .0121 .0121 .0121;
    .0129 .0222 .0282 .0235 .0223 .0223;
    .0120 .0344 .0130 .0136 .0142 .0136]';
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
title(h,'P2 GJ','fontweight','bold','fontsize',18)
axis tight
view(0,90)
colormap(linspecer); % linspecer colormap
set(gca,'linewidth',2,'FontSize',18)
set(gcf, 'Position', [100, 100, 400, 400])
xticks(5:5:25)
yticks(0:6:30)
end


% Curvature

figure(3)
kappa = [1.2 .9962 .8702 .7814 .7762 .6691; 2.45 1.9540 1.8235 1.7053 1.5603 1.3200;
    3.6 3.1356 3.0071 2.777 2.5653 2.3336; 5.5 3.8947 3.833 3.7095 3.5031 3.2069;
    7.7 7.0679 6.9896 6.9126 6.8189 6.4957]';

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
title(h,'P2 \kappa','fontweight','bold','fontsize',20,'Interpreter','tex')
axis tight
view(0,90)
colormap(linspecer); % linspecer colormap
set(gca,'linewidth',2,'FontSize',18)
set(gcf, 'Position', [100, 100, 400, 400])

colormap(linspecer); % linspecer colormap
axis tight
xticks(5:5:25)
yticks(0:6:30)
end
% torsion

figure(4)
tau = [0 1.8609 2.9799 4.4 6.2898 7.8757; 0 1.0904 1.8170 2.7243 3.9136 6.3420;
    0 .7049 1.2836 2.0044 3.1688 4.4265;0 .4820 1.0818 1.7544 2.4789 3.7804;
    0 .1405 .6 1.3355 1.9822 2.8985]';

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
title(h,'P2 \tau','fontweight','bold','fontsize',20,'Interpreter','tex')

axis tight
view(0,90)
colormap(linspecer); % linspecer colormap
set(gca,'linewidth',2,'FontSize',18)
set(gcf, 'Position', [100, 100, 400, 400])

colormap(linspecer); % linspecer colormap
axis tight
xticks(5:5:25)
yticks(0:6:30)

end


% %% plots for difference in workspace with and without load
% load PosEndMat_15gms
% load PosEndMat_0g
% load PosEndMat_0g_0sw
% sel = [1 3 5 6 8 10 11 12 15 16 18 20 21 23 25];
% plot3(PosEndMat_0g_0sw(sel,1),PosEndMat_0g_0sw(sel,2),PosEndMat_0g_0sw(sel,3),'ko','MarkerFaceColor','red');
% hold on
% axis equal
% plot3(PosEndMat_0g(sel,1),PosEndMat_0g(sel,2),PosEndMat_0g(sel,3),'ko','MarkerFaceColor','green');
% axis equal
% grid on
% plot3(PosEndMat_15g(sel,1),PosEndMat_15g(sel,2),PosEndMat_15g(sel,3),'ko','MarkerFaceColor','blue');
% % plot3(0,0,0,'ko','MarkerFaceColor','green')
% legend('No Forces','SW','SW + EL');
% axis equal
% set(gca,'linewidth',2,'FontSize',14)
% xlabel ('X(in m)','fontweight','bold')
% ylabel ('Y(in m)','fontweight','bold')
% zlabel ('Z(in m)','fontweight','bold')
% set(gcf, 'Position', [100, 100, 600, 600])