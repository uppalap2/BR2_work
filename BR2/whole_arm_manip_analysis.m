
function result_7B = whole_arm_manip_analysis
 % needed 
% clf
L = 31e-2; %%%%%%%CHANGE THIS
EL = [0;0;3e-3]*10;
Pb = 28;
Pr = 10:1:28;
result_7B = zeros(length(Pr),8);
for i = 1:length(Pr)
    
    
    [~,initial_shape] = forward_kin(Pb,Pr(i),L,EL);
    
    plot3(initial_shape(:,1),initial_shape(:,2),initial_shape(:,3),'c');
    axis equal
    grid on
    hold on
%     Microscribe_data_plots
    [TangVec] = angle_detect(initial_shape);
    CylCurv = initial_shape(end,13)/(sind(TangVec(end)))^2;
    MinLength_act = 2.5*pi*(CylCurv^(-1)-9.525e-3)/sind(mean(TangVec(round(end/2):end)));
    MinLength_wp = 2.5*pi*(CylCurv^(-1)-9.525e-3)/tand(mean(TangVec(round(end/2):end)));
    check = MinLength_act>=L;
    
    result_7B(i,:) = [L Pb Pr(i) CylCurv^(-1)-9.525e-3 MinLength_act MinLength_wp check TangVec(end) ];%%%%%%%%CHANGE THIS
end

% % save('C:\Users\Naveen\Box Sync\git\spiral_gripping\Materialmodel\prototypes\result_5088_Eb.mat'...
% %     ,'result_5088_40','-append'); % use append after first save only.%%%%%%%%CHANGE THIS
% 

end





function TangVec = angle_detect(a)
% works perfect for without gravity
% CentralAxis = [-.5489 -.0058 .8359];% 50 cm
x = a(end-5:end,6);
y = a(end-5:end,9);
z = a(end-5:end,12);
 plot3(x/10,y/10,z/10,'r.')
 hold on
 
 plot3(a(:,1),a(:,2),a(:,3),'k')

 A=[x-mean(x), y-mean(y), z-mean(z)];

[~,~,V]=svd(A,0);

CentralAxis = V(:,end); %Approximately
plot3([0 CentralAxis(1)/30],[0 CentralAxis(2)/30 ], [0 CentralAxis(3)/30],'b:')
axis equal 
grid on
% CentralAxis = [1 0 1];
for i = 1:length(a)
    
    R(:,:,i) = reshape(a(i,4:12),3,3); % this should be transposed default is column wise
    TangVec(i) = atan2d(norm(cross(R(3,:,i)',CentralAxis)),dot(R(3,:,i)',CentralAxis));
end

end
