
% For Prototype 2
clear all
clearvars
clc

folder = 'P2\';

filename = '0_0.txt';

data = zeros(31,6,3);

data(1,:,:) = importdata(strcat(folder,filename));

P1 = 5:5:25;
P2 = 0:6:30;
k=2;
for i = 1:size(P1,2)
    for j = 1:size(P2,2)
        filename = strcat(num2str(P1(i)),'_',num2str(P2(j)),'.txt');
        filename
        temp = importdata(strcat(folder,filename));
        data(k,1:size(temp,1),1:size(temp,2)) = temp;
        k = k+1;
    end
end

% hold on
% grid on
% axis equal
Rz = rotz(10);
endpoint = zeros(31,3);
% figure
for i=1:31
    exp_data = squeeze(data(i,:,:));
    exp_data(:,1) = exp_data(:,1)-exp_data(1,1);
    exp_data(:,2) = exp_data(:,2)-exp_data(1,2);
    exp_data(:,3) = exp_data(:,3)-exp_data(1,3);
    exp_data = (Rz*exp_data')';
    endpoint(i,:) = [exp_data(end,1),exp_data(end,2),exp_data(end,3)];
%     plot3(exp_data(:,1),exp_data(:,2),exp_data(:,3),'o')
%     pause(1)
end
% xlabel('X')
% ylabel('Y')
% zlabel('Z')
% 
% 
% hold on
% grid on
% axis equal

%% plot workspace
% figure 
% 
% endpoint = resample(endpoint,3,2);
tri = delaunay(endpoint(:,1),endpoint(:,2));
% plot(endpoint(:,1),endpoint(:,2),'.')

%
% How many triangles are there?

[r,c] = size(tri);
disp(r)

% will remove some unneeded traingles
tri([7,35,40,48],:)=[];

h = trisurf(tri, endpoint(:,1),endpoint(:,2),endpoint(:,3),'facecolor','m');
axis vis3d

% Calculate surface area



v1 = endpoint(tri(:,2),:)-endpoint(tri(:,1),:);
v2 = endpoint(tri(:,3),:)-endpoint(tri(:,2),:);

cp = .5*cross(v1,v2);

surfaceArea = sum(sqrt(dot(cp,cp,2)))