function [X, A] = mean_field(n, eta, sigma)
    A = [];
    mu = rand(n, n);
    kernel = [0,1,0;1,0,1;0,1,0];
    T = 1000;
    for t = 1 : T
        mu = sigmoid(eta + sigma*conv2(mu, kernel, 'same'));
        A = [A, log_partition(eta, mu, n)];
    end
    X = rand(n) < mu;
end
