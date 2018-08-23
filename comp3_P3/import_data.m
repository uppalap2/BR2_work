

% For Prototype 3
clear all
clearvars
clc

folder = 'P3\';

filename = '0_0.txt';

data = zeros(25,6,3);

data(1,:,:) = importdata(strcat(folder,filename));

P1 = 4:4:16;
P2 = 0:8:40;
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

% figure
Rz = rotz(0);
endpoint = zeros(25,3);
for i=1:25
    exp_data = squeeze(data(i,:,:));
    exp_data(:,1) = exp_data(:,1)-exp_data(1,1);
    exp_data(:,2) = exp_data(:,2)-exp_data(1,2);
    exp_data(:,3) = exp_data(:,3)-exp_data(1,3);
    exp_data = (Rz*exp_data')';
%     plot3(exp_data(:,1),exp_data(:,2),exp_data(:,3),'o')
    endpoint(i,:) = [exp_data(end,1),exp_data(end,2),exp_data(end,3)];
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

% plot(endpoint(:,1),endpoint(:,2),'.')
tri = delaunay(endpoint(:,1),endpoint(:,2));

% % How many triangles are there?

[r,c] = size(tri);
disp(r)

% will remove some unneeded traingles
tri([3,14,16,31,39],:)=[];

h = trisurf(tri, endpoint(:,1),endpoint(:,2),endpoint(:,3),'facecolor','c');
axis vis3d

%% Calculate surface area

% surface_area=0;
%  for i=1:length(tri)
%      i
%      P1 = endpoint(tri(i,1),:); 
%      P2 = endpoint(tri(i,2),:);
%      P3 = endpoint(tri(i,3),:);
%      AreaP1P2P3 = 1/2*norm(cross(P2-P1,P3-P1))
%      surface_area = surface_area+AreaP1P2P3;
%  end

 v1 = endpoint(tri(:,2),:)-endpoint(tri(:,1),:);
v2 = endpoint(tri(:,3),:)-endpoint(tri(:,2),:);

cp = .5*cross(v1,v2);

surfaceArea = sum(sqrt(dot(cp,cp,2)))