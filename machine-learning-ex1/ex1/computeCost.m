function J = computeCost(X, y, theta)
%COMPUTECOST Compute cost for linear regression
%   J = COMPUTECOST(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta
%               You should set J to the cost.

%   根据多参数得来的更简洁，更快速的方法
hypothesis = X * theta;
prediction = hypothesis - y;
J = prediction' * prediction / (2 * m);

%   旧方法
% hypothesis = theta(1) * X(:, 1) + theta(2) * X(:, 2);   % 保留hypothesis为一个m×1的向量
% temp1 = (hypothesis - y).^2;                   % 执行（h-y）^2，得到一个m×1向量
% temp2 = sum(temp1);                             % 执行Σtemp1
% J = temp2 / (2 * m);

% =========================================================================

end
