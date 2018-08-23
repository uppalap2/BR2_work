
clf  
endpoints  = zeros(26,3);% for endpoints alone
for  sheet = [1:26]
  
%  sheet = [1 2:5:22]   
% sheet = [2 7 12 17 22 27];

exp_data = xlsread('data_P1.xlsx',sheet);
exp_data = exp_data - exp_data(1,:);
exp_data(:,3) = -exp_data(:,3);
% plot3(exp_data(:,1),exp_data(:,2),exp_data(:,3))
theta  = -20; % angle rotation in degrees
rotZ = [cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1]; % about z axis
exp_data = exp_data * rotZ;
fnplt(cscvn(exp_data(:,[1:end])'))
endpoints(sheet,:) = exp_data(end,:);
axis equal
hold on
end
grid on
% save('P1_30_16.mat','exp_data')
% save('endpoints_P1.mat','endpoints')% saving end points


