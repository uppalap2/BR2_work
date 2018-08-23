% ploting the mesh values for the parameters
close all
clf
P_b = 4:4:16;
P_r = 0:8:40;
[P_B,P_R] = meshgrid(P_b,P_r);

option = 2; % 1 for fit data 2 for interpolated mesh

% % Plots with first obj function and constraints on last 5 points and
% orientation

% EI
figure (1)
EI = [.0254 .0397 .0253 .0164; 
    .0299 .0878 .0635 .0214;
    .0538 .0327 .0628 0.0218;
    .0412 .0612 .0631 .0217;
    .0340 .0513 .0604 .0222;
    .0254 .0528 .0540 .0214];

if option == 1
surf(P_B,P_R,EI)
xlabel ' Bending pressure (in psi)'
ylabel ' Rotating pressure (in psi)'
zlabel 'P3 EI'

else
P_b_q = 4:1:16;
P_r_q = 0:2:40;
[P_B_q,P_R_q] = meshgrid(P_b_q,P_r_q);

EIq = interp2(P_B,P_R,EI,P_B_q,P_R_q);

surf(P_B_q,P_R_q,EIq)
xlabel ('P_B (in psi)','fontweight','bold','fontsize',18,'Interpreter','tex')
ylabel (' P_R (in psi)','fontweight','bold','fontsize',18)
zlabel 'EI'
h = colorbar;
h.Location = 'northoutside';
title(h,'P3 EI','fontweight','bold','fontsize',18)
axis tight
view(0,90)
colormap(linspecer); % linspecer colormap
set(gca,'linewidth',2,'FontSize',18)
set(gcf, 'Position', [10, 10, 400, 400])
xticks(4:4:16)
yticks(0:8:40)
end

% GJ
figure(2)
GJ = [.0122 .0122 .0122 .0122 .0122 0.0122; .0122 .0178 .0123 .0219 .0123 .0123; .0136 .0239 .0239 .0180 .0245 .0158;
    .0122 .0124 .0123 .0123 .0173 .0314]';
if option ==1

surf(P_B,P_R,GJ)
xlabel ' Bending pressure (in psi)'
ylabel ' Rotating pressure (in psi)'
zlabel 'P3 GJ'

else
GJq = interp2(P_B,P_R,GJ,P_B_q,P_R_q);

surf(P_B_q,P_R_q,GJq)
xlabel ('P_B (in psi)','fontweight','bold','fontsize',18,'Interpreter','tex')
ylabel (' P_R (in psi)','fontweight','bold','fontsize',18)
zlabel 'GJ'
h = colorbar;
h.Location = 'northoutside';
title(h,'P3 GJ','fontweight','bold','fontsize',18)
axis tight
view(0,90)
colormap(linspecer); % linspecer colormap
set(gca,'linewidth',2,'FontSize',18)
set(gcf, 'Position', [10, 10, 400, 400])
xticks(4:4:16)
yticks(0:8:40)
end


% Curvature

figure(3)
kappa = [ 1.7 1.7 1.2727 1.3 1.3 1.4; 2.5 2.1026 2.4861 2.2068 2.200 2.1916; 4.5 3.3147 3.3147 3.3147 3.3147 3.3147;
    6.8 6.4547 6.4547 6.4547 6.4547 6.4547]';

if option ==1
surf(P_B,P_R,kappa)
xlabel ' Bending pressure (in psi)'
ylabel ' Rotating pressure (in psi)'
zlabel 'P3 Curvature'

else
kappaq = interp2(P_B,P_R,kappa,P_B_q,P_R_q);

surf(P_B_q,P_R_q,kappaq)
xlabel ('P_B (in psi)','fontweight','bold','fontsize',18,'Interpreter','tex')
ylabel (' P_R (in psi)','fontweight','bold','fontsize',18)

h = colorbar;
h.Location = 'northoutside';
title(h,' P3 \kappa','fontweight','bold','fontsize',20,'Interpreter','tex')
axis tight
view(0,90)
colormap(linspecer); % linspecer colormap
set(gca,'linewidth',2,'FontSize',18)
set(gcf, 'Position', [10, 10, 400, 400])

colormap(linspecer); % linspecer colormap
axis tight
xticks(4:4:16)
yticks(0:8:40)
end
% torsion

figure(4)
tau = [0 .2895 1.0709 2.0852 3.0924 4.2198; 0 .4358 .9424 1.6294 2.4428 3.5937; 0 .3381 .661 1.2199 2.0630 3.1591;
    0 .1552 .3960 .9327 1.8147 3.0]';

if option == 1
surf(P_B,P_R,tau)
xlabel ' Bending pressure (in psi)'
ylabel ' Rotating pressure (in psi)'
zlabel 'P3 Torsion'

else
tauq = interp2(P_B,P_R,tau,P_B_q,P_R_q);

surf(P_B_q,P_R_q,tauq)
xlabel ('P_B (in psi)','fontweight','bold','fontsize',18,'Interpreter','tex')
ylabel (' P_R (in psi)','fontweight','bold','fontsize',18)

h = colorbar;
h.Location = 'northoutside';
title(h,'P3 \tau','fontweight','bold','fontsize',20,'Interpreter','tex')

axis tight
view(0,90)
colormap(linspecer); % linspecer colormap
set(gca,'linewidth',2,'FontSize',18)
set(gcf, 'Position', [10, 10, 400, 400])

colormap(linspecer); % linspecer colormap
axis tight
xticks(4:4:16)
yticks(0:8:40)

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