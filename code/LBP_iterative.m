function [X, A] = LBP_iterative(n, mu, sigma, damp)
% loopy belief propagation for Ising model
% damp is the damping parameter used in message update
% X = rand(n,n);
messages = ones(n,n,4,2)*0.5;

T = 10;

M = [1 exp(mu); 1 exp(mu+sigma)]';

A = ones(1, T*n*n);
count =1 ;
for t = 1:T
    for i = 1:n
        for j = 1:n
            if j > 1
                message_left = squeeze(prod(messages(i, j-1, :, :), 3)./ messages(i, j-1, 3, :));
                message_left = message_left' *M;
            else
                message_left = ones(1,2);
            end
            if i > 1
                message_top = squeeze(prod(messages(i-1, j, :, :), 3)./ messages(i-1, j, 4, :));
                message_top = message_top' *M;
            else
                message_top = ones(1,2);
            end
            if j <n
                message_right = squeeze(prod(messages(i, j+1, :, :), 3)./ messages(i, j+1, 1, :));
                message_right = message_right'*M;
            else
                message_right = ones(1,2);
            end
            if i < n
                message_bottom = squeeze(prod(messages(i+1, j, :, :), 3)./ messages(i+1, j, 2, :));
                message_bottom = message_bottom' *M;
            else
                message_bottom = ones(1,2);
            end
            %normalization
            message_left = (1-damp)*squeeze(messages(i,j,1,:)) + damp* message_left';
            message_top = (1-damp)*squeeze(messages(i,j,2,:)) + damp*message_top';
            message_right = (1-damp)*squeeze(messages(i,j,3,:)) + damp*message_right';
            message_bottom = (1-damp)*squeeze(messages(i,j,4,:)) + damp*message_bottom';
            message_left = message_left ./ sum(message_left);
            message_right = message_right ./ sum(message_right);
            message_top = message_top ./ sum(message_top);
            message_bottom = message_bottom ./ sum(message_bottom);
            messages(i,j,1,:) = message_left;
            messages(i,j,2,:) = message_top;
            messages(i,j,3,:) = message_right;
            messages(i,j,4,:) = message_bottom;
            aux = sum(exp(mu)*squeeze(prod(messages, 3)),3);
            A(count) = aux(i,j, :);
            count = count+1;
        end
    end
end

X = exp(mu)*squeeze(prod(messages, 3));
X = X(:,:,2)./sum(X,3);
% X
X = rand(n)<X;