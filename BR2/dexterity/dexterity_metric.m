clear all
clc

load('..\Control valves_2\EI_fine_BR2.mat');
load('..\Control valves_2\GJ_fine_BR2.mat');
load('..\Control valves_2\kappa_fine_BR2.mat');
load('..\Control valves_2\tau_fine_BR2.mat');
P_b_q = 7:1:28;
P_r_q = 0:1:28;

n_t     = 101;%51 for < 20 % 61 for 20
init_g_value = 9.81;
WpL = .1194;
F_e = [0;0;3e-3]*10;
n = 15;
L = 31e-2;
gravity_on = 1;
patch_point = zeros(4000000,6);

% [shape,C] = cosserat_full_mod(x0_par,WpL,EC_F,L,gravity_on,n_t,varargin)
parfor i = 1:4000000/2
    Pb = rand(1)*21+7;
    Pr1 = rand(1)*28;
    k = interp2(P_b_q,P_r_q,kappaq,Pb,Pr1);
    t = interp2(P_b_q,P_r_q,tauq,Pb,Pr1);
    EI = interp2(P_b_q,P_r_q,EIq,Pb,Pr1);
    GJ = interp2(P_b_q,P_r_q,GJq,Pb,Pr1);
    
    shape = cosserat_full_mod([EI GJ k t],WpL,F_e,L,gravity_on,n_t);
    
    P_end = shape(end,1:3)';
    O_end = shape(end,[6 9 12])';
    
    % Find theta to roate to to yz plane(i.e x=0)
    theta = atan2(P_end(1),P_end(2));
    RotZ = [cos(theta) -sin(theta) 0;
            sin(theta) cos(theta) 0;
            0          0          1];
    
    P_end_n = RotZ*P_end;
    O_end_n = RotZ*O_end;
    
    % phi tag number
    phi = acos(O_end_n(3));
    

    % tagging the number [y z theta phi]
    
    patch_point(i,:) = [floor(P_end_n(2)/5e-3)+10 floor(P_end_n(3)/5e-3)+20 ...
                   floor(atan2(O_end_n(2),O_end_n(1))/.1065)+30 tag_phi(phi) Pb Pr1];
    
end

parfor i = 4000000/2+1:4000000
    Pb = rand(1)*21+7;
    Pr1 = rand(1)*28;
    k = interp2(P_b_q,P_r_q,kappaq,Pb,Pr1);
    t = interp2(P_b_q,P_r_q,tauq,Pb,Pr1);
    EI = interp2(P_b_q,P_r_q,EIq,Pb,Pr1);
    GJ = interp2(P_b_q,P_r_q,GJq,Pb,Pr1);
    
    shape = cosserat_full_mod([EI GJ k -t],WpL,F_e,L,gravity_on,n_t);
    
    P_end = shape(end,1:3)';
    O_end = shape(end,[6 9 12])';
    
    % Find theta to roate to to yz plane(i.e x=0)
    theta = atan2(P_end(1),P_end(2));
    RotZ = [cos(theta) -sin(theta) 0;
            sin(theta) cos(theta) 0;
            0          0          1];
    
    P_end_n = RotZ*P_end;
    O_end_n = RotZ*O_end;
    
    % phi tag number
    phi = acos(O_end_n(3));
    

    % tagging the number [y z theta phi]
    
    patch_point(i,:) = [floor(P_end_n(2)/5e-3)+10 floor(P_end_n(3)/5e-3)+20 ...
                   floor(atan2(O_end_n(2),O_end_n(1))/.1065)+30 tag_phi(phi) Pb Pr1];
                             
    
end

 

function [phi_tag] = tag_phi(phi)
if phi <= .3672
    phi_tag = 1;
elseif (.3672 < phi) && (phi <= .5223)
    phi_tag = 2;
elseif (.5223 < phi) && (phi <= .6435)
    phi_tag = 3;
elseif (.6435 < phi) && (phi <= .7476)
    phi_tag = 4;
elseif (.7476 < phi) && (phi <= .8411)
    phi_tag = 5;
elseif (.8411 < phi) && (phi <= .9273)
    phi_tag = 6;
elseif (.9273 < phi) && (phi <= 1.0083)
    phi_tag = 7;
elseif (1.0083 < phi) && (phi <= 1.0853)
    phi_tag = 8;
elseif (1.0853 < phi) && (phi <= 1.1593)
    phi_tag = 9;
elseif (1.1593 < phi) && (phi <= 1.2310)
    phi_tag = 10;
elseif (1.2310 < phi) && (phi <= 1.3009)
    phi_tag = 11;
elseif (1.3009 < phi) && (phi <= 1.3694)
    phi_tag = 12;
elseif (1.3694 < phi) && (phi <= 1.4371)
    phi_tag = 13;
elseif (1.4371 < phi) && (phi <= 1.5041)
    phi_tag = 14;
elseif (1.5041 < phi) && (phi <= 1.5708)
    phi_tag = 15;
elseif (1.5708 < phi) && (phi <= 1.6375)
    phi_tag = 16;
elseif (1.6375 < phi) && (phi <= 1.7045)
    phi_tag = 17;
elseif (1.7045 < phi) && (phi <= 1.7722)
    phi_tag = 18;
elseif (1.7722 < phi) && (phi <= 1.8407)
    phi_tag = 19;
elseif (1.8407 < phi) && (phi <= 1.9106)
    phi_tag = 20;
elseif (1.9106 < phi) && (phi <= 1.9823)
    phi_tag = 21;
elseif (1.9823 < phi) && (phi <= 2.0563)
    phi_tag = 22;
elseif (2.0563 < phi) && (phi <= 2.1333)
    phi_tag = 23;
elseif (2.1333 < phi) && (phi <= 2.2143)
    phi_tag = 24;
elseif (2.2143 < phi) && (phi <= 2.3005)
    phi_tag = 25;
elseif (2.3005 < phi) && (phi <= 2.3940)
    phi_tag = 26;
elseif (2.3940 < phi) && (phi <= 2.4981)
    phi_tag = 27;
elseif (2.4981 < phi) && (phi <= 2.6193)
    phi_tag = 28;
elseif (2.6193 < phi) && (phi <= 2.7744)
    phi_tag = 29;
else
    phi_tag = 30;
end
end