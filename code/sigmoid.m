function [y] = sigmoid(x)
    y = 1.0 ./ (1 + exp(-x));
end
