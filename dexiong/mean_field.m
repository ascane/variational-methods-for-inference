function [X] = mean_field(n, sigma, percent)

if nargin <3
    percent = 0.5;
end

mu = rand(n,n);
percent = 1-percent;
mu(mu>percent) = 1;
mu(mu<=percent) = -1;
eta = zeros(n,n);

% percent = 1-percent;
% eta = rand(n,n);
% eta(eta>percent) = 1;
% eta(eta<=percent) = -1;
% mu = zeros(n,n);

% eta = 2*eta - 8*sigma;
% sigma = 4*sigma;

T = n*n*100;

for t = 1:T
    i = randi(n,1,2);
%     mu(i(1), i(2)) = 1/(1+exp(-(eta*neighbours(mu,n,i))));
%     mu(i(1), i(2)) = sigmoid(eta(i(1), i(2)) + sigma * neighbours(mu, n, i));
    aux = eta(i(1), i(2)) + sigma * neighbours(mu, n, i);
    mu(i(1), i(2)) = (1-exp(-aux))/(1+exp(-aux));
end

% (mu+1)/2
X = ones(n,n);
X(rand(n,n) > (mu+1)/2) = -1;
% X(rand(n,n)>mu) = -1;


end