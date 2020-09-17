%% shuffle: shuffle the dataset(X, y)
function [Xs, ys] = shuffle(X, y)

    m = size(X, 1);

    Xs = X;
    ys = y;
    for i = 1:m
<<<<<<< Updated upstream
        k = round(rand() * m);
=======
        k = round(rand() * (m-1)) + 1;
>>>>>>> Stashed changes
        Xs(i, :) = Xs(k, :);
        Xs(k, :) = X(i, :);
        ys(i) = ys(k);
        ys(k) = y(i);
    end

end
