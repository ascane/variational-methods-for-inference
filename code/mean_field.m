function [X] = mean_field(n, eta)
mu = rand(n,n);

T = n*n*20;

for t = 1:T
    i = randi(n,1,2);
    %mu(i(1), i(2)) = 1/(1+exp(-(eta*neighbours(mu,n,i))));
    mu(i(1), i(2)) = sigmoid(eta*(1+neighbours(mu,n,i)));
end

X = rand(n)<mu;

end
