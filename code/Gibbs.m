% Gibbs sampling for Ising model
function [X] = Gibbs(n, eta, sigma)
    kernel = [0,1,0;1,0,1;0,1,0];
    X = rand(n, n);
    X(X > 0.5) = 1;
    X(X <= 0.5) = 0;
    T = 100;
    for t = 1 : T
        prob = sigmoid(eta + sigma*conv2(X, kernel, 'same'));
        X = double(rand(n) <= prob);
    end
end

