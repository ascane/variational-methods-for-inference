% Gibbs sampling for Ising model
function [X] = Gibbs(n, eta)
    X = rand(n, n);
    X(X > 0.5) = 1;
    X(X <= 0.5) = 0;
    T = n * n * 20;

    for t = 1 : T
        i = randi(n, 1, 2);
        prob = sigmoid(eta * (1 + neighbours(X, n, i)));
        if rand <= prob
            X(i(1), i(2)) = 1;
        else
            X(i(1), i(2)) = 0;
        end
    end
end

