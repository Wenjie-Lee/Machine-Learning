function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%


% ----- computing J
hypo = X * theta;
% J = J + (sum((hypo - y).^2)) / (2 * m);
pre = hypo - y;
J =  (pre' * pre) / (2 * m);

% ----- add the regularized part
% *** regularized part don`t go the bias unit
theta_reg = [0; theta(2:end, :)];
reg = lambda * sum(theta_reg.^2) / (2 * m);
J = J + reg;

% ----- computing the regularized gradient
grad = (X' * pre + lambda * theta_reg) / m;

% =========================================================================

grad = grad(:);

end
