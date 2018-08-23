function [params_opti] = getParams_g(exp_data,~,WpL,F_e,n,Kmax,Tmin,EImin,GJmin)
%uses global search for the optimization problem

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
n_t     = 101;%51 for < 20 % 61 for 20



% Optimization framework for finding the End Force

% fun = @(x)(abs((x(3)-Kmax))^2 + (x(4))^2 + 1e5*((x(1)-EImin)^2+(x(2)-GJmin)^2));
fun = @(x)(abs((x(2)/Kmax)-1)^2 + ((x(4)/Tmin)-1)^2 + ((x(1)/EImin-1)^2+(x(2)/GJmin-1)^2));
% fun = @(x)1;

%% Initial guess
% % for benidng alone
% kappa = -Kmax;
% x0 = [EImin+.01*EImin;GJmin+.01*GJmin;kappa;0];
% % for fitting
x0 = [EImin;GJmin;-Kmax;Tmin-2];


%% Bounds on variables
% for bending alone
% lb = [EImin/3;GJmin/3;kappa;-Tmin];
% ub = [50*EImin;50*GJmin;kappa;Tmin];
% % % for fitting
lb = [.8*EImin;.8*GJmin;-Kmax-1;-4];
ub = [100*EImin;100*GJmin;0;Tmin+1];

rexp = load(exp_data); % experimental data of final shape at known loactions
% rexp = load('Control valves_2\P2_27_18.mat');
% rexp = rexp.exp_data;
rexp = rexp.exp_data/1000;
rexp(:,3) = -rexp(:,3);
rexp = [rexp(:,2) rexp(:,1) rexp(:,3)];

% calculating the total length
L = arclength(rexp(:,1),rexp(:,2),rexp(:,3));

% locations of exp data
sexp = 0:L/n:L; 

options1 = optimoptions('fmincon'                ,...
    'Display'                ,'iter',...
    'Algorithm'              ,'sqp',... % use active-set or sqp only, interior point doesn't satisfy the constraints
    'MaxFunctionEvaluations' ,10e3,...
    'MaxIter'                ,180,...
    'TolFun'                 ,1e-4,...
    'UseParallel'            ,true,...
    'ConstraintTolerance'    ,4e-3);

rng default; % For reproducibility
gs = GlobalSearch;
% params_opti = fmincon(fun,x0,[],[],[],[],lb,ub,@(x)nonlincon(x,WpL,...
%                         L,...
%                         gravity_on,...
%                         n_t_1,...
%                         n_f,...
%                         0,n,F_e,init_g_value,option,rexp,sexp),options1);

problem = createOptimProblem('fmincon','x0',x0,'objective',fun,'lb',lb,'ub',ub,'nonlcon',@(x)nonlincon(x,WpL,...
                        F_e,L,gravity_on,n_t,rexp,sexp),'options',options1);
% problem = createOptimProblem('fmincon','x0',x0,'objective',fun,'lb',lb,'nonlcon',@(x)nonlincon(x,WpL,...
%                         F_e,L,gravity_on,n_t,rexp,sexp),'options',options1);

% params_opti = [params_opti(1) params_opti(2) params_opti(3) params_opti(4)];
params_opti = run(gs,problem);
% [~,~,shape_final,~,~]  = getShape(params_opti,... % e only for cons3 function
%                                     WpL,...
%                                     F_e,L,...
%                                     gravity_on,...
%                                     n_t_1,...
%                                     n_f,...
%                                     0,n,init_g_value,option);

s_new = 0:L/100:L;
init_shape = interp1((0:L/(length(rexp)-1):L),rexp,s_new);

[shape_final] = cosserat_full(params_opti,WpL,F_e,L,gravity_on,n_t,[zeros(1,3) 1.0000 zeros(1,3) 1 zeros(1,3) 1],init_shape);
                                
plot3(shape_final(:,1),shape_final(:,2),shape_final(:,3),'go');
hold on
plot3(rexp(:,1),rexp(:,2),rexp(:,3),'ro');
axis tight
xlabel 'X'
ylabel 'Y'
zlabel 'Z'
axis equal
shape_final(end,1:3)

end


function [c,ceq] = nonlincon(x,WpL,...
                            F_e,L,...
                            gravity_on,...
                            n_t,...
                           rexp,sexp)


s_new = 0:L/100:L;
init_shape = interp1((0:L/(length(rexp)-1):L),rexp,s_new);
[shape]  = cosserat_full(x,WpL,F_e,L,gravity_on,n_t,[zeros(1,3) 1.0000 zeros(1,3) 1 zeros(1,3) 1],init_shape);

ode_step_size = L / (n_t-1);
ode_range     = 0 : ode_step_size : L;

shape_anal = interp1(ode_range,[shape(:,1:2) shape(:,3)],sexp);
rexp = interp1((0:L/(length(rexp)-1):L),rexp,sexp);

ceq= [];

dist = cumsum((shape_anal-rexp).^2,2);

c1 = sqrt(dist(end,3))-20e-3;% 1 cm % for 24 psi
c2 = sqrt(dist(1:end-1,3))-30e-3;% 20e-3  for P2 and P3

c = [1*c1;c2];

end