% obtaining the analysis end positions with load for different pressures
% (RoboSoft validation)
clear all
clc

F_e = [0 0 0*1e-2];% end load with end caps

PosEndMat = zeros(24,3);

Pb = [6:6:30];
Pr = [0:4:16];

for i= 1:5
    for j = 1:5
        if ((i==1) && (j==5))
            [i j]
%             pause
            PosEndMat(5*(i-1)+j,:) = [NaN NaN NaN];
        else
            PosEndMat(5*(i-1)+j,:) = ShapeParams(Pb(i),Pr(j),F_e);
        end
    end
end

plot3(-PosEndMat(:,1),PosEndMat(:,2),-PosEndMat(:,3),'g*')
PosEndMat = [-PosEndMat(:,1) PosEndMat(:,2) -PosEndMat(:,3)];
% PosEndMat2 = PosEndMat;
PosEndMat_0g = PosEndMat;
% save('PosEndMat2.mat','PosEndMat2')
save('PosEndMat_0g.mat','PosEndMat_0g')