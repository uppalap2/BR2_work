function YZdata = rotate2YZplane(file)
clear EndPoints;
% name is the mat file name
 load(file);
% n = length(EndPoints);
% EndPoints = endpointsP3;
n = length(EndPoints);
YZdata = zeros(n,3);

% because each point will have a different rotation angle, need to do it
% one by one (so using a for loop)

for i = 1:n
    theta = atan2(EndPoints(i,1),EndPoints(i,2));
    RotZ = [cos(theta) -sin(theta) 0;
        sin(theta) cos(theta) 0;
        0          0          1];
    
    YZdata(i,:) = (RotZ*EndPoints(i,:)')';
    
end
end