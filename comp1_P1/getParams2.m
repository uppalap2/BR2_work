function [params_opti] = getParams2(exp_data,L,WpL,F_e,n,Kmax,Tmax,EImin,GJmin)
% exp_data is a string file with experimental data (exp_data.mat)
% n = no of points to compare the positions
% F_e = end force in global direction
% Kmax = upper bound on the curvature
% Tmax = upper bound on the torsion
% EImin, GJmin = lower bounds on the rigidity values (9e-4,18e-4)
% option = 1; % 0 for shape w/o gravity
% 1 for shape with gravity
% 2 for grasping around a object



option = 1; % gravity is on always
if option == 0
    gravity_on = 0;
else
    gravity_on = 1;
end
n_t_1      = 61;%51 for < 20 % 61 for 20
n_f        = 61;%31 for < 20 % 61 for 20


init_g_value = 9.81;

x0 = [EImin;GJmin;0;0];
% x0 = [9e-4;9e-4/5;6;0];

lb = [EImin;GJmin;-Kmax;-Tmax];
ub = [20*EImin;20*GJmin;Kmax;Tmax];
rexp = load(exp_data); % experimental data of final shape at known loactions

sexp = [0:L/n:L]; % locations of exp data
% plot3(rexp(:,1),rexp(:,2),rexp(:,3),'r');
% hold on


options1 = optimoptions('fmincon'                ,...
                           'Display'                ,'iter',...
                           'Algorithm'              ,'sqp',... % use active-set or sqp only, interior point doesn't satisfy the constraints
                           'MaxFunctionEvaluations' ,10e3,...
                           'MaxIter'                ,180,...
                           'TolFun'                 ,1e-6,...
                           'UseParallel'            ,true);

params_opti = fmincon(@(x) ObjFun(x,WpL,...
                                L,...
                                gravity_on,...
                                n_t_1,...
                                n_f,...
                                0,n,F_e,init_g_value,option,rexp.exp_data,sexp),...
                                x0,[],[],[],[],lb,ub,[],options1);
params_opti = [params_opti(1) 2/3*params_opti(1) params_opti(3) params_opti(4)]; 
                            
[~,~,shape_final,~,~]  = getShape(params_opti,... % e only for cons3 function
            WpL,...
            F_e,L,...
            gravity_on,...
            n_t_1,...
            n_f,...
            0,n,init_g_value,option);     
plot3(shape_final(:,1),shape_final(:,2),shape_final(:,3),'g');
hold on
plot3(rexp.exp_data(:,1),rexp.exp_data(:,2),rexp.exp_data(:,3),'r');
axis tight
grid on
axis equal
end

function y = ObjFun(x,WpL,...
                                L,...
                                gravity_on,...
                                n_t_1,...
                                n_f,...
                                r_cyl,n,F_e,init_g_value,option,rexp,sexp)
        EC_F = F_e;
        x(2) = 2/3*x(1);
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
%         c = [abs(shape_anal-rexp)-1e-4];
% Rend = shape_anal(end,4:12);
% Rend = [Rend(1:3);Rend(4:6);Rend(7:9)];
% TanEnd_anal = Rend(:,3);


        y = 100*sum(sum((shape_anal(end,:)-rexp(end,:)).^2))+ sum((TanEnd_anal-tan_exp').^2);
% distSquare = cumsum((shape_anal-rexp).^2,2);
% y = min(max(distSquare(:,3)));
end