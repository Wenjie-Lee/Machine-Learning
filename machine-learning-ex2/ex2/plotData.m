function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%

pos = find(y == 1);         %   找到所有y=1的点的索引
neg = find(y == 0);

plot(X(pos, 1), X(pos, 2), 'k+', 'LineWidth', 2, 'MarkerSize', 7); %   X是数据
plot(X(neg, 1), X(neg, 2), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 7);

xlabel('Exam1 score');
ylabel('Exam2 score');

legend('Admitted', 'Not admitted');
legend("boxoff");       % 'boxoff' 去除边线
title("Scatter plot of training data");

% =========================================================================



hold off;

end
