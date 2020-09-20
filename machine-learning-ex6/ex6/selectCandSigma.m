%% selectCandSigma: select the best C and sigma from given vector
function [errors] = selectCandSigma(C_list, sigma_list, X, y, Xval, yval)

m = size(C_list);
n = size(sigma_list);

% output parameters below
errors = ones(m, n);

for i = 1:m
    for j = 1:n
        % SVM Parameters
        fprintf('\nTraining SVM, C = %d sigma = %d\n', C_list(i), sigma_list(j));

        figure(1);
        model= svmTrain(X, y, C_list(i), @(x1, x2) gaussianKernel(x1, x2, sigma_list(j)));
        visualizeBoundary(X, y, model);

        % check the accuracy of prediction using the cross validation dataset
        predictions = svmPredict(model, Xval);
        ierror = mean(double(predictions ~= yval));

        % save picture
        % picName = [pwd '\\pictures\\' 'C' C_list(i) 'sigma' sigma_list(j) '.png']
        picname = strcat("E:\\Octave Programming\\Machine-Learning\\machine-learning-ex6\\ex6", "\\pictures\\", "C", num2str(C_list(i), 10), "sigma", num2str(sigma_list(j), 10), ".png");
        print (1, picname);
        errors(i, j) = ierror;

        fprintf('\nindex: %d\n', j + (i-1)*j);
        fprintf('(C = %d sigma = %d) error = %d\n', C_list(i), sigma_list(j), ierror);
        close all;

    end
end

end