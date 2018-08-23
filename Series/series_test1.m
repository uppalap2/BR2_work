% script for serial BR2
% Test 1 case: consider same EI, GJ values
% go through the code (outline is in onenote series BR2)

% get the shape of first section
clear all
x1 = 0; % change in curvature
x2 = 0; % chaneg in torsion
x3 = 0; % change in kappa2
error = 2;
curv_1 = [5 0 2];% [k11 k12 t1]
curv_2 = [5 0 2];% [k21 k22 t2]
l1 = 30e-2;
l2 = 20e-2;
EI1 = .0138; GJ1 = .0022;
EI2 = .0138; GJ2 = .0022;
phoA1 = .0863;
phoA2 = .0863;
shape1 = cosserat_full([EI1 GJ1 curv_1(1)+x1 curv_1(3)+x2 curv_1(2)+x3], phoA1, [0;0;phoA2*l2]*10,l1,1,100);

EndOrient1st = shape1(end,4:12);
EndPos1st = shape1(end,1:3);

plot3(shape1(:,1),shape1(:,2),shape1(:,3),'r-');
hold on
axis equal
grid on

while error > 1e-6

shape2 = cosserat_full([EI2 GJ2 curv_2(1)+x1 curv_2(3)+x2 curv_2(2)+x3], phoA2, [0;0;0],l2,1,100,[EndPos1st EndOrient1st]);

diff_moment = shape2(end,13:15) - shape2(1,13:15);
x1 = diff_moment(1); x2 = diff_moment(3); x3 = diff_moment(2);

StartOrient2nd = shape2(1,4:12);
StartPos2nd = shape2(1,1:3);


shape1 = cosserat_full([.0138 .0022 curv_1(1)+x1 curv_1(3)+x2 curv_1(2)+x3], .0863, [0;0;.0863*15e-2]*10,l1,1,100);

EndOrient1st = shape1(end,4:12);
EndPos1st = shape1(end,1:3);

cum_error = cumsum(abs(StartOrient2nd-EndOrient1st),2);

error = cum_error(end);
end


plot3(shape1(:,1),shape1(:,2),shape1(:,3),'r:')
hold on
axis equal
plot3(shape2(:,1),shape2(:,2),shape2(:,3),'b-')
