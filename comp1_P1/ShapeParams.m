% % get end points for different pressure with different load using the
% obtained parameters


function [PosEnd,ShapeLoad] = ShapeParams(Pb,Pr,F_e)

L = 40e-2;
% WpL = 43e-3/L*0;% no body weight
WpL = 43e-3/L;
gravity_on = 1;


% mesh grid

P_b = 6:6:30;
P_r = 0:4:16;
[P_B,P_R] = meshgrid(P_b,P_r);


% estimated parameters for fit 1
EIp = [.0054 .0124 .0139 .0139 .0139;
    .0079 .0156 .0146 .0139 .0146;
    .0181 .0158 .0153 .0139 .0180;
    .0181 .0229 .0160 .0139 .0146;
    NaN .0287 .0160 .0139 .0143];

GJp = [.0035 .0063 .0064 .0064 NaN; .0083 .0106 .0108 .0163 .0168; .0120 .0158 .0160 .0164 .0164;...
    .0120 .02346 .0333 .0333 .0333; .0120 .0154 .0315 .0120 .0171]';

kappap = [1.4 1.3154 .9874 .9874 NaN; 2.6 2.2885 2.1653 1.8083 1.8083;4.3 4.0920 3.9166 3.6220 3.5063 ;...
    6.4 6.2097 6.1041 5.8711 5.4834; 8.5 7.8736 7.4028 7.3519 6.9654]';

taup = [0 1.8184 4.9246 8.2299  NaN; 0 1.6716 3.7348 6.5055 10.6213;0 1.4587 3.0717 5.2688 8.6896 ;...
    0 1.7175 2.9330 4.7780 7.6115; 0 1.6226 3.2180 4.4412 7.1937]';


% get the input parameters for given pressure Pb,Pr

params_opti = [interp2(P_B,P_R,EIp,Pb,Pr) interp2(P_B,P_R,GJp,Pb,Pr)...
                interp2(P_B,P_R,kappap,Pb,Pr) interp2(P_B,P_R,taup,Pb,Pr)];

[~,~,ShapeLoad,~,~]  = getShape(params_opti,... % e only for cons3 function
                                    WpL,...
                                    F_e,L,...
                                    gravity_on,...
                                    61,...
                                    61,...
                                    0,15,9.81,1);
% % plot entire shape                                
% plot3(ShapeLoad(:,1),ShapeLoad(:,2),ShapeLoad(:,3),'r');                                
PosEnd = ShapeLoad(end,1:3);
end