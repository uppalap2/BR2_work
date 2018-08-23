% Fit a 3D spline to the experimental data
clear all
clc


% Microscribe raw data (i.e coordinate rotated and shifted ) 
exp = [58.9918 102.2966 469.5804
58.4771 102.5073 438.5296
58.5755 101.2031 406.5011
56.1309 98.9676 376.4128
57.0192 94.9790 347.8166
58.0840 90.6228 318.1192
59.2346 84.3938 286.8233
61.9994 76.8096 257.7029
63.7257 67.1062 228.7447
65.4595 55.4157 201.7575
67.2323 40.9406 173.2158
70.4234 27.3179 147.7585
74.2034 9.4783 123.0506
78.0304 -11.0768 100.3862
78.1835 -19.2977 93.1777


];

% rotation and shifting the center
exp = (exp-exp(1,:))*rotz(11);

t = [1:1:length(exp)]'; % no of points collected in exp

% simulate measurement 
xMeasured = exp(:,1);
yMeasured = exp(:,2);
zMeasured = exp(:,3);

% plot simulated measurements
plot3(xMeasured, yMeasured, zMeasured,'or')
hold on
grid on

% least squares fit 
% basically a polynomial for each of x,y and z data. Example here we are fitting a ploynomial of at^3+b*t^2+c*t+d 
% and finding the least sqaure fit for a,b,c,d for each of the data
% A = [t.^2, t, t./t];% two degree fit
A = [t.^3,t.^2, t, t./t]; % 3 degree fit
pxEstimated = A\xMeasured;
pyEstimated = A\yMeasured;
pzEstimated = A\zMeasured;

% plotting the  fit data with finer stepsize
fitx = polyval(pxEstimated,(1:.1:length(exp)));
fity = polyval(pyEstimated,(1:.1:length(exp)));
fitz = polyval(pzEstimated,(1:.1:length(exp)));
hold on
plot3(fitx,fity,fitz,'b')
axis equal

% saving the spline data in meters and changing the direction of z axis
exp_data = [fitx' fity' -fitz']*1e-3;
save('data12_0.mat','exp_data')