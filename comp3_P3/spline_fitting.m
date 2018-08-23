% Fit a 3D spline to the experimental data
clear all
clc


% Microscribe raw data (i.e coordinate rotated and shifted ) 
exp = [9.3441 71.0645 511.3866
10.2772 57.9669 429.6415
12.4388 26.6006 354.7503
-2.4855 -24.3344 295.1313
-48.7837 -85.0059 260.9434
-112.2526 -121.3162 257.4647
];

% rotation and shifting the center
exp = (exp-exp(1,:))*rotz(0);

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
save('P3data16_40.mat','exp_data')