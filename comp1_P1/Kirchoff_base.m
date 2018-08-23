%% Kirchoff model
% Assumption of no strains i.e v = [0 0 1]
% I = Second moment of area
% L = length of actuator
% E = Youngs modulus
% G = Shear modulus (take it as E/5)
% EF,EM = End force and End moment ;each size [3x1] (Global axis)
% WpL: weight per unit length of actuator
% e : direction of gravity(example [0 0 1]' actiavtes gravity in global z
%     direction)

% sample : Kirchoff_base(1e-9,50e-2,9e5,9e5/5,[ 0 0 0]',[1e-3 0 0]',.05,[0 0 1]')
function[x] = Kirchoff_base(I,L,E,G,EF,EM,WpL,e)


C = diag([E*I,E*I,G*I*2]);

IC = [0 0 0 ...
      1 0 0 0 1 0 0 0 1];

f_b = WpL*e;
f_f = [0 0 0]'; % follower forces in local axis 
options = optimset( optimset('fsolve'), 'TolFun', 1.0e-8,...
                    'TolX',1.0e-8,'Display','off','MaxFunEvals',...
                    1e5,'MaxIter',3e2);
 u0 = fsolve(@(u0)myfun(u0,IC,EF,EM,C,L,f_b,f_f),[0 0 0],options);

[s,x] = ode45(@(s,x)odefun(s,x,L,C,f_b,EF,f_f),(0:L/100:L),[IC u0 0 0 0]);

if WpL == 0 || sum(e)== 0 
    col = 'go';
else
    col = 'ro';
end
plot3(x(:,1),x(:,2),-x(:,3),col);

xlabel('x');
ylabel('y');
zlabel('z');
axis equal
grid on
end

function dxds = odefun(s,x,L,C,f_b,EC_f,f_f)
r = [x(1);x(2);x(3)];
R = [x(4) x(5) x(6);x(7) x(8) x(9);x(10) x(11) x(12)];
u = [x(13);x(14);x(15)];
F = [x(16);x(17);x(18)];
uhat = [0 -x(15) x(14); x(15) 0 -x(13);-x(14) x(13) 0];
vhat = [0 -1 0; 1 0 0;0 0 0];

rdot = R*[0;0;1];
Rdot = R*uhat;
udot = -C^(-1)*(uhat*C*u + vhat*R'*(f_b*(L-s)+F+EC_f));
Fdot = -R*f_f;

dxds = [rdot(1);rdot(2);rdot(3);
        Rdot(1,1); Rdot(1,2);Rdot(1,3);
        Rdot(2,1);Rdot(2,2);Rdot(2,3);
        Rdot(3,1);Rdot(3,2);Rdot(3,3);
        udot(1);udot(2);udot(3);
        Fdot(1);Fdot(2);Fdot(3)];
end

function G = myfun(x0,ics,EC_f,M,C,L,f_b,f_f)
%%%Ma= applied end moment and torque [3x1]
%%%% f_tx = local uniform follower force

[~,x] = ode45(@(s,x)odefun(s,x,L,C,f_b,EC_f,f_f),0:L/100:L,[ics x0(1) x0(2) x0(3) 0 0 0]);
R_end = [x(end,4:6);x(end,7:9);x(end,10:12)];


u_last = x(end,13:15)';


m_last = R_end*C*u_last;


G = (M - m_last );
end
