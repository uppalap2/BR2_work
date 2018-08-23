% For Prototype 1
close all

clearvars
clc

folder = 'Microscribe data for fitting\';

filename = '0_0.txt';

data = zeros(26,15,3);

data(1,:,:) = importdata(strcat(folder,filename));

P1 = 6:6:30;
P2 = 0:4:16;
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

hold on
grid on
axis equal
endpoint = zeros(26,3);
Rz = rotz(-11);
for i=1:26
    exp_data = squeeze(data(i,:,:));
    exp_data(:,1) = exp_data(:,1)-exp_data(1,1);
    exp_data(:,2) = exp_data(:,2)-exp_data(1,2);
    exp_data(:,3) = exp_data(:,3)-exp_data(1,3);
    exp_data = (Rz*exp_data')';
   
    if i==11 || i==6
         endpoint(i,:) = [exp_data(end-1,1),exp_data(end-1,2),exp_data(end-1,3)];%one less data point in 12-16
%          plot3(exp_data(1:end-1,1),exp_data(1:end-1,2),exp_data(1:end-1,3),'o')
    else
        endpoint(i,:) = [exp_data(end,1),exp_data(end,2),exp_data(end,3)];
%          plot3(exp_data(:,1),exp_data(:,2),exp_data(:,3),'o')
    end
end
xlabel('X')
ylabel('Y')
zlabel('Z')


%% Workspace ploting

option = 2;
if option == 1 % 2 for reduced workspace
    
% plot full workspace
figure 
tri = delaunay(endpoint(:,1),endpoint(:,2));
plot(endpoint(:,1),endpoint(:,2),'.')

%
% How many triangles are there?

[r,c] = size(tri);
disp(r)

% will remove some unneeded traingles
tri([25,33,39,41],:)=[];
% Plot it with TRISURF

h = trisurf(tri, endpoint(:,1),endpoint(:,2),endpoint(:,3));
axis vis3d

%% Calculate surface area

surface_area=0;
 for i=1:length(tri)
     i
     P1 = endpoint(tri(i,1),:); 
     P2 = endpoint(tri(i,2),:);
     P3 = endpoint(tri(i,3),:);
     AreaP1P2P3 = 1/2*norm(cross(P2-P1,P3-P1))
     surface_area = surface_area+AreaP1P2P3;
 end
 
 %% reduced workspace for comparison
 else 
 red = [1:5 7:10 12:15 17:20 22:25 ];
 tri = delaunay(endpoint(red,1),endpoint(red,2));
% plot(endpoint(:,1),endpoint(:,2),'.')

%
% How many triangles are there?

[r,c] = size(tri);
disp(r)

% will remove some unneeded traingles
tri([7,14,16,4,24,26,27],:)=[];
% Plot it with TRISURF

h = trisurf(tri, endpoint(red,1),endpoint(red,2),endpoint(red,3),'Facecolor','g');
axis vis3d

%% Calculate surface area
endpoint = endpoint([1:5 7:10 12:15 17:20 22:25 ],:);
v1 = endpoint(tri(:,2),:)-endpoint(tri(:,1),:);
v2 = endpoint(tri(:,3),:)-endpoint(tri(:,2),:);

cp = .5*cross(v1,v2);

surfaceArea = sum(sqrt(dot(cp,cp,2)))
 
 end
 