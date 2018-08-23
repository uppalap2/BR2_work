% close all
% test = [54.5499 55.8015 549.8436
% 54.5058 57.4169 487.4019
% 54.0323 57.8753 428.2574
% 53.8919 55.6791 364.9993
% 53.8906 51.3624 306.1005
% 53.1169 43.5819 245.3116
% 54.9143 32.4311 188.6282
% 55.1964 21.8880 150.1613
% ];
% 
% test = (test-test(1,:))*1e-3;
% 
% plot3(test(:,1),test(:,2),test(:,3),'ro')
% axis equal

%%
clearvars
clc
clear all

folder = 'data with end weight\';
filename = '6_0.txt';

data = zeros(25,8,3);

data(1,:,:) = importdata(strcat(folder,filename));

P1 = 6:6:30;
P2 = 0:4:16;
k=1;
for i = 1:size(P1,2)
    for j = 1:size(P2,2)
        filename = strcat(num2str(P1(i)),'_',num2str(P2(j)),'.txt');
        filename
        temp = importdata(strcat(folder,filename));
        data(k,1:size(temp,1),1:size(temp,2)) = temp;
        k = k+1;
    end
end

hold on
grid on
axis equal
Rz = rotz(-4);
PosEndExp = zeros(25,3);
for i=1:25
    exp_data = squeeze(data(i,:,:))*1e-3;
    exp_data(:,1) = exp_data(:,1)-exp_data(1,1);
    exp_data(:,2) = exp_data(:,2)-exp_data(1,2);
    exp_data(:,3) = exp_data(:,3)-exp_data(1,3);
    exp_data = (Rz*exp_data')';
%     plot3(exp_data(:,1),exp_data(:,2),exp_data(:,3),'b.')
    PosEndExp(i,:) =  [exp_data(end,1),exp_data(end,2),exp_data(end,3)];
    plot3(exp_data(end,1),exp_data(end,2),exp_data(end,3),'k*')
%     pause(.01)
end
xlabel('X')
ylabel('Y')
zlabel('Z')

plot3(0,0,0,'r*')
save('PosEndExp1.mat','PosEndExp')
% hold on
% grid on
% axis equal
% Rz = rotz(-11);
% for j = [1,2,7,12,17,22]
%     data1 = squeeze(data(j,:,:));
%     data1(:,1) = data1(:,1)-data1(1,1);
%     data1(:,2) = data1(:,2)-data1(1,2);
%     data1(:,3) = data1(:,3)-data1(1,3);
%     data1 = (Rz*data1')';
%     plot3(data1(:,1),data1(:,2),data1(:,3),'o')
% end