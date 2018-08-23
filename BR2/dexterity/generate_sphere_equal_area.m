%% equal area patches of a sphere

%% http://notmatthancock.github.io/2017/12/26/regular-area-sphere-partitioning.html
clear all
n = 15;% latitude (h/2 in paper)
r = 1;
m = 60;% longitude (theta in paper)
t = linspace(0,2*pi,m);
delta_theta = t(2)-t(1);
delta_S = delta_theta/n;

p = 1 - (0:1:2*n)*delta_S/(r^2*delta_theta);

p = acos(p);

[theta,phi] = meshgrid(t,p);
% phi is h and theta is theta in paper
k = 1;
% for i = 1:numel(theta)
%     for j = 1:numel(phi)
%     x(k) = cos(theta(i))*sin(phi(j));
%     y(k) = sin(theta(i))*sin(phi(j));
%     z(k) = cos(phi(j));
%     k = k+1;
%     end
% end

for i = 1:numel(t)
    for j = 1:numel(p)
    x(k) = cos(t(i))*sin(p(j));
    y(k) = sin(t(i))*sin(p(j));
    z(k) = cos(p(j));
    k = k+1;
    end
end

% figure
% fill3(x,y,z,[1 1 1])

% view(3)


x = reshape(x,[length(p),length(t)]);
y = reshape(y,[length(p),length(t)]);
z = reshape(z,[length(p),length(t)]);
c = ones(length(p),length(t),3);
load orientations.mat
% cords = [max_point_orientations(:,4) max_point_orientations(:,3)];
c(max_point_orientations(:,4), max_point_orientations(:,3),1) = 231/256 ;
c(max_point_orientations(:,4), max_point_orientations(:,3),2) = 41/256 ;
c(max_point_orientations(:,4), max_point_orientations(:,3),3) = 138/256 ;

% load orientations1.mat
% % cords = [max_point_orientations(:,4) max_point_orientations(:,3)];
% c(max_point_orientations2(:,4), max_point_orientations2(:,3),1) = 231/256 ;
% c(max_point_orientations2(:,4), max_point_orientations2(:,3),2) = 41/256 ;
% c(max_point_orientations2(:,4), max_point_orientations2(:,3),3) = 138/256 ;


surf(x,y,z,c)

axis equal
grid off

% view(0,0)% XZ view
view(90,0)% YZ view
xlabel ('X','FontSize',12,'FontWeight','bold')
ylabel ('Y','FontSize',12,'FontWeight','bold')
zlabel ('Z','FontSize',12,'FontWeight','bold')
set(gca,'linewidth',2,'FontSize',12)


font_size = 12;
f_width = 3;
f_height = 3;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])
