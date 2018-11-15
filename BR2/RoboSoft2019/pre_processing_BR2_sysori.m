% Pre processing_1 of BR2 with one B,  and two R and roating base actuated
% Basically trying to give tags to its workspace and orientation.
% these tags will be used in inverse kinematics to determine if a pos has
% desired orientation or not

% loading the mat file with the data (if doesn't exist in workpsace)

load simulation_data_full.mat 


% % data_rot = [pos(3x1) ori(3x1) IP(3x1)]
% 
% %%%% tags for position
% 
% tagsPos = round(data_rot(:,1:3)/.01);
% tagsBias = min(tagsPos,[],1) -1 ;
% tagsPos = tagsPos - tagsBias;
% 
% %%%% tags for orientations
% 
% % tags for theta
% % diff(linspace(0,2*pi,20)) = .3307
% % diff(linspace(0,2*pi,10)) = .6981
% tagsOriTheta = round(atan2(data_rot(:,5),data_rot(:,4))/.6981);
% tagsOriThetaBias = min(tagsOriTheta) - 1;
% tagsOriTheta = tagsOriTheta - tagsOriThetaBias ;
% 
% % tags for phi
% edges= [0,.6435,.9273,1.1593,1.3694,1.570,1.7722,1.9823,2.2143,2.4981,3.14];
% [~,~,tagsPhi] = histcounts(acos(data_rot(:,6)),edges);
% 
% tags = [tagsPos tagsOriTheta tagsPhi];
% 
% % get the unique pos_ori and pos for these 
% 
% [pos_ori,ipo,icpo] =  unique(tags,'rows');
% [pos,ip,icp] = unique(pos_ori(:,1:3),'rows');

[pos_ori_full,id1,id2] = unique([round(data_rot(:,1:3),2) round(data_rot(:,4:6),1)],'rows');
[pos_full,id3,id4] = unique(pos_ori_full(:,1:3),'rows');
%%
%%%% test case 1
% use the code for getting the orinetation set at different points, but
% feed the correct values

%%%% line_test_ori
% x = .18*ones(1,25);
% z = round(linspace(.08,.22,25),2);
% y = 0*.15*ones(1,25);

%%%%% circle_test_ori
% x_o = .18*ones(1,60);
% theta = linspace(0,2*pi,60);
% z_o = 5*cos(theta)/100+.1;
% y_o = 5*sin(theta)/100;

% x_o = .18*ones(1,60);
% y_o = 0*ones(1,60);
% z_o = linspace(0,.20,60);

t = linspace(0,4*pi,60);
x_o = 5.6*(1+cos(t))/100+ .09;
y_o = 5.6*sin(t)/100 ;
z_o = 2*8*sin(t/2)/100 + .12;

x = round(x_o,2);
y = round(y_o,2);
z = round(z_o,2);
test_line = [x' y' z'];


%%% plot check if in workspace
plot3(test_line(:,1),test_line(:,2),test_line(:,3),'r*');
axis equal
hold on
grid on
plot3(data_rot(1:10:end,1),data_rot(1:10:end,2),data_rot(1:10:end,3),'c.')

% pause


% test_line_tags = round(test_line/.01) - tagsBias;
% 
% ori_tags = zeros(length(test_line_tags),2);

[~,rowidx] = ismember(pos_ori_full(:,1:3),test_line(:,:),'rows');
 
locs = accumarray(rowidx+1, (1:length(rowidx)).', [], @(v) {v});

ia = locs(2:end);%%%%%%%fix this

mx_ia = max(rowidx);


% seperate the matching points
ianew = ia(~cellfun('isempty',ia));

% get the position with max orientations to compare
[size_max_ori,idx] = max(cellfun('length',ia));
disp('The maximum orientations for a point are:')
disp(size_max_ori)

% get the orientations set of maximum poses position
get_cumsum = cumsum(cellfun('length',ia));
if idx>1
    startID = get_cumsum(idx-1) ;
else
    startID = get_cumsum(idx) ;
end


% do the dot product with all the vectors in the idx and get its column
% mean

dotProd = pos_ori_full(cell2mat(ia),4:6)*pos_ori_full(ia{idx},4:6)';

% get the mean of each column and IID of max column
[maxMean,IID] = max(mean(dotProd));

disp('The max mean of columns is :')
disp(maxMean)

% so preferred orientation is 
disp('System chosen orientation is:')

sysOri = pos_ori_full(ia{idx}(IID),4:6);
disp(sysOri)

ori_tags = zeros(length(ia),3);
for i = 1:length(ia)
    if isempty(ia{i}) && i == 1
        ori_tags(i,:) = sysOri;
    elseif isempty(ia{i}) 
        ori_tags(i,:) = ori_tags(i-1,:);
    else
        [maxSet,IDset] =  max(pos_ori_full(ia{i},4:6)*pos_ori_full(ia{idx}(IID),4:6)');
        ori_tags(i,:) = pos_ori_full(ia{i}(IDset),4:6);
        
        fprintf('In position %d the match is %d \n',i,maxSet)
    end
end


diff_size = abs(length(ia)-length(test_line(:,1)));
ori_tags = [ori_tags; repmat(ori_tags(end,:),diff_size,1)];
% inps = [x(1:end-diff_size)' y(1:end-diff_size)' z(1:end-diff_size)' ori_tags];
inps = [x_o' y_o' z_o' ori_tags];

inps(:,1:3) = inps(:,1:3)*10;
inps(:,4:6) = inps(:,4:6);

% save('line_test_ori.mat','inps')

% save('viviani_test_sys_ori.mat','inps')