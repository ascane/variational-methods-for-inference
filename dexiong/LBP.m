function [X] = LBP(n, mu, sigma, percent, damp)
% loopy belief propagation for Ising model
% damp is the damping parameter used in message update
% X = rand(n,n);
if nargin <4
    percent = 0.5;
    damp = 1;
end

if nargin <5
    damp = 1;
end

percent = 1-percent;

messages = rand(n,n,4,2);
messages(messages>percent)=exp();
% messages(messages<=percent)=rand();
% messages = 

T = 10;

for t = 1:T
    message_left = ones(n, n, 2);
    message_left(:, 2:n, 1) = exp(-mu+sigma)*prod(messages(:, 1:(n-1), :, 1), 3)./ messages(:, 1:(n-1), 3, 1);
    message_left(:, 2:n, 1) = message_left(:, 2:n, 1) + ...
        exp(mu-sigma)* prod(messages(:, 1:(n-1), :, 2), 3)./ messages(:, 1:(n-1), 3, 2);
    message_left(:, 2:n, 2) = exp(-mu-sigma)*prod(messages(:, 1:(n-1), :, 1), 3)./ messages(:, 1:(n-1), 3, 1);
    message_left(:, 2:n, 2) = message_left(:, 2:n, 2) + ...
        exp(mu+sigma)* prod(messages(:, 1:(n-1), :, 2), 3)./ messages(:, 1:(n-1), 3, 2);
%     message_left(:,:,1)
    
    message_top = ones(n, n, 2);
    message_top(2:n, :, 1) = exp(-mu+sigma)*prod(messages(1:(n-1), :, :, 1), 3)./ messages(1:(n-1), :, 4, 1);
    message_top(2:n, :, 1) = message_top(2:n, :, 1) + ...
        exp(mu-sigma)* prod(messages(1:(n-1), :, :, 2), 3)./ messages(1:(n-1), :, 4, 2);
    message_top(2:n, :, 2) = exp(-mu-sigma)*prod(messages(1:(n-1), :, :, 1), 3)./ messages(1:(n-1), :, 4, 1);
    message_top(2:n, :, 2) = message_top(2:n, :, 2) + ...
        exp(mu+sigma)* prod(messages(1:(n-1), :, :, 2), 3)./ messages(1:(n-1), :, 4, 2);
    
    message_right = ones(n, n, 2);
    message_right(:, 1:(n-1), 1) = exp(-mu+sigma)*prod(messages(:, 2:n, :, 1), 3)./ messages(:, 2:n, 1, 1);
    message_right(:, 1:(n-1), 1) = message_right(:, 1:(n-1), 1) + ...
        exp(mu-sigma)* prod(messages(:, 2:n, :, 2), 3)./ messages(:, 2:n, 1, 2);
    message_right(:, 1:(n-1), 1) = exp(-mu-sigma)*prod(messages(:, 2:n, :, 1), 3)./ messages(:, 2:n, 1, 1);
    message_right(:, 1:(n-1), 1) = message_right(:, 1:(n-1), 2) + ...
        exp(mu+sigma)* prod(messages(:, 2:n, :, 2), 3)./ messages(:, 2:n, 1, 2);
    
    message_bottom = ones(n, n, 2);
    message_bottom(1:(n-1), :, 1) = exp(-mu+sigma)*prod(messages(2:n, :, :, 1), 3)./ messages(2:n, :, 2, 1);
    message_bottom(1:(n-1), :, 1) = message_bottom(1:(n-1), :, 1) + ...
        exp(mu-sigma)* prod(messages(2:n, :, :, 2), 3)./ messages(1:(n-1), :, 2, 2);
    message_bottom(1:(n-1), :, 2) = exp(-mu-sigma)*prod(messages(2:n, :, :, 1), 3)./ messages(2:n, :, 2, 1);
    message_bottom(1:(n-1), :, 2) = message_bottom(1:(n-1), :, 2) + ...
        exp(mu+sigma)* prod(messages(2:n, :, :, 2), 3)./ messages(2:n, :, 2, 2);
    
    messages(:,:,1,:) = (1-damp)*squeeze(messages(:,:,1,:)) + damp*message_left;
    messages(:,:,2,:) = (1-damp)*squeeze(messages(:,:,2,:)) + damp*message_top;
    messages(:,:,3,:) = (1-damp)*squeeze(messages(:,:,3,:)) + damp*message_right;
    messages(:,:,4,:) = (1-damp)*squeeze(messages(:,:,4,:)) + damp*message_bottom;
    messages(:,:,1,:) = messages(:,:,1,:)./repmat(sum(messages(:,:,1,:),4), 1,1,1,2);
    messages(:,:,2,:) = messages(:,:,2,:)./repmat(sum(messages(:,:,2,:),4), 1,1,1,2);
    messages(:,:,3,:) = messages(:,:,3,:)./repmat(sum(messages(:,:,3,:),4), 1,1,1,2);
    messages(:,:,4,:) = messages(:,:,4,:)./repmat(sum(messages(:,:,4,:),4), 1,1,1,2);
%     aux = sum(exp(mu)*squeeze(prod(messages, 3)),3);
%     aux(10,10, :)
%     messages(:,:,1,1)
end

X = squeeze(prod(messages, 3));
X = exp(mu)*X(:,:,2)./(exp(mu)*X(:,:,2)+exp(-mu)*X(:,:,1));
% X
X = rand(n)<X;