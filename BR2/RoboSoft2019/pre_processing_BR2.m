% Pre processing_1 of BR2 with one B,  and two R and roating base actuated
% Basically trying to give tags to its workspace and orientation.
% these tags will be used in inverse kinematics to determine if a pos has
% desired orientation or not

% loading the mat file with the data (if doesn't exist in workpsace)

load simulation_data_full.mat 


% data_rot = [pos(3x1) ori(3x1) IP(3x1)]

%%%% tags for position

tagsPos = round(data_rot(:,1:3)/.01);
tagsBias = min(tagsPos,[],1) -1 ;
tagsPos = tagsPos - tagsBias;

%%%% tags for orientations

% tags for theta
% diff(linspace(0,2*pi,20)) = .3307
% diff(linspace(0,2*pi,10)) = .6981
tagsOriTheta = round(atan2(data_rot(:,5),data_rot(:,4))/.6981);
tagsOriThetaBias = min(tagsOriTheta) - 1;
tagsOriTheta = tagsOriTheta - tagsOriThetaBias ;

% tags for phi
edges= [0,.6435,.9273,1.1593,1.3694,1.570,1.7722,1.9823,2.2143,2.4981,3.14];
[~,~,tagsPhi] = histcounts(acos(data_rot(:,6)),edges);

tags = [tagsPos tagsOriTheta tagsPhi];

% get the unique pos_ori and pos for these 

[pos_ori,ipo,icpo] =  unique(tags,'rows');
[pos,ip,icp] = unique(pos_ori(:,1:3),'rows');

% [pos_ori_full,id1,id2] = unique([round(data_rot(:,1:3),2) round(data_rot(:,4:6),1)],'rows');
% [pos_full,id3,id4] = unique(pos_ori_full(:,1:3),'rows');
%%
%%%% test case 1


x = .18*ones(1,25);
z = round(linspace(.08,.2,25),2);
y = 0*.15*ones(1,25);

test_line = [x' y' z'];


%%% plot check if in workspace
plot3(test_line(:,1),test_line(:,2),test_line(:,3),'r*');
axis equal
hold on
grid on
plot3(data_rot(1:10:end,1),data_rot(1:10:end,2),data_rot(1:10:end,3),'c.')

% pause


test_line_tags = round(test_line/.01) - tagsBias;

ori_tags = zeros(length(test_line_tags),2);

[~,rowidx] = ismember(pos_ori(:,1:3),test_line_tags,'rows');
locs = accumarray(rowidx+1, (1:length(rowidx)).', [], @(v) {v});
ia = locs(2:end);

for i = 1:length(ori_tags(:,1))
    if isempty(ia{i}) && i == 1
        ori_tags(i,:) = [randi(9,1) randi(10,1)];
    elseif isempty(ia{i})
        ori_tags(i,:) = ori_tags(i-1,:);
    else
        idx = randi(length(ia{i}),1);
        ori_tags(i,:) = pos_ori(idx,4:5);
    end
end


% calculating theta from tags
theta_t = (ori_tags(:,1) + tagsOriThetaBias).*(.6981 + .5.*rand(length(ori_tags(:,1)),1)*.6981);

% calculating phi from tags

phi_t = zeros(length(ori_tags(:,2)),1);
edges= [0,.6435,.9273,1.1593,1.3694,1.570,1.7722,1.9823,2.2143,2.4981,3.14];
for i = 1:length(ori_tags(:,2))
    if ori_tags(:,2)== 1
        phi_t(i,1) = edges(2)/2;
    else
        phi_t(i,1) = (edges(ori_tags(i,2))+edges(ori_tags(i,2)-1))/2;
    end
end


o_z = cos(phi_t);
ratyx = tan(theta_t);
o_x = sqrt((1-o_z.^2)./(1+ratyx.^2));
o_y = o_x.*ratyx;
% ori = [o_x o_y o_z];
ori = [ones(25,1)*.71 ones(25,1)*0 ones(25,1)*.71];

inps = [x' y' z' ori];
inps(:,1:3) = round(inps(:,1:3),3)*10;
inps(:,4:6) = round(inps(:,4:6),1);

save('line_test.mat','inps')