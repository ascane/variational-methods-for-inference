function [X] = Gibbs(n, mu, sigma, percent)
% Gibbs sampling for Ising model 
if nargin <4
    percent = 0.5;
end

X = rand(n,n);
percent = 1-percent;
X(X>percent) = 1;
X(X<=percent) = -1;
T = n*n*50;

for t = 1:T
    i = randi(n,1,2);
%     prob = 1/(1+exp(-(mu+sigma*neighbours(X,n,i))));
    prob = sigmoid(mu + sigma * neighbours(X, n, i));
    if rand <= prob
        X(i(1), i(2)) = 1;
    else
        X(i(1), i(2)) = -1;
    end
end

end

