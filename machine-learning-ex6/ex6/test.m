%% Initialization
clear ; close all; clc

% Load from ex6data3: 
% You will have X, y,Xval, yval in your environment
load('ex6data3.mat');

% try with multiplicative steps
C = [0.01 0.03 0.1 0.3 1 3 10 30]';
sigma = [0.01 0.03 0.1 0.3 1 3 10 30]';

[errors] = selectCandSigma(C, sigma, X, y, Xval, yval);

fprintf('Program paused. Press enter to continue.\n');
pause;
