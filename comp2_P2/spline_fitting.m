% Fit a 3D spline to the experimental data
clear all
clc


% Microscribe raw data (i.e coordinate rotated and shifted ) 
exp = [4.4328 68.5683 498.3981
8.3028 57.2394 417.7569
6.3978 28.6472 343.0528
-18.8061 -14.2919 279.5476
-69.6620 -59.2872 240.2609
-140.4634 -92.6826 227.9823
];

% rotation and shifting the center
exp = (exp-exp(1,:))*rotz(-10);

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
save('P2data25_30.mat','exp_data')