%% =========== Part 9: Lambda = 3, predict the test examples =============

fprintf('***ex5expand***\n');

lambda = 3;
[theta] = trainLinearReg(X_poly, y, lambda);

% Plot training data and fit
figure(1);
plot(X, y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
plotFit(min(X), max(X), mu, sigma, theta, p);
xlabel('Change in water level (x)');
ylabel('Water flowing out of the dam (y)');
title (sprintf('Polynomial Regression Fit (lambda = %f)', lambda));

figure(2);
[error_train, error_val] = ...
    learningCurve(X_poly, y, X_poly_val, yval, lambda);
plot(1:m, error_train, 1:m, error_val);

title(sprintf('Polynomial Regression Learning Curve (lambda = %f)', lambda));
xlabel('Number of training examples')
ylabel('Error')
axis([0 13 0 100])
legend('Train', 'Cross Validation')

% 最后应用训练好的模型（***lambda=0，因为这是检验数据，不用再正则化）
% 于testdata上，并检测预测的准确性
error_test =linearRegCostFunction(X_poly_test, ytest, theta, 0);

fprintf(['Cost: %f '...
         '\n(this value should be about 3.8599 )\n'], error_test);

fprintf('Program paused. Press enter to continue.\n');
pause;