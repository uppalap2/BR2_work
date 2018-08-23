load 'PosEndMat1.mat'
load 'PosEndExp1.mat'
clf
close all

% error = cumsum(sqrt((PosEndMat-PosEndExp).^2),2);

errorTip = sqrt(cumsum((PosEndMat1-PosEndExp).^2,2));
errorTip = errorTip(:,3)-3e-3;
errorLength = (errorTip)/41e-2;
nanmean(errorTip)
nanmean(errorLength)

edges = [0:1:6];
N= 15;
C = linspecer(N);
h = histogram(errorTip*100,edges,'faceColor',C(2,:))
xlabel('Tip Error(in cm)','fontweight','bold','fontsize',14)
ylabel('Occurences','fontweight','bold','fontsize',14)
set(gca,'linewidth',2,'FontSize',14)


% position plotting

figure
PosEndMat = PosEndMat*100;
PosEndExp = PosEndExp*100;
h1 = plot3(PosEndMat(:,1),PosEndMat(:,2),PosEndMat(:,3),'ko','MarkerFaceColor','red');
hold on
h2 = plot3(PosEndExp(:,1),PosEndExp(:,2),PosEndExp(:,3),'ko','MarkerFaceColor','blue');
plot3(0,0,0,'ko','MarkerFaceColor','green')
axis equal
grid on
xlabel('X (in cm)','fontweight','bold','fontsize',14)
ylabel('Y (in cm)','fontweight','bold','fontsize',14)
set(gca,'linewidth',2,'FontSize',12)
h3 = legend('Analysis','Experiment','Origin','Location','North')
view(90,90)
set(gcf, 'Position', [100, 100, 800, 800])
%%
figure
load 'PosEndMat1.mat'
load 'PosEndExp1.mat'

errorTip = sqrt(cumsum((PosEndMat1-PosEndExp).^2,2));
errorTip = errorTip(:,3)-3e-3;
nanmean(errorTip)
errorTip = reshape(errorTip,5,5);
P_b = 6:6:30;
P_r = 0:4:16;
[P_B,P_R] = meshgrid(P_b,P_r);

surf(P_B,P_R,errorTip*100)
xlabel ('P_B (in psi)','fontweight','bold','fontsize',14,'Interpreter','tex')
ylabel (' P_R (in psi)','fontweight','bold','fontsize',14)
zlabel 'Tip Error(in cm)'
h = colorbar;
h.Location = 'northoutside';
title(h,'Error (in cm)','fontweight','bold','fontsize',14)
axis tight
view(0,90)
colormap(linspecer); % linspecer colormap
set(gca,'linewidth',2,'FontSize',14)
set(gcf, 'Position', [100, 100, 650, 650])
xticks(6:6:30)
yticks(0:4:16)

