function [A] = log_partition(eta, sigma, mu, n)
s1 = sum(sum(mu));
s2 = sum(sum(mu.*conv2circ(mu)));
A = eta*s1+sigma*s2 + sum(sum(entropy(mu)));
end

function [H] = entropy(x)
H = -(x*log(x) + (1-x)*log(1-x));
H(isnan(H)) = 0;
H(isinf(H)) = 0;
end
