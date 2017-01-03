function [X, A] = mean_field(n, eta)
    A = [];
    mu = rand(n, n);
    T = n * n * 20;
    for t = 1 : T
        i = randi(n, 1, 2);
        mu(i(1), i(2)) = sigmoid(eta * (1 + neighbours(mu, n, i)));
        A = [A, log_partition(eta, mu, n)];
    end
    X = rand(n) < mu;
end
