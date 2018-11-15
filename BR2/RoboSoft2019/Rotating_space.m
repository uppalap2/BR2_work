% generating the data with one rotating actuator and rotating base with 1
% degree resolution from  0:1:180 degrees 
% [pos_rot,orient_rot,IP] = forward_kin_rot(Pb,Pr1,rot_angle)

n = 500000;

data_rot = zeros(n,10);
parfor i = 1:n/2
    Pb  = rand(1)*21+7;
    Pr1 = rand(1)*28;
    Pr2 = 0;
    rot_angle = rand(1)*180;
    [pos_rot,orient_rot,IP,shape_rot] = forward_kin_rot(Pb,Pr1,Pr2,rot_angle);
    data_rot(i,:) = [pos_rot' orient_rot' IP];
end

parfor i = n/2+1:n
    Pb  = rand(1)*21+7;
    Pr1 = 0;
    Pr2 = rand(1)*28;
    rot_angle = rand(1)*180;
    [pos_rot,orient_rot,IP,shape_rot] = forward_kin_rot(Pb,Pr1,Pr2,rot_angle);
    data_rot(i,:) = [pos_rot' orient_rot' IP];
    %%% plot check
%     plot3(shape_rot(1,:),shape_rot(2,:),shape_rot(3,:),'r')
%     hold on
end

save('simulation_data_full.mat','data_rot');% clockwise rotation

%%% Plotting
% plot3(data_rot(:,1),data_rot(:,2),data_rot(:,3),'r*')
% axis equal
% grid on
% hold on
% quiver3(data_rot(:,1),data_rot(:,2),data_rot(:,3),data_rot(:,4)/100,data_rot(:,5)/100,data_rot(:,6)/100)


% rotating_WS_2.mat is anti clockwise rotation

% %%%
% data_rot(:,1:3) = round(data_rot(:,1:3),3);
% data_rot(:,4:5) = round(data_rot(:,4:5),1);
% save('simulation_data.mat','data_rot');