function [params_opti] = getParams(exp_data,~,WpL,F_e,n,Kmax,Tmin,EImin,GJmin)
% exp_data is a string file with experimental data (exp_data.mat)
% WpL = weight per unit length in kg/meters
% n = no of points to compare the positions
% F_e = end force in global direction
% Kmax = upper bound on the curvature
% Tmin = some value for Tmin, the bounds are defined below
% EImin, GJmin = lower bounds on the rigidity values (9e-4,18e-4)
% option = 1; % 0 for shape w/o gravity
% 1 for shape with gravity
% 2 for grasping around a object
% L = length can be given but also calculated from the data given



option = 1; % gravity is on always
if option == 0
    gravity_on = 0;
else
    gravity_on = 1;
end
% number of points for BVP solver
n_t_1      = 61;%51 for < 20 % 61 for 20

% dont tweak this, can be any number
n_f        = 61;%31 for < 20 % 61 for 20

init_g_value = 9.81;

% Optimization framework for finding the End Force

fun = @(x)((x(3)-Kmax)^2 + (x(4))^2 + 1e6*((x(1)-EImin)^2+(x(2)-GJmin)^2));
% fun = @(x)1;

%% Initial guess
% % for benidng alone
% kappa = 7.7;
% x0 = [EImin+.01*EImin;GJmin+.01*GJmin;kappa;0];
% % for fitting
x0 = [EImin;GJmin;Kmax;-Tmin];


%% Bounds on variables
% % for bending alone
% lb = [EImin;GJmin;kappa;0];
% ub = [50*EImin;50*GJmin;kappa;0];
% % for fitting
lb = [EImin;GJmin;0;-4*Tmin-2];
ub = [20*EImin;20*GJmin;Kmax;0];
rexp = load(exp_data); % experimental data of final shape at known loactions
rexp = rexp.exp_data;

% calculating the total length
L = arclength(rexp(:,1),rexp(:,2),rexp(:,3));

% locations of exp data
sexp = [0:L/n:L]; 

options1 = optimoptions('fmincon'                ,...
    'Display'                ,'iter',...
    'Algorithm'              ,'sqp',... % use active-set or sqp only, interior point doesn't satisfy the constraints
    'MaxFunctionEvaluations' ,10e3,...
    'MaxIter'                ,180,...
    'TolFun'                 ,1e-4,...
    'UseParallel'            ,true);

params_opti = fmincon(fun,x0,[],[],[],[],lb,ub,@(x)nonlincon(x,WpL,...
                        L,...
                        gravity_on,...
                        n_t_1,...
                        n_f,...
                        0,n,F_e,init_g_value,option,rexp,sexp),options1);
                    
params_opti = [params_opti(1) params_opti(2) params_opti(3) params_opti(4)];

[~,~,shape_final,~,~]  = getShape(params_opti,... % e only for cons3 function
                                    WpL,...
                                    F_e,L,...
                                    gravity_on,...
                                    n_t_1,...
                                    n_f,...
                                    0,n,init_g_value,option);
                                
plot3(shape_final(:,1),shape_final(:,2),shape_final(:,3),'go');
hold on
plot3(rexp(:,1),rexp(:,2),rexp(:,3),'ro');
axis tight
xlabel 'X'
ylabel 'Y'
zlabel 'Z'
axis equal

end


function [c,ceq] = nonlincon(x,WpL,...
    L,...
    gravity_on,...
    n_t_1,...
    n_f,...
    r_cyl,n,F_e,init_g_value,option,rexp,sexp)
EC_F = F_e;
%         x(2) = 2/3*x(1);
[~,~,shape,~,~]  = getShape(x,... % e only for cons3 function
    WpL,...
    EC_F,L,...
    gravity_on,...
    n_t_1,...
    n_f,...
    r_cyl,n,init_g_value,option);
ode_step_size = L / (n_t_1 - 1);
ode_range     = 0 : ode_step_size : L;
Rend = shape(end,4:12);
Rend = [Rend(1:3);Rend(4:6);Rend(7:9)];
TanEnd_anal = Rend(:,3);
tan_exp = (rexp(end,:)-rexp(end-1,:))/(L/(length(rexp)));
shape_anal = interp1(ode_range,[shape(:,1:2) shape(:,3)],sexp);
rexp = interp1((0:L/(length(rexp)-1):L),rexp,sexp);

ceq= [];

dist = cumsum((shape_anal-rexp).^2,2);

% c = sqrt(dist(end-5:end,3))-5e-3;% 1 cm
% c = sqrt(dist(end-5:end,3))-5e-3;% 1 cm % for 24 psi
c1 = sqrt(dist(end-5:end,3))-5e-3;% 1 cm % for 24 psi
c2 = sqrt(sum((TanEnd_anal-tan_exp').^2))-5e-3;
c = [c1 ; c2];

end