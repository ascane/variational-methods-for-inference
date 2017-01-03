function [A] = log_partition(eta, mu, n)
s1 = sum(mu);
s2 = 0;
for i = 1:n
    for j = 1:n
        if i+1 <= n
            s2 = s2 + mu(i, j)*mu(i+1, j);
        end
        if j+1 <= n
            s2 = s2 + mu(i, j)*mu(i, j+1);
        end
    end
end
A = eta*(s1+s2) + sum(entropy(mu));
end

function [H] = entropy(x)
H = -(x*log(x) + (1-x)*log(1-x));
end
