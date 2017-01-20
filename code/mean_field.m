function [X, A] = mean_field(n, eta, sigma, percent)

if nargin <4
    percent = 0.5;
end
percent = 1-percent;

mu = rand(n,n);
mu(mu>percent) = 1;
mu(mu<=percent) = 0;

eta = 2*eta - 8*sigma;
sigma = 4*sigma;

T = n*n*100;
A = zeros(1, T);

for t = 1:T
    %mu(1, :) = 0;
    %mu(end, :) = 0;
    %mu(:, 1) = 1;
    %mu(:, end) = 1;
    i = randi(n,1,2);
    mu(i(1), i(2)) = sigmoid(eta + sigma * neighbours(mu, n, i));
    %A(t) = log_partition(eta, sigma, mu, n);
end
X = ones(n,n);
X(rand(n,n)>mu) = -1;
end