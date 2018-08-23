%% Convert experimental data into spline data and resave it

file_name = 'Control valves_2\P2_36_36.mat';
load(file_name)
exp_data = fnplt(cscvn(exp_data(:,[1:end])'))';
save(file_name,'exp_data')