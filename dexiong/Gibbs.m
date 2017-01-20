function [X] = Gibbs(n, sigma, percent)
% Gibbs sampling for Ising model 
if nargin <3
    percent = 0.5;
end

% eta = zeros(n,n);
% X = rand(n,n);
% percent = 1-percent;
% X(X>percent) = 1;
% X(X<=percent) = -1;

percent = 1-percent;
X = ones(n,n)*0.5;
eta = rand(n,n);
eta(eta>percent) = 1;
eta(eta<=percent) = -1;

T = n*n*500;

for t = 1:T
    i = randi(n,1,2);
%     prob = 1/(1+exp(-(mu+sigma*neighbours(X,n,i))));
    prob = sigmoid(eta(i(1), i(2)) + sigma * neighbours(X, n, i));
    if rand <= prob
        X(i(1), i(2)) = 1;
    else
        X(i(1), i(2)) = -1;
    end
end

end

