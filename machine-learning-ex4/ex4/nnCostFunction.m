function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% -------------------------computing the activations

% X 5000*400, y 5000*1
% input layer
% a1 401*5000 include the bias unit
a1 = [ones(1, m); X'];

% hidden layer
% Theta1 25*401
% z2, a2 (25+1)*5000 include the bias unit
z2 = [ones(1, m); Theta1 * a1];
a2 = sigmoid(z2);
a2 = [ones(1, m); a2(2:end, :)];

% Theta2 10*26, a3 10*5000
z3 = Theta2 * a2;
a3 = sigmoid(z3);

% output layer
% hypo == a3' 5000*10
hypo = a3';

% transfer y(5000*1) to Y(5000*10)
% 原来的y是以10进制表示0~9，要转换为用1*10向量表示数字
Y = zeros(m, num_labels);
for i = 1:m
    Y(i, y(i)) = 1;
end

% -------------------------Part1: computing J

for i = 1:m
    for k = 1:num_labels
        yik = Y(i, k);
        J = J + (-yik * log(hypo(i, k)) - (1 - yik) * log(1 - hypo(i, k)));
    end
end

J = J / m;

% -----regularizing
Theta1_reg = [zeros(hidden_layer_size, 1), Theta1(:, 2:end)];
Theta2_reg = [zeros(num_labels, 1), Theta2(:, 2:end)];
reg = (sum(sum(Theta1_reg .^2)) + sum(sum(Theta2_reg .^2))) * lambda / (2 * m);

J = J + reg;

% -------------------------Part2: computing backpropagation part

D1 = zeros(size(Theta1));
D2 = zeros(size(Theta2));

% -----step 1------
% z2 has bias unit in line 75

% -----step 2------
% delta3 10*5000
delta3 = a3 - Y';
% disp(sprintf('delta3 is a %d*%d matrix', size(delta3, 1), size(delta3, 2)))

% -----step 3------ Vectorized
% theta2' 26*10, z2 10*5000
temp = Theta2' * delta3;
delta2 = temp .* sigmoidGradient(z2);
% disp(sprintf('temp is a %d*%d matrix', size(temp, 1), size(temp, 2)))
% disp(sprintf('z2 is a %d*%d matrix', size(z2, 1), size(z2, 2)))
% disp(sprintf('delta2 is a %d*%d matrix', size(delta2, 1), size(delta2, 2)))

% -----step 4------
delta2 = delta2(2:end, :);
% disp(sprintf('delta2 is a %d*%d matrix', size(delta2, 1), size(delta2, 2)))
D2 = D2 + delta3 * a2';
D1 = D1 + delta2 * a1';

% -----step 5------
Theta2_grad = D2 / m;
Theta1_grad = D1 / m;

% Regularizing

Theta1_grad = Theta1_grad + lambda * Theta1_reg / m;
Theta2_grad = Theta2_grad + lambda * Theta2_reg / m;


% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
