function [X] = mean_field(n, eta, sigma, percent)

if nargin <4
    percent = 0.5;
end

mu = rand(n,n);
percent = 1-percent;
mu(mu>percent) = 1;
mu(mu<=percent) = -1;

T = n*n*50;

for t = 1:T
    i = randi(n,1,2);
%     mu(i(1), i(2)) = 1/(1+exp(-(eta*neighbours(mu,n,i))));
%     mu(i(1), i(2)) = sigmoid(eta + sigma * neighbours(mu, n, i));
    aux = eta + sigma * neighbours(mu, n, i);
    mu(i(1), i(2)) = (1-exp(-aux))/(1+exp(-aux));
end

X = ones(n,n);
X(rand(n,n) > (mu+1)/2) = -1;


end