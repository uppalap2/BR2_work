%% plot for Whole arm manipulation

load 'WAMPb_18.mat'
load 'WAMPb_21.mat'
load 'WAMPb_24.mat'
load 'WAMPb_27.mat'

plot(Pb_18(:,3),Pb_18(:,4)*1e3,'--ko',...
    Pb_21(:,3),Pb_21(:,4)*1e3,'--ks',...
    Pb_24(:,3),Pb_24(:,4)*1e3,'--kd',...
    Pb_27(:,3),Pb_27(:,4)*1e3,'--kp',...
    'linewidth',1.5,'Markersize',8,'MarkerFaceColor','black')

xlabel(' Rotating pressure (in psi)')
ylabel('Radius of object (in mm)')
legend('18 psi','21 psi','24 psi','24 psi')
set(gca,'linewidth',2,'FontSize',12)


font_size = 12;
f_width = 3.5;
f_height = 3.5;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])
