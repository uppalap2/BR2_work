%% loading to excel file in different sheets

% sheet 1
load test_line_pos_x18y0.mat
test = test(linspace(3,60,20),:);
xlswrite('Robosoft2019.xlsx',test,1,'A5')

% sheet 2
load test_circle_pos_x18.mat
test = test(linspace(2,60,30),:);
xlswrite('Robosoft2019.xlsx',test,2,'A5')

% sheet 3
load test_viviani_pos_3.mat
test = test(linspace(2,60,30),:);
xlswrite('Robosoft2019.xlsx',test,3,'A5')

% sheet 4
load test_line_sys_ori.mat
test = test(linspace(3,60,20),:);
xlswrite('Robosoft2019.xlsx',test,4,'A5')


% sheet 5
load test_circle_sys_ori.mat
test = test(linspace(2,60,30),:);
xlswrite('Robosoft2019.xlsx',test,5,'A5')


% sheet 6
load test_viviani_sys_ori.mat
test = test(linspace(2,60,30),:);
xlswrite('Robosoft2019.xlsx',test,6,'A5')
