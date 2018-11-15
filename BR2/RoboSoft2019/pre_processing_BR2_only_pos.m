% ONly pos inputs

% loading the mat file with the data (if doesn't exist in workpsace)
% 
load simulation_data_full.mat 
% 
% 
% 

[pos_ori_full,id1,id2] = unique([round(data_rot(:,1:3),2) round(data_rot(:,4:6),1)],'rows');
[pos_full,id3,id4] = unique(pos_ori_full(:,1:3),'rows');
%%
%%%% test case 1

% trefoil torus knot
% t = linspace(0,2*pi,30);
% x = cos(2*t).*(3+cos(3*t))/25;
% y = sin(2*t).*(3+cos(3*t))/25;
% z = sin(3*t)/25 + .1;
%% circle 5 units

% x_o = .18*ones(1,60);
% theta = linspace(0,2*pi,60);
% z_o = 5*cos(theta)/100+.1;
% y_o = 5*sin(theta)/100;

close all

x_o = .18*ones(1,60);
y_o = 0*ones(1,60);
z_o = linspace(0,.20,60);
% 
% t = linspace(0,4*pi,60);
% x_o = 5.6*(1+cos(t))/100+ .09;
% y_o = 5.6*sin(t)/100 ;
% z_o = 2*8*sin(t/2)/100 + .12;

x = round(x_o,2);
z = round(z_o,2);
y = round(y_o,2);

test_line_o = [x_o' y_o' z_o'];

test_line = [x' y' z'];


%%% plot check if in workspace
plot3(test_line(:,1),test_line(:,2),test_line(:,3),'r*');
axis equal
hold on
grid on
plot3(data_rot(1:10:end,1),data_rot(1:10:end,2),data_rot(1:10:end,3),'c.')

% pause
%method 1: choose the first possible orientation

inps = zeros(length(x),6);
for i = 1:length(x)
    [~,ia,ib] = intersect(pos_ori_full(:,1:3),round(test_line(i,:),2),'rows');
    if isempty(ia) && i~=1
        inps(i,:) = [test_line_o(i,:) inps(i-1,4:6)];
    elseif isempty(ia) && i==1
        inps(i,:) = [test_line_o(i,:) 1 0 0];
    else
        inps(i,:) = [test_line_o(i,:) pos_ori_full(ia,4:6)];
    end
end

inps(:,1:3) = inps(:,1:3)*10;

% save('line_test.mat','inps')   
% save('circle_test.mat','inps') 
%  save('viviani_test_pos_3.mat','inps') 