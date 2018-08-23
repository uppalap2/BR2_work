load('Control valves_2\workspace_31cm_50g.mat')


n = length(EndPoints);
YZdata = zeros(n,3);

% because each point will have a different rotation angle, need to do it
% one by one (so using a for loop)

for i = 1:n
    theta = atan2(EndPoints(i,1),EndPoints(i,2));
    RotZ = [cos(theta) -sin(theta) 0;
        sin(theta) cos(theta) 0;
        0          0          1];
    
    YZdata(i,:) = (RotZ*EndPoints(i,1:3)')';
    
end

%% Patch where new location with 2 gms

indx2gP2 = find(YZdata(:,2) < .17 & YZdata(:,2) > .150 & YZdata(:,3) < .23 & YZdata(:,3) > .210);
Pressures_angle = [round(indx2gP2/29)+7, rem(indx2gP2,29) atan2d(EndPoints(indx2gP2,1),EndPoints(indx2gP2,2))]

plot(YZdata(indx2gP2,2),YZdata(indx2gP2,3),'r*')

