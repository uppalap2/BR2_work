
clf  
endpoints = zeros(26,3);
for  sheet = [1:1:16]
%  sheet = [1:1:26]   
% sheet = [2 7 12 17 22 27];

exp_data = xlsread('data_P2.xlsx',sheet);
exp_data = exp_data - exp_data(1,:);
exp_data(:,3) = -exp_data(:,3);
% plot3(exp_data(:,1),exp_data(:,2),exp_data(:,3))
thetay  =-16; % angle rotation in degrees
thetax = 17;
thetaz = -10;
rotX = [1 0 0 ;0 cosd(thetax) -sind(thetax); 0 sind(thetax) cosd(thetax) ];
rotY = [cosd(thetay) 0 -sind(thetay); 0 1 0 ; -sind(thetay) 0 cosd(thetay) ];
rotZ = [cosd(thetaz) -sind(thetaz) 0; sind(thetaz) cosd(thetaz) 0; 0 0 1]; % about z axis
exp_data = exp_data * rotY *rotX *rotZ;
fnplt(cscvn(exp_data(:,[1:end])'))
endpoints(sheet,:) = exp_data(end,:);
axis equal
hold on
end
grid on

for  sheet = 23 %[17 :1 :26] 
  
%  sheet = [1:1:26]   
% sheet = [2 7 12 17 22 27];

exp_data = xlsread('data_P2.xlsx',sheet);
exp_data = exp_data - exp_data(1,:);
exp_data(:,3) = -exp_data(:,3);
% plot3(exp_data(:,1),exp_data(:,2),exp_data(:,3))
thetax = 0; thetay = 0;
thetaz =-10;

rotX = [1 0 0 ;0 cosd(thetax) -sind(thetax); 0 sind(thetax) cosd(thetax) ];
rotY = [cosd(thetay) 0 -sind(thetay); 0 1 0 ; -sind(thetay) 0 cosd(thetay) ];
rotZ = [cosd(thetaz) -sind(thetaz) 0; sind(thetaz) cosd(thetaz) 0; 0 0 1]; % about z axis
exp_data = exp_data * rotZ;
fnplt(cscvn(exp_data(:,[1:end])'))
endpoints(sheet,:) = exp_data(end,:);
axis equal
hold on
end
grid on
save('P2_30_16.mat','exp_data')
% save('endpoints_P2.mat','endpoints')