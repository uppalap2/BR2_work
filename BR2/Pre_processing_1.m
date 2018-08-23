%% Convert experimental data into spline data and resave it

file_name = 'Control valves_2\BR2_28_28_R.mat';
load(file_name)
exp_data = fnplt(cscvn(exp_data(:,[1:end])'))';
save(file_name,'exp_data')