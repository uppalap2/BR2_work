%% test for rotating any point to XZ plane

point = [25 30 -30]';
theta = atan2(-point(2), point(1));

point_n = [cos(theta) -sin(theta) 0;
                sin(theta) cos(theta) 0;
                0  0 1]*point;
            
plot3(point(1),point(2),point(3),'r*');

hold on
axis equal
grid on

plot3(point_n(1),point_n(2),point_n(3),'g*');
xlabel 'X'
ylabel 'Y'
zlabel 'Z'